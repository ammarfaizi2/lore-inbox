Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932822AbWKJJxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbWKJJxr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbWKJJxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:53:46 -0500
Received: from ozlabs.org ([203.10.76.45]:49597 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932822AbWKJJxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:53:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17748.19234.278295.476881@cargo.ozlabs.ibm.com>
Date: Fri, 10 Nov 2006 20:49:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       Nicolas DET <nd@bplan-gmbh.de>, Steve Fox <drfickle@us.ibm.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1 -- ppc64 ohci-hdc.c compile failure
In-Reply-To: <1163112227.4982.44.camel@localhost.localdomain>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<4553436D.30601@shadowen.org>
	<1163112227.4982.44.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> > Seems that the patch below has introduced USB_OHCI_HCD_PPC_OF enabled by
> > default.  When it and CONFIG_USB_OHCI_HCD_PPC_SOC are enabled which
> > occured by default on my config then we end up with two module_init()
> > calls, which is illegal.
> > 
> >   powerpc-add-of_platform-support-for-ohci-bigendian-hc
> > 
> > I am guessing that we are only meant to be able to have one of these
> > defined at a time?  I changed the default to n for this and I could at
> > least compile the kernel, but I am sure thats not the right fix.
> 
> Paul, which patch did you merge ? I rejected the initial one that was
> doing 2 drivers/probe routines and Nicolas did a new one.. You may have
> taken the wrong one.

I didn't merge either of them.

Paul.
