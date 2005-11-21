Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVKUTG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVKUTG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVKUTG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:06:56 -0500
Received: from msgbas9x.lvld.agilent.com ([192.25.144.41]:8139 "EHLO
	msgbas9x.lvld.agilent.com") by vger.kernel.org with ESMTP
	id S932445AbVKUTGz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:06:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: question about driver built-in kernel
Date: Mon, 21 Nov 2005 12:06:52 -0700
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC501A31918@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question about driver built-in kernel
Thread-Index: AcXszW008lTovCOIQ2SlMybyLXrT/ACAOfdg
From: <yiding_wang@agilent.com>
To: <greg@kroah.com>, <yiding_wang@agilent.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Nov 2005 19:06:53.0002 (UTC) FILETIME=[BBB852A0:01C5EECE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Thanks for the support and prompt response. I figure it out the problem is endianess. I worked everything on x86 based system and copied files to PPC system. Somehow I forgot to change the endianess define in my makefile. Now everything works fine!

Again, relay appreciate your help!

Eddie

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Friday, November 18, 2005 9:37 PM
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about driver built-in kernel

On Fri, Nov 18, 2005 at 06:57:38PM -0700, yiding_wang@agilent.com wrote:
> Thanks Greg! 
> 
> Got everything straighten up.
>  
> 1, replaced init_module() by __init init_module to avoid kernel build conflict.
> 2, arranged correct sequence in Makefile to load two drivers in proper order.
> 
> Now it looks the pci bus register accessing has problem. If loaded as
> module, everything works fine. If build in kernel, it always failed at
> the spot driver resetting the chip through register during the kernel
> loading. It seems the pci base address mapping or something related
> has problem. Is there any difference for ioremap call between the
> kernel loading and after system is up? Is anything special on pci
> device register accessing during the kernel booting, compare with
> after system boot up?

Do you have a pointer to your source code, so we can look at it to see
what is wrong?

thanks,

greg k-h
