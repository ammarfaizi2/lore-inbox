Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUGFT0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUGFT0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUGFT0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 15:26:42 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:57231 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264346AbUGFT0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 15:26:40 -0400
Message-ID: <40EAFCEE.3060306@g-house.de>
Date: Tue, 06 Jul 2004 21:26:38 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Thunderbird 0.6 (X11/20040605)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7+BK bad: scheduling while atomic! (ALSA?)
References: <Pine.GSO.4.44.0407061231580.25111-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0407061231580.25111-100000@math.ut.ee>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Meelis Roos schrieb:
> While running alsamixergui -c 2, I got alsamixergui killed with SEGV and
> the following in dmesg. Additionally, mplayer has big problems playing

yes, "me too". upon using ALSA (same .config as earlier kernels) i got:

kernel: bad: scheduling while atomic!
kernel: [<c031dc56>] schedule+0x486/0x4c0
kernel: [<c0118764>] sys_sched_yield+0x44/0x60
kernel: [<c0160bc2>] coredump_wait+0x32/0xa0
kernel: [<c010b557>] convert_fxsr_to_user+0x107/0x170
kernel: [<c0160d31>] do_coredump+0x101/0x20b
kernel: [<c0123a0c>] free_uid+0x1c/0x70
kernel: [<c01242a5>] __dequeue_signal+0x105/0x180
kernel: [<c0124355>] dequeue_signal+0x35/0xb0
kernel: [<c012605f>] get_signal_to_deliver+0x30f/0x3f0
kernel: [<c0103e61>] do_signal+0x91/0x170
kernel: [<c01479cd>] do_mmap_pgoff+0x3ed/0x6f0
kernel: [<c010aa66>] sys_mmap2+0x86/0xd0
kernel: [<c0116070>] do_page_fault+0x0/0x57e
kernel: [<c0103f77>] do_notify_resume+0x37/0x3c
kernel: [<c0104156>] work_notifysig+0x13/0x15
kernel: bad: scheduling while atomic!
kernel: [<c031dc56>] schedule+0x486/0x4c0
kernel: [<c01174ca>] wake_up_state+0x1a/0x20
kernel: [<c031dd48>] wait_for_completion+0x78/0xe0
kernel: [<c0117db0>] default_wake_function+0x0/0x20
kernel: [<c0117db0>] default_wake_function+0x0/0x20
kernel: [<c0160b1c>] zap_threads+0x4c/0xc0
kernel: [<c0160c18>] coredump_wait+0x88/0xa0
kernel: [<c010b557>] convert_fxsr_to_user+0x107/0x170
kernel: [<c0160d31>] do_coredump+0x101/0x20b
kernel: [<c0123a0c>] free_uid+0x1c/0x70
kernel: [<c01242a5>] __dequeue_signal+0x105/0x180
kernel: [<c0124355>] dequeue_signal+0x35/0xb0
kernel: [<c012605f>] get_signal_to_deliver+0x30f/0x3f0
kernel: [<c0103e61>] do_signal+0x91/0x170
kernel: [<c01479cd>] do_mmap_pgoff+0x3ed/0x6f0
kernel: [<c010aa66>] sys_mmap2+0x86/0xd0
kernel: [<c0116070>] do_page_fault+0x0/0x57e
kernel: [<c0103f77>] do_notify_resume+0x37/0x3c
kernel: [<c0104156>] work_notifysig+0x13/0x15
kernel: note: xmms[17326] exited with preempt_count 1

this is latest 2.6.7-bk, debian/unstable (i386), but my kernel is
tainted (nvidia).

Christian.
- --
BOFH excuse #26:

first Saturday after first full moon in Winter
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA6vzt+A7rjkF8z0wRAu6YAJ9GdFOhhU/QmqTT3ynvGnCvKrmnJQCgkuQB
nt71aEqg6gMPflfyyHUQwo0=
=jvHX
-----END PGP SIGNATURE-----
