Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286290AbRLTQa3>; Thu, 20 Dec 2001 11:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286287AbRLTQaU>; Thu, 20 Dec 2001 11:30:20 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:44555 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S286289AbRLTQaH>; Thu, 20 Dec 2001 11:30:07 -0500
From: "" <simon@baydel.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 20 Dec 2001 12:22:33 -0000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: raw devices
Message-ID: <3C21D809.6787.13E19F@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been performing some tests on raw devices, the results of 
which I do not understand. I have 4 FC busses, each with one  
SCSI disk, connect to a Linux system running 2.4.16. I use the raw 
command to bind /dev/raw1 - /dev/raw4 to each of the devices. 
With one process per raw device, running large sequential reads, I 
got a total throughput  of 340 Megabytes per second. I also 
observed 85% CPU idle. Following this I performed some more 
tests and then returned to this one. This time the total had gone 
down to 180 and there was no free CPU. I realized that the first 
time I ran the tests, each of the disks that the raw devices were 
mapped to were mounted. I then verified that this data was being 
transferred along the FC bus using an analyzer while the devices 
were mounted. Can anyone explain this to me ? I find it hard to 
believe that the disk should be permitted to be mounted when 
using raw device mappings. If the disks should not be mounted 
why is there such a great performance difference ?

Many Thanks

Simon.
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
