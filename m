Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUESHNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUESHNA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 03:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUESHNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 03:13:00 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:63946 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264101AbUESHLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 03:11:34 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: [2.6.6] eepro100 vs e100?
Date: Wed, 19 May 2004 07:11:31 +0000 (UTC)
Organization: Cistron
Message-ID: <c8f1b3$fvv$1@news.cistron.nl>
References: <200405190858.44632.lkml@kcore.org>
X-Trace: ncc1701.cistron.net 1084950691 16383 62.216.30.38 (19 May 2004 07:11:31 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan De Luyck  <lkml@kcore.org> wrote:
>I'm wondering what driver is the "best" one to use? Judging by the comments in 
>the files, the e100 driver seems to be the best maintained, though I'm 
>probably wrong ;p

We have a usenet server we use with 2.6.6 kernel and the eepro100 gives
IRQ problems:

May 16 01:35:58 enterprise kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
May 16 01:35:58 enterprise kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
May 16 01:35:58 enterprise kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 00:90:27:BE:B6:85, IRQ 18.
May 16 01:35:58 enterprise kernel:   Board assembly 734938-001, Physical connectors present: RJ45
May 16 01:35:58 enterprise kernel:   Primary interface chip i82555 PHY #1.
May 16 01:35:58 enterprise kernel:   General self-test: passed.
May 16 01:35:58 enterprise kernel:   Serial sub-system self-test: passed.
May 16 01:35:58 enterprise kernel:   Internal registers self-test: passed.
May 16 01:35:58 enterprise kernel:   ROM checksum self-test: passed (0x04f4518b).
May 16 01:35:58 enterprise kernel: eth0: freeing mc frame.
May 16 01:47:12 enterprise kernel: eth0: TX underrun, threshold adjusted.
May 16 01:47:27 enterprise last message repeated 26 times

Where as the e100 is rocksolid (knock wood) under sometimes heavy load:

Linux 2.6.6-bk2 (root@enterprise) (gcc 3.3.3 ) #1 Sun May 16 10:50:59 CEST 2004 1CPU [enterprise.cistron.nl]

Memory:      Total        Used        Free      Shared     Buffers      
Mem:       1037228     1031548        5680           0      624540
Swap:      1027144        9424     1017720

Bootup: Sun May 16 11:34:58 2004    Load average: 1.88 1.77 1.69 5/87 9230

user  :       6:03:53.43   8.7%  page in :        0
nice  :       0:51:24.39   1.2%  page out:        0
system:       9:22:34.92  13.5%  swap in :        0
idle  :      12:48:17.34  18.4%  swap out:        0
uptime:   2d 21:35:04.35         context :483979334

irq  0: 250377255 timer                 irq 12:         3                      
irq  1:         3                       irq 14:  11055492 ide0                 
irq  3:         2                       irq 15:  11058878 ide1                 
irq  4:       193 serial                irq 16:  27773698 sym53c8xx            
irq  8:         3 rtc                   irq 18: 996592375 eth0                 
irq  9:         0 acpi                  irq 19:  22025755 ide2, ide3    


So _i_ would advise the e100 driver.

Danny 
(personal view etc)

-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

