Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSA0KAO>; Sun, 27 Jan 2002 05:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSA0KAE>; Sun, 27 Jan 2002 05:00:04 -0500
Received: from zamok.crans.org ([138.231.136.6]:22207 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S287919AbSA0J7p>;
	Sun, 27 Jan 2002 04:59:45 -0500
To: "Nix N. Nix" <nix@go-nix.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT266 and SBLive! (emu10k1)
In-Reply-To: <1012086718.11336.91.camel@tux>
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
In-Reply-To: <1012086718.11336.91.camel@tux> ("Nix N. Nix"'s message of "26
 Jan 2002 18:11:53 -0500")
Organization: Kabale Inc
Date: Sun, 27 Jan 2002 10:59:42 +0100
Message-ID: <m3lmek2jxt.fsf@neo.loria>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO En cette nuit nuageuse du dimanche 27 janvier 2002, vers 00:11,
"Nix N. Nix" <nix@go-nix.ca> disait:

> 00:0e.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
> (rev 05)
> 	Subsystem: Creative Labs CT4850 SBLive! Value
> 	Flags: bus master, medium devsel, latency 32, IRQ 5
> 	I/O ports at b000 [size=32]
> 	Capabilities: <available only to root>

You may try /sbin/setpci -v -s 00:0e.0 0D.B=40

Check http://www.networking.tzo.com/net/software/readme/faqvl019.htm
and http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.3/0922.html

The first one is a patch for Windows to correct the problem, it is
called "VIA latency patch" since it used to only modify latency. It is
closed source so it is difficult to see if the correction towards the
sound card is about latency (so my command line is useless).

The second one is a post from the author of the corresponding VIA
latency patch under Linux, you may want to try it (and to tweak it if
you don't have a KT266A).

However, the problem seems not IRQ related, so you may want to try
another slots for your sound card.
-- 
Say what you mean, simply and directly.
            - The Elements of Programming Style (Kernighan & Plaugher)
