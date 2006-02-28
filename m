Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWB1TOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWB1TOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWB1TOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:14:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:6602 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932432AbWB1TOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:14:33 -0500
Date: Tue, 28 Feb 2006 20:14:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Sam Vilain <sam@vilain.net>, Luke-Jr <luke@dashjr.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works
 ;)
In-Reply-To: <44049D5A.1010806@cfl.rr.com>
Message-ID: <Pine.LNX.4.61.0602282012480.15391@yvahk01.tjqt.qr>
References: <200602250042.51677.bero@arklinux.org> <200602261330.15709.luke@dashjr.org>
 <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com>
 <200602261339.13821.luke@dashjr.org> <Pine.LNX.4.61.0602262331330.12118@yvahk01.tjqt.qr>
 <440240F8.3010207@vilain.net <Pine.LNX.4.61.0602271946470.13987@yvahk01.tjqt.qr>
 <44049D5A.1010806@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Yes. A 650 MB *CD*-RW (DVD-RW too?) formatted in packet mode only has like
>> 500-something megabytes to allow for the sort of seeks required.
>> On DVD+RW, you get the full 4.3 GB (4.7 gB) AFAICS.
>
> DVD-RAM physically is formatted like a hard disk.  It is broken up into zones
> that hold different numbers of sectors which are individually and randomly
> read/writable.  CD/DVD+-RW media is organized as a single long groove that
> consists of an unbroken series of large blocks composed of small blocks with
> user and control data interleaved and error corrected.  It is for this reason
> that historically it could only be recorded from start to finish in one pass.
>
> There are two modern techniques to allow pseudo random write access for all
> forms of CD/DVD +/- RW media.  These are packet mode, and mount rainier mode.
> MRW mode formats the disk into 32 KB blocks made up of 2048 byte sectors which
> are individually writable as far as the OS knows, because an MRW compliant
> drive is required to internally handle any required read/modify/write cycles to
> update the 32 KB blocks.  MRW mode also reserves some of the disk for sector
> sparing which the drive firmware also handles.  MRW mode is typically used on
> dvd+rw media. IIRC, this format typically "wastes" about 10% of the capacity of
> the medium.
>
I doubt that. 10% of a 4.3 GB disk are, well, roughly 430 MB, which would 
make df show 3.9 GB as mountpoint size, not 4.3 GB. [MB and GB are powers 
of 1024 here.]


Jan Engelhardt
-- 
