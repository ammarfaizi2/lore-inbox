Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424214AbWKIWoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424214AbWKIWoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424213AbWKIWoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:44:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:21939 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1424216AbWKIWoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:44:04 -0500
Subject: Re: 2.6.19-rc5-mm1 -- ppc64 ohci-hdc.c compile failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, Nicolas DET <nd@bplan-gmbh.de>,
       Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4553436D.30601@shadowen.org>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	 <4553436D.30601@shadowen.org>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 09:43:47 +1100
Message-Id: <1163112227.4982.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Seems that the patch below has introduced USB_OHCI_HCD_PPC_OF enabled by
> default.  When it and CONFIG_USB_OHCI_HCD_PPC_SOC are enabled which
> occured by default on my config then we end up with two module_init()
> calls, which is illegal.
> 
>   powerpc-add-of_platform-support-for-ohci-bigendian-hc
> 
> I am guessing that we are only meant to be able to have one of these
> defined at a time?  I changed the default to n for this and I could at
> least compile the kernel, but I am sure thats not the right fix.

Paul, which patch did you merge ? I rejected the initial one that was
doing 2 drivers/probe routines and Nicolas did a new one.. You may have
taken the wrong one.

Cheers.
Ben.

