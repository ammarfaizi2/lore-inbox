Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946235AbWKJKAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946235AbWKJKAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbWKJKAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:00:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:33976 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932827AbWKJKAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:00:06 -0500
Subject: Re: 2.6.19-rc5-mm1 -- ppc64 ohci-hdc.c compile failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       Nicolas DET <nd@bplan-gmbh.de>, Steve Fox <drfickle@us.ibm.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <17748.19234.278295.476881@cargo.ozlabs.ibm.com>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	 <4553436D.30601@shadowen.org>
	 <1163112227.4982.44.camel@localhost.localdomain>
	 <17748.19234.278295.476881@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 20:58:44 +1100
Message-Id: <1163152724.4982.159.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 20:49 +1100, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > > Seems that the patch below has introduced USB_OHCI_HCD_PPC_OF enabled by
> > > default.  When it and CONFIG_USB_OHCI_HCD_PPC_SOC are enabled which
> > > occured by default on my config then we end up with two module_init()
> > > calls, which is illegal.
> > > 
> > >   powerpc-add-of_platform-support-for-ohci-bigendian-hc
> > > 
> > > I am guessing that we are only meant to be able to have one of these
> > > defined at a time?  I changed the default to n for this and I could at
> > > least compile the kernel, but I am sure thats not the right fix.
> > 
> > Paul, which patch did you merge ? I rejected the initial one that was
> > doing 2 drivers/probe routines and Nicolas did a new one.. You may have
> > taken the wrong one.
> 
> I didn't merge either of them.

Ah, must be Andrew then. Andrew, can you drop this (along with the other
Efika/MPC5200) patches from -mm ? They'll get in via the powerpc merge
and I'll make sure Paulus gets the right versions.

Cheers,
Ben.


