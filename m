Return-Path: <linux-kernel-owner+willy=40w.ods.org-S279665AbVBDFDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S279665AbVBDFDF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 00:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S279681AbVBDFDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 00:03:05 -0500
Received: from keaton.csufresno.edu ([129.8.52.178]:37327 "EHLO
	keaton.its.csufresno.edu") by vger.kernel.org with ESMTP
	id S279665AbVBDFC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 00:02:56 -0500
Date: Thu, 03 Feb 2005 21:05:33 -0800
From: Samuel Torres <juicemansam@scccd.org>
Subject: Re: DVD-RW writes but doesn't read
To: linux-kernel@vger.kernel.org
Message-id: <4203029D.50903@scccd.org>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few days ago I installed a brand new OEM AOpen DUW1608/ARR. At 
times while mounting DVDs the drive would lose files between ls's, or 
get I/O errors while ls'ing. I also noticed the same errors you posted 
below. I might have stumbled across a solution to this problem. In my 
BIOS I changed all of the AUTO's in the CD/DVD drive properties and set 
them to CD/DVD (drive type), PIO-4 (PIO MODE), and DMA-4 (DMA MODE). 
This change had an apparent effect which no longer produces such reading 
errors, at least from the 4 reading tests (2 DVD and 2 CD). The 2 DVD 
reads were done with vobcopy, and the CD tests were done with cdrdao, 
and md5sum (checking the Ubuntu files with the CD with the provided 
md5sum.txt, from within the CD, in the DVD drive).

Hope it works.

On Wednesday 22 December 2004 00:33, you wrote:
 > Hi Jens et al
 >
 > I have a laptop DVD-RW that is working fine when burning but has endless
 > streams of errors with any kernel I try when trying to read anything
 > (cd/dvd audio/video/data).
 >
 > hdc: command error: status=0x51 { DriveReady SeekComplete Error }
 > hdc: command error: error=0x50
 > ide: failed opcode was 100
 > end_request: I/O error, dev hdc, sector 571832
 > Buffer I/O error on device hdc, logical block 71479
 >
 > If I'm persistent I can read the data off the drive but I'll probably
 > kill the drive in the process. It doesn't matter what iosched I use but I
 > use cfq by default. I've tried disabling dma and so on without 
success. Any
 > ideas?
 >
 > Con
