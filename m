Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276576AbRJKQsu>; Thu, 11 Oct 2001 12:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276562AbRJKQsb>; Thu, 11 Oct 2001 12:48:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28722 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S276558AbRJKQsW>; Thu, 11 Oct 2001 12:48:22 -0400
Date: Thu, 11 Oct 2001 18:47:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Oleg A. Yurlov" <kris@spylog.com>
Cc: Cliff Albert <cliff@oisec.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11aa1 and AIC7XXX
Message-ID: <20011011184748.S714@athlon.random>
In-Reply-To: <13522687985.20011011173954@spylog.com> <20011011163105.A18508@oisec.net> <58528703605.20011011192009@spylog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58528703605.20011011192009@spylog.com>; from kris@spylog.com on Thu, Oct 11, 2001 at 07:20:09PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 07:20:09PM +0400, Oleg A. Yurlov wrote:
> 
>         Hi, Cliff and all,
> 
> Thursday, October 11, 2001, 6:31:05 PM, you wrote:
> 
> CA> On Thu, Oct 11, 2001 at 05:39:54PM +0400, Oleg A. Yurlov wrote:
> 
> >> Oct 10 20:35:31 samson kernel: (scsi0:A:2:0): Locking max tag count at 128
> >> Oct 10 21:06:31 samson kernel: (scsi1:A:0:0): Locking max tag count at 64                                                           
> >> Oct 11 05:33:09 samson kernel: (scsi0:A:3:0): Locking max tag count at 128       
> >> 
> >>         Hardware   -  SMP 2 CPU, 1GB RAM, M/B Intel L440GX, 5 SCSI HDD, Software
> >> RAID5 (3 disks) and RAID1.
> >> 
> >>         I found in dmesg:
> >> 
> >>  *** Possibly defective BIOS detected (irqtable)
> >>  *** Many BIOSes matching this signature have incorrect IRQ routing tables.
> >>  *** If you see IRQ problems, in paticular SCSI resets and hangs at boot
> >>  *** contact your vendor and ask about updates.
> >>  *** Building an SMP kernel may evade the bug some of the time.
> >> Starting kswapd
> >> 
> >>         It's  normal or not ? What I can do to fix problem with locking max tag
> >> count ?
> 
> CA> Looks normal, it's that the new aic7xxx driver utilizes a maximum tag queue depth of 255 tags. Your devices are supporting only a maximum tag count of 128, 64 and 128 so it's perfectly normal.
> CA> Also these 'error' messages should only appear once and no more (until a reboot)
> 
>         Thanks a lot !

But of course be careful with 2.4.11aa1, like vanilla 2.4.11 it can eat
your filesystem. An urgent upgrade to 2.4.12 is recommended (2.4.12aa1
is out and it seems it fixes the oom faliures on the 8g boxes properly
now)

Andrea
