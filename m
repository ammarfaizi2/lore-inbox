Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTKOAAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 19:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTKOAAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 19:00:07 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:23995 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S264339AbTKOAAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 19:00:01 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 18:59:59 -0500
User-Agent: KMail/1.5.1
Cc: "Patrick Beard" <patrick@scotcomms.co.uk>, linux-kernel@vger.kernel.org
References: <20031114113224.GR21265@home.bofhlet.net> <200311140945.36537.gene.heskett@verizon.net> <20031114202339.GB18107@win.tue.nl>
In-Reply-To: <20031114202339.GB18107@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311141859.59669.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.12.17] at Fri, 14 Nov 2003 18:00:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 November 2003 15:23, Andries Brouwer wrote:
>On Fri, Nov 14, 2003 at 09:45:36AM -0500, Gene Heskett wrote:
>> Nov 14 09:19:51 coyote kernel: hub 3-2:1.0: new USB device on port
>> 3, assigned address 9 Nov 14 09:19:51 coyote kernel: scsi4 : SCSI
>> emulation for USB Mass Storage devices Nov 14 09:19:52 coyote
>> kernel:   Vendor: OLYMPUS   Model: C-3020ZOOM(U)     Rev: 1.00 Nov
>> 14 09:19:52 coyote kernel:   Type:   Direct-Access                
>>      ANSI SCSI revision: 02 Nov 14 09:19:52 coyote kernel: SCSI
>> device sda: 128000 512-byte hdwr sectors (66 MB) Nov 14 09:19:52
>> coyote kernel: sda: assuming drive cache: write through Nov 14
>> 09:19:52 coyote kernel:  sda: sda1
>> Nov 14 09:20:34 coyote kernel: FAT: Filesystem panic (dev sda1)
>> Nov 14 09:20:34 coyote kernel:     fat_free: deleting beyond EOF
>> (i_pos 0) Nov 14 09:20:34 coyote kernel:     File system has been
>> set read-only
>>
>> Comments?  Screwed up kernel .config? Is mount "-t vfat" the
>> correct filesystem?
>
>It would have been interesting to see the filesystem after this
> error message. Can you reproduce the error?
>
>(vfat? I don't know - most cameras just use msdos, but vfat doesnt
> harm, I suppose)
>
>The error message means that the fatfs followed a chain of clusters
> in order to delete them all and found a free cluster before finding
> an end-of-file mark.

And I could possibly have created that empty sector by not treating 
the card as a LIFO I suppose...  Makes a certain amount of sense, but 
why did a powerdown and a reconnect fix it?  Some compacting routine 
in the cameras soft maybe?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

