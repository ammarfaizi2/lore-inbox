Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271264AbTGRJF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271315AbTGRJF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:05:56 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.23]:51925 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271264AbTGRJFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:05:55 -0400
Date: Fri, 18 Jul 2003 05:18:23 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH][2.6] Fix "sleeping function called from illegal context" from
 Bugzilla bug # 641
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200307180510.02780.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://bugme.osdl.org/show_bug.cgi?id=641

Debug: sleeping function called from illegal context at include/asm/semaphore.h:
119
Call Trace:
 [<c011dadf>] __might_sleep+0x5f/0x80
 [<e325c3f6>] +0x40a/0x574 [snd_emux_synth]
 [<e3258b4a>] lock_preset+0x1ca/0x290 [snd_emux_synth]
 [<e325c3f6>] +0x40a/0x574 [snd_emux_synth]
 [<e325aaaf>] snd_soundfont_search_zone+0x2f/0xf0 [snd_emux_synth]
 [<e0911f10>] snd_timer_s_function+0x0/0x20 [snd_timer]
 [<e3256830>] get_zone+0x70/0x90 [snd_emux_synth]
 [<e3254632>] snd_emux_note_on+0xf2/0x4a0 [snd_emux_synth]
 [<c010c263>] do_IRQ+0x233/0x370
 [<e325eec0>] emux_ops+0x0/0x20 [snd_emux_synth]
 [<e09090f6>] +0xf6/0x3c0 [snd_seq_midi_emul]
 [<c014b0eb>] check_poison_obj+0x3b/0x190
 [<c02aefb4>] kfree_skbmem+0x64/0x70
 [<e3257293>] snd_emux_event_input+0x63/0xa0 [snd_emux_synth]
 [<e325eec0>] emux_ops+0x0/0x20 [snd_emux_synth]
 [<e3241657>] snd_seq_deliver_single_event+0x147/0x1b0 [snd_seq]
 [<e3241965>] snd_seq_deliver_event+0x45/0xb0 [snd_seq]
 [<e3241a9a>] snd_seq_dispatch_event+0xca/0x1b0 [snd_seq]
 [<c011165a>] do_gettimeofday+0x1a/0x90
 [<e3247335>] snd_seq_check_queue+0x245/0x500 [snd_seq]
 [<c016b19b>] do_sync_read+0x8b/0xc0
 [<e09113fd>] snd_timer_interrupt+0x48d/0x610 [snd_timer]
 [<c02ab029>] sock_poll+0x29/0x40

Josef "Jeff" Sipek

- --
Research, n.:
  Consider Columbus:
    He didn't know where he was going.
    When he got there he didn't know where he was.
    When he got back he didn't know where he had been.
    And he did it all on someone else's money.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/F7tjwFP0+seVj/4RAndtAJ47MlLqZIEyiYhti0Ub9zjw9G5TlwCfeO8a
U68C2Wswc2N4VJHljEPBfaY=
=VqQH
-----END PGP SIGNATURE-----

