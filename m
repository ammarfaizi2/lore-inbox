Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbTAGQRE>; Tue, 7 Jan 2003 11:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTAGQRD>; Tue, 7 Jan 2003 11:17:03 -0500
Received: from dt081n53.san.rr.com ([204.210.23.83]:42375 "EHLO
	vortex.ottix.com") by vger.kernel.org with ESMTP id <S267547AbTAGQRC>;
	Tue, 7 Jan 2003 11:17:02 -0500
Message-ID: <3E1AFF81.5040705@san.rr.com>
Date: Tue, 07 Jan 2003 08:25:37 -0800
From: Matthew Costello <mattc@san.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: charlton@dynet.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19 & 2.4.20 hang without oops...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just run in to a similar problem with 2.4.20.
The system hangs using 2.4.20, and everything is
fine with 2.4.18-10bigmem (rh73).

Points of similarity:

Dual (SMP) P3-450, supermicro (BX) motherboard
kernel 2.4.20
red hat (7.3 w/ updates)

Differences:

no IDE
main disks on AHA2940U2W
Firewire (aua-3121) or scsi AHA-1542

I've found two separate hangs.  The most interesting is that I have
two (different) firewire disks.  I can access either of the disks all
day, but as soon as I access both at the same time the system hangs.
I am unable to test this on 2.4.18 as one of the firewire disks
(WD 200GB) is not recognized correctly under 2.4.18, which is
why I am running 2.4.20 in the first place.

The second hang seems related to ejecting an audio cd-rom from
a CD-RW attached to its private AHA-1542 scsi controller.

Both hangs are "hard" without any sort of output to the console.
I also lose the console echo.  I'd guess that I'm running into a
SMP deadlock.

--- Matthew Costello <mattc@san.rr.com>

