Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTITTFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTITTFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 15:05:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22219 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261936AbTITTFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 15:05:18 -0400
Date: Sat, 20 Sep 2003 20:05:16 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2[12] v VIA Rhine and VIA82x audio (working with a fight)
Message-ID: <20030920190516.GA796@gallifrey>
References: <20030920163835.GA723@gallifrey> <1064079929.22995.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064079929.22995.7.camel@dhcp23.swansea.linux.org.uk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 19:56:12 up 48 min,  1 user,  load average: 0.17, 0.31, 0.37
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> 
> I've done some work on this for -ac. I thought 2.4.22 had enough stuff
> to deal with it (at least for the non ACPI case). VIA v-bus cares that
> both PCI_INTERRUPT_PIN and PCI_INTERRUPT_LINE are both set.

Well I do wonder whether it is just a very buggy BIOS etc not being helpful.

> > 2) Audio
> > 
> > This was much more of a fight. The standard 2.4.21/22 via82xxx drivers
> > were very problematic.  For example random hanging apps, buzzing when
> > an app had sound open but wasn't actually sending stuff, and a complete
> > failure to have any sound input.
> 
> Do you have VIA 8233 or 8235 hardware ?

It isn't entirely obvious from the PCI dumps; I think its the 8235 from the
first entry for the device:

Bus  0, device  17, function  0:
  ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge (rev 0).
Bus  0, device  17, function  1:
  IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 6).
    Master Capable.  Latency=32.
    I/O at 0xdc00 [0xdc0f].
Bus  0, device  17, function  5:
  Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 80).
    IRQ 5.
    I/O at 0xe000 [0xe0ff].

ALSA seems to think its an 8235.

> > Except for playing CDs - which don't do anything - I suspect that might
> > be hardware, but am not sure.
> 
> Check there is an analog cable fitted on the CD->Sound. Many new WinXP
> boxes are shipped with XP configured to digitally rip the CD data and no
> audio link cable. If so you need to pick a different CD player app or
> fit the cable.

Nod - I've heard it play a few times; so I'm wondering about a loose cable; although
my normal solution of these problems (buy a Soundblaster) has failed when I got the
machine home to find it had a sticker over the back of the case saying if I opened
it I'd break the warranty.

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
