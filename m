Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281024AbRLDQno>; Tue, 4 Dec 2001 11:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRLDQnk>; Tue, 4 Dec 2001 11:43:40 -0500
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:20495 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S281047AbRLDQmN>; Tue, 4 Dec 2001 11:42:13 -0500
Subject: ANNOUNCE: (BETA!) international kernel patch for 2.4.16 available!
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 17:41:33 +0100
Message-Id: <1007484097.12213.12.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*WARNING* this is meant for the brave ones (read beta-testers ;), which
want to do some tests, and hopefully report back any problems they
encounter!

I assume everyone interested already knows what the international patch
is for; and if not then maybe it's better to wait for the final version
of this patch which will get a more informative announcement... :-)

if you head over to {ftp,www}.kernel.org in
/pub/linux/kernel/people/hvr/testing/

you'll find 

*) patch-int-2.4.16.0.{bz2,gz}

a patch that contains:
- the cryptographic kernel API layer
- cryptographic ciphers (aes, twofish, mars, rc6, serpent, dfc,
  blowfish, idea, rc5, 3des, des)
- digest algorithms (md5, sha1)
- cryptographic loop filter module ('cryptoloop')

this patch needs _one_ of the following two patches to be applied in
order to make use of (i.e. compile) the cryptoloop module...

*) loop-jari-2.4.16.0.patch

jari's loop patch (slightly modified +++) featuring:

- IV computed in 512 byte units.
- Make device backed loop work with swap by pre-allocating pages.
- External encryption module locking bug fixed (from Ingo Rohloff).
- Get rid of the loop_get_bs() crap.
- grab_cache_page() return value handled properly, avoids Oops.
- No more illegal messing with BH_Dirty flag.
- No more illegal sleeping in generic_make_request().
- Loops can be set-up properly when root partition is still mounted ro.
- Default soft block size is set properly for file backed loops.
- kmalloc() error case handled properly.

+++ added 2 #defines and 1 typedef to loop.h for cryptoloop.c

*) loop-hvr-2.4.16.0.patch

my patch, with only the following functional improvement:

- IV computed in 512 byte units.


...

ps: the reason for kerneli.org being down or the lack of development of
the int. patch is NOT caused by any government intervention...

regards,
-- 
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

