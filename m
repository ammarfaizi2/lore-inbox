Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUBYUlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUBYUk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:40:56 -0500
Received: from mail0.lsil.com ([147.145.40.20]:10369 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261461AbUBYUki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:40:38 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC3E7@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: RE: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al
	pha1
Date: Wed, 25 Feb 2004 15:38:48 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> given that they are completely different from the controller we know
> as megaraid today this is an extremly bad idea.  Just put it 
> into an driver
> of their own, e.g. mptraid
Although, this simplifies the development and maintenance effort, having a
single driver to drive both controllers or two independent drivers is not
always our decision. Most often, it would be Dell's preference. 

> 
> > 2.	Controller and device re-ordering on both lk 2.4 and lk 
> 2.6. If this
> > is not desired, the driver code would be modified to make 
> it PCI ordered
> > detection. The driver also re-orders the drives, based on 
> which one is
> > chosen as boot drive. Matt, please add your comments here.
> 
> This is a bad thing for 2.6, don't do it.  For 2.4 just leave 
> the probe code as
> it is there currently - any change during the stable series 
> just confuses
> users.

So it would be. We would make the controller and devices detection PCI
ordered for 2.6 and preferred ordered for lk 2.4. A patch for unified-alpha1
would be posted for this change soon.


> 
> > 4.	Native hot-plug support for both lk 2.4 and lk 2.6
> 
> hotplug scsi in 2.4 is impossible without a host template per 
> controller
> which you don't seem to do and I'd advice against.
> 
> > 6.	Single code to support *all* x86-32, IA64, and x86-64 platforms
> 
> Umm, it's a PCI card - if it doesn't work on any PCI 
> supporting architecture
> it's a driver bug (either in your driver or the architectures 
> PCI subsysyem)
Currently, IA64 has only 1.18 series of drivers as supported ones. 2.x
driver is not tested on this platform.
