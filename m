Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275047AbRIYPgR>; Tue, 25 Sep 2001 11:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275048AbRIYPgI>; Tue, 25 Sep 2001 11:36:08 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:28937 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S275046AbRIYPf7>; Tue, 25 Sep 2001 11:35:59 -0400
Message-Id: <200109251535.f8PFZVY03436@aslan.scsiguy.com>
To: david@spanware.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic New Adaptec - Old Adaptec Works 
In-Reply-To: Your message of "Mon, 24 Sep 2001 23:34:26 EDT."
             <20010925033318Z274451-760+16507@vger.kernel.org> 
Date: Tue, 25 Sep 2001 09:35:31 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>I am running a dual PIII 933 VIA based motherboard (Gigabyte 6VXDC7). 
>I have two Seagate Cheetah HDs, and two SCSI cdroms.  There are no IDE 
>devices anywhere in the system, and no support is compiled in the kernel or 
>as a module for IDE.
>
>Kernel 2.4.7 works perfectly.  I cannot get 2.4.10 to work with the new aha 
>driver compiled into the kernel.  Below is what I was able to capture of the 
>output 

You need to disable all of the "speed up my PCI bus even though it violates
the spec) options in your BIOS.  The old driver issues a PCI read after
every device write to overcome such silliness in broken BIOSes/chipsets.
The new driver only issues a read (to flush writes) when synchronization
is required.  The workaround used in the old driver has too high of a 
performance penalty which is why the new driver does not do it.

--
Justin
