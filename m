Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268186AbUHKTWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268186AbUHKTWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268188AbUHKTWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:22:40 -0400
Received: from imap.gmx.net ([213.165.64.20]:3279 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268186AbUHKTWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:22:24 -0400
X-Authenticated: #4512188
Message-ID: <411A71F1.3090504@gmx.de>
Date: Wed, 11 Aug 2004 21:22:25 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler fairness problem on 2.6 series
References: <20040811022143.4892.qmail@web13910.mail.yahoo.com> <cone.1092193795.772385.25569.502@pc.kolivas.org> <4119F3D9.7040708@gmx.de> <411A024B.6060100@kolivas.org> <411A0B71.4030503@gmx.de>
In-Reply-To: <411A0B71.4030503@gmx.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

|
| I don't think it is the overhead. I rather think the way the kernel
| schedulers gives mpich and the cpu bound program  resources is unfair.

Well, I don't know whether it helps, but I ran a profiler and these are
the functions which cause so much wasted CPU cycles when running 16
processes of my example with mpich:

124910    9.8170  vmlinux                  tcp_poll
123356    9.6949  vmlinux                  sys_select
85634     6.7302  vmlinux                  do_select
71858     5.6475  vmlinux                  sysenter_past_esp
62093     4.8801  vmlinux                  kfree
51658     4.0600  vmlinux                  __copy_to_user_ll
37495     2.9468  vmlinux                  max_select_fd
36949     2.9039  vmlinux                  __kmalloc
22700     1.7841  vmlinux                  __copy_from_user_ll
14587     1.1464  vmlinux                  do_gettimeofday

Is anything scheduler related?

bye,

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGnHxxU2n/+9+t5gRAlF+AJ9z+OqbIJYkeiy4nAPVB22S/WLLnACg1khF
XeF+3Hq0adpoLjdbn+tmzn0=
=7Onu
-----END PGP SIGNATURE-----
