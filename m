Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312817AbSDXX03>; Wed, 24 Apr 2002 19:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSDXX03>; Wed, 24 Apr 2002 19:26:29 -0400
Received: from s2.org ([195.197.64.39]:59291 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id <S312817AbSDXX01>;
	Wed, 24 Apr 2002 19:26:27 -0400
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 - HPT366 ide unexpected interrupts
In-Reply-To: <3CC5BAA3.3080705@wanadoo.fr>
From: Jarno Paananen <jpaana@s2.org>
Date: 25 Apr 2002 02:26:25 +0300
Message-ID: <m3u1q0smou.fsf@kalahari.s2.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:

| PIII 650/Abit BE6 HPT366(ide2, ide3)
| 
| dmesg gives 482 times the same line :
| ide: unexpected interrupt 0 11
| 
| sylogd logs the same :
| ide: unexpected interrupt 0 11
| last message repeated 1820 times
| last message repeated 4251 times
| last message repeated 272 times
| last message repeated 69 times
| 
| # cat /proc/interrupts
|             CPU0
|    0:     166782          XT-PIC  timer
|    1:       6631          XT-PIC  keyboard
|    2:          0          XT-PIC  cascade
|    8:          0          XT-PIC  rtc
|    9:       4456          XT-PIC  Ensoniq AudioPCI, usb-uhci
|   10:          0          XT-PIC  eth0
|   11:      10854          XT-PIC  ide2, ide3
|   12:      30840          XT-PIC  PS/2 Mouse
|   15:          1          XT-PIC  ide1
| NMI:          0
| LOC:     166737
| ERR:          0

I get this same "error" with hpt370 controller (Abit KT7A-RAID),
but only if I have more than one disk attached. I recently added a
second disk to the second controller and got this since. Everything
seems to work ok so it might be only something the ide-driver
doesn't understand when one chip has two ide-busses sharing the
same interrupt. I commented the printk out from ide.c and haven't
had any problems with it.

// Jarno
