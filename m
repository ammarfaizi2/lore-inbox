Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946004AbWKJHCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946004AbWKJHCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 02:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946006AbWKJHCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 02:02:24 -0500
Received: from mx2.go2.pl ([193.17.41.42]:47314 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1946004AbWKJHCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 02:02:24 -0500
Date: Fri, 10 Nov 2006 08:08:18 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New laptop - problems with linux
Message-ID: <20061110070818.GA995@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Stephen Clark <Stephen.Clark@seclark.us>,
	linux-kernel@vger.kernel.org
References: <20061109083205.GA976@ff.dom.local> <45533658.7030900@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45533658.7030900@seclark.us>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 09:08:24AM -0500, Stephen Clark wrote:
> Jarek Poplawski wrote:
> 
> >On 08-11-2006 15:41, Stephen Clark wrote:
> > 
> >
> >>Hi list,
> >>
> >>I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core 
> >>2 Duo T560,0 2gb pc5400 memory.
> >>From checking around it appeared all the
> >>hardware was well supported by linux - but I am having major problems.
> >>
> >>
> >>1. neither the wireless lan Intel pro 3945ABG or built in ethernet 
> >>RTL-8169C are detected and configured
> >>2. the disk which is a 7200rpm Hitachi travelmate transfers data at 1.xx 
> >>mb/sec
> >>  according to hdparm. This same drive in my old laptop an HP n5430 with a
> >>  850 duron the rate was 12-14 mb/sec.
> >>   
> >>
> >... 
> > 
> >
> >>Kernel command line: ro root=/dev/VolGroup00/LogVol00 ide1=dma ide1=ata66
> >>ide_setup: ide1=dma -- OBSOLETE OPTION, WILL BE REMOVED SOON!
> >>ide_setup: ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
> >>   
> >>
> >
> >Could you repeat the reason for this ides in kernel parameters?
> >Did you try to boot some fresh live-cd distro?
> >
> >Jarek P.
> >
> > 
> >
> Yes, I was trying to get dma turned on for my harddrive.

You can do it with hdparm. But in current kernels it
should be on by default - if not - there is probably
lack of some driver or it is disabled by parameters like
this. So try to get rid of them.

As it was stated in the first reply by Arjan van de Ven
you definitely should have this disk in sata mode and
see it as sda, so try check in your kernel config
Serial ATA... drivers - particulary:
CONFIG_ATA = y
CONFIG_ATA_PIIX = y
and maybe:
CONFIG_ATA_GENERIC = y
CONFIG_PATA_MPIIX = y

(if they are "= mi", you should have initrd properly generated).

Probably you can also do CONFIG_IDE = n in ATA/ATAPI
(it depends on your CD-DVD).
  
> I have booted knoppix 5.1 but didn't check harddrive transfer rate.

If you can see it as sda, transfer should be fine.

Regards,

Jarek P. 
