Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbTFEQZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264747AbTFEQZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:25:17 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:7687 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S264741AbTFEQZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:25:17 -0400
Date: Fri, 6 Jun 2003 02:38:32 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Dave Jones <davej@codemonkey.org.uk>
cc: pam.delaney@lsil.com, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compile fix for MPT Fusion driver for 2.5.70 bk
In-Reply-To: <20030605162901.GA7035@suse.de>
Message-ID: <Mutt.LNX.4.44.0306060231390.2807-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, Dave Jones wrote:

>  > diff -urN -X dontdiff bk.pending/drivers/message/fusion/linux_compat.h bk.w1/drivers/message/fusion/linux_compat.h
>  > --- bk.pending/drivers/message/fusion/linux_compat.h	2003-06-06 00:36:11.000000000 +1000
>  > +++ bk.w1/drivers/message/fusion/linux_compat.h	2003-06-06 01:48:49.000000000 +1000
>  > @@ -147,7 +147,7 @@
>  >  
>  >  
>  >  /* PCI/driver subsystem { */
>  > -#ifndef pci_for_each_dev
>  > +#ifndef pci_for_each_dev_reverse
>  >  #define pci_for_each_dev(dev)		for((dev)=pci_devices; (dev)!=NULL; (dev)=(dev)->next)
> 
> What has _reverse got to do with this define ?

It was a partner to pci_for_each_dev(), which if not defined, required the 
use of (dev)->next rather than pci_dev_g((dev)->global_list.next.

i.e. it's detecting a version of the PCI API.

It is fairly bogus, yes.



- James
-- 
James Morris
<jmorris@intercode.com.au>

