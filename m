Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbTBLQ4q>; Wed, 12 Feb 2003 11:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbTBLQ4q>; Wed, 12 Feb 2003 11:56:46 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:59870 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S267512AbTBLQ4p>; Wed, 12 Feb 2003 11:56:45 -0500
Date: Wed, 12 Feb 2003 18:06:34 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rl@hellgate.ch, linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
Message-ID: <20030212180634.A5019@pc9391.uni-regensburg.de>
References: <20030212155836.A797@pc9391.uni-regensburg.de> <1045068074.2166.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1045068074.2166.18.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 12, 2003 at 17:41:15 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.2003   17:41 Alan Cox wrote:
> On Wed, 2003-02-12 at 14:58, Christian Guggenberger wrote:
> > > o       Always set interrupt line with VIA northbridge  (me)
> > >        | Should fix apic mode problems with USB/audio/net on VIA boards
> > >
> > Can you please send a patch against 2.5.60, cause I would like to test
> these
> > IO APIC things on my via board. 2.4-ac is no choice for me, since patching
> xfs
> > into 2.4-ac is a little bit too painful for me;-)
> 
> At the moment I can't even get 2.5.60 to boot so its a bit hard to do any
> work
> on it.
Of course;-)

> Just run via boxes with "noapic" and dont enable the apic stuff on
> single
> cpu systems. Thats as good if not a better test
> 
That's what I'm almost doing since I have this mobo. I have APICs enabled in 
both kernel and bios, but IO-APICs disabled. 2.5.60 seems to work for me.
The only thing I'd like to get rid off, are those Interrupt errors in 
/proc/interrupts (maybe they are harmless anyway):

            CPU0
   0:     941032   XT-PIC  timer
   1:       1927   XT-PIC  i8042
   2:          0   XT-PIC  cascade
   5:          0   XT-PIC  VIA8233
   8:          4   XT-PIC  rtc
  10:      14946   XT-PIC  ide2, eth0
  12:      29425   XT-PIC  i8042
  14:       7525   XT-PIC  ide0
  15:         36   XT-PIC  ide1
NMI:          0
LOC:     940979
ERR:        914

They won't go away with noapic, too.

With IO-APICs the ERR count would stay at 0. (but then most onboard devices 
wouldn't work)
That's why i asked for that APIC patch in my previous mail.

Christian
