Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264259AbRFIQNy>; Sat, 9 Jun 2001 12:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264355AbRFIQNo>; Sat, 9 Jun 2001 12:13:44 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:55780 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S264259AbRFIQNa>; Sat, 9 Jun 2001 12:13:30 -0400
Date: Sat, 9 Jun 2001 17:13:13 +0100
From: Robin Cull <kernel-list@phaderunner.demon.co.uk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: OPL3-SA2 driver and Intel AL400LX onboard sound problems
Message-Id: <20010609171313.1d2872b2.kernel-list@phaderunner.demon.co.uk>
Reply-To: kernel-list@phaderunner.demon.co.uk
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.)9u)i4QJjIs1+l"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.)9u)i4QJjIs1+l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, 

Just updated to 2.4.5 from 2.2.18 and there seems to be a difference in the OPL3-SA2 sound driver.  

I have an Intel AL440LX motherboard with onboard sound, after setting up the sound driver under 2.4.5 I get a strange effect when trying to play any sound files; the files play very slow (like the sample rate is off), the volume is very low (the mixer seems to take no effect) and there is lots of interference (hissing).  I only get hissing from the left speaker and the much too slow, very bassy, distorted sound from the right speaker.  

This happens when I try to play MP3s from xmms and when I cat a wav straight to /dev/snd.  

I've tried setting the card up with isapnp and the kernel ISA PNP features, both have the same effect.  Using isapnp under 2.2.18 my sound worked perfectly.  I am currently using the kernel ISA PNP features.  

When the kernel loads I get: 
Jun  9 16:39:22 yoshi kernel: isapnp: Scanning for PnP cards...
Jun  9 16:39:22 yoshi kernel: isapnp: Card 'OPL3-SA3 Snd System'
Jun  9 16:39:22 yoshi kernel: isapnp: 1 Plug & Play card detected total

When sound is initialised I get: 
Jun  9 16:39:34 yoshi kernel: opl3sa2: Found OPL3-SA3 (YMF715 or YMF719)
Jun  9 16:39:34 yoshi kernel: <OPL3-SA3> at 0x100
Jun  9 16:39:34 yoshi kernel: <MS Sound System (CS4231)> at 0xe84 irq 5 dma 1,3
Jun  9 16:39:35 yoshi kernel: <MPU-401 0.0  Midi interface #1> at 0x300 irq 5
Jun  9 16:39:35 yoshi kernel: opl3sa2: 1 PnP card(s) found.

/proc/interrupts looks like: 

  5:      14783          XT-PIC  MS Sound System

(rest omitted) 

The values in /proc/isapnp appear to match as well (I won't dump that all here though) as do the values in /proc/ioports (I will leave that out too unless requested later).  I am fairly sure there is no conflict there.  

I had heard murmers that this driver had been through some changes and looking through the list archives has shown that there have been some problems in 2.4.x with this driver before; nothing seems to match my problem though.  

Could anyone point me in the direction of trying to solve this problem?  It doesn't have to be a patch, I'm fairly good at looking through source, its just that I haven't got a clue where to start.  Any tips would be appreciated.  Of course, if a fix already exists please point me at it instead of going through it the hard way...!  

Thanks in advance.  

Robin
-- 
E-Mail:           robin@phaderunner.demon.co.uk
WWW:              http://www.phaderunner.demon.co.uk/
GnuPG public key: http://www.phaderunner.demon.co.uk/Robin_Cull.key.asc

  "It's easier to ask forgiveness than it is to get permission."
    -- Rear Admiral Dr. Grace Hopper (sponsor of COBOL...)


--=.)9u)i4QJjIs1+l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7IkslOnrWcwWyJokRAiAUAKClqEEdfUJ9tw83uCVAvRFBtVnFfQCgxut+
RNQg2PpQuI1VIy28vedfI1k=
=CIVk
-----END PGP SIGNATURE-----

--=.)9u)i4QJjIs1+l--

