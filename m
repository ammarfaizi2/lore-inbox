Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263038AbTCWLrW>; Sun, 23 Mar 2003 06:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbTCWLrW>; Sun, 23 Mar 2003 06:47:22 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:14464 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263035AbTCWLrV>; Sun, 23 Mar 2003 06:47:21 -0500
Date: Sun, 23 Mar 2003 12:57:40 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: Linux 2.5.65-ac2 (drivers/char/genrtc.c compile failure on i386)
Message-ID: <20030323115740.GA1104@localhost>
References: <20030322202201.GA32386@localhost> <Pine.GSO.4.21.0303231155380.9116-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0303231155380.9116-100000@vervain.sonytel.be>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 23rd 2003 at 11:58 uur Geert Uytterhoeven wrote:

> Oops, until last Friday I didn't even know genrtc was used on ia32...
> 
> Anyway, can you please give this a try? I also updated PPC and PA-RISC, the
> other two known users of genrtc I forgot to update.

Ok. It compiles OK now (apart from some warnings for the janitors). I am
currently running 2.6.65-ac3 with it (well actually due to EXTRA_VERSION
still being -ac2 it thinks it is -ac2 ;-) To Alan from my phrase book:
"Peidiwch a gwneud hyn eto - pum punt o ddirwy!)

Only tested on i386, I still haven't decided whether a Power Mac is
worth the extra money, and my last HP machine was years ago ;-)

I don't seem to be a power genrtc user: I had to rmmod rtc before modprobe
genrtc succeeded but it does work:

$ cat /proc/driver/rtc

rtc_time	: 11:49:52
rtc_date	: 2003-03-23
rtc_epoch	: 1900
alarm		: 00:00:00
DST_enable	: no
BCD		: yes
24hr		: yes
square_wave	: no
alarm_IRQ	: no
update_IRQ	: no
periodic_IRQ	: no
periodic_freq	: 0
batt_status	: okay

Thanks, Marco Roeland
