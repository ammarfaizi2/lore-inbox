Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUHLIIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUHLIIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 04:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268459AbUHLIIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 04:08:31 -0400
Received: from imap.gmx.net ([213.165.64.20]:33476 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268458AbUHLII3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 04:08:29 -0400
X-Authenticated: #4512188
Message-ID: <411B2576.6010903@gmx.de>
Date: Thu, 12 Aug 2004 10:08:22 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler fairness problem on 2.6 series
References: <20040811022143.4892.qmail@web13910.mail.yahoo.com> <cone.1092193795.772385.25569.502@pc.kolivas.org> <4119F3D9.7040708@gmx.de> <411A024B.6060100@kolivas.org> <411A0B71.4030503@gmx.de> <411A71F1.3090504@gmx.de> <411AAEDA.9070601@kolivas.org>
In-Reply-To: <411AAEDA.9070601@kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Con Kolivas wrote:
| Prakash K. Cheemplavam wrote:
|
|> 124910    9.8170  vmlinux                  tcp_poll
|> 123356    9.6949  vmlinux                  sys_select
|> 85634     6.7302  vmlinux                  do_select
|> 71858     5.6475  vmlinux                  sysenter_past_esp
|> 62093     4.8801  vmlinux                  kfree
|> 51658     4.0600  vmlinux                  __copy_to_user_ll
|> 37495     2.9468  vmlinux                  max_select_fd
|> 36949     2.9039  vmlinux                  __kmalloc
|> 22700     1.7841  vmlinux                  __copy_from_user_ll
|> 14587     1.1464  vmlinux                  do_gettimeofday
|>
| It looks like your select timeouts are too short and when the cpu load
| goes up they repeatedly timeout wasting cpu cycles.
| I quote from `man select_tut` under the section SELECT LAW:
|
| 1. You should always try use select without a timeout. Your program
|  should have nothing to do if there is no  data  available.  Code
|  that  depends  on timeouts is not usually portable and difficult
|  to debug.
|

Thanks for your explanation. I cannot do anything about it, as it is
mpich related. So I'll ask them if they could change its behaviour a bit
so that it eats less CPU on a single CPU machine.

Cheers,

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBGyV1xU2n/+9+t5gRAqHEAJ9hW/AJYtMenL6mXQ4JZYvTvRrRkgCdHwQD
LbJ1MYJ/pbpNbrT8vvlD8uI=
=9AUE
-----END PGP SIGNATURE-----
