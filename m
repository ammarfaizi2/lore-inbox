Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVDEIKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVDEIKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVDEIGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:06:48 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:4552 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261614AbVDEH7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:59:02 -0400
Message-ID: <4252453E.7060407@arcor.de>
Date: Tue, 05 Apr 2005 09:58:54 +0200
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050324)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] inotify for 2.6.11
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
In-Reply-To: <1109961444.10313.13.camel@betsy.boston.ximian.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig71EB513D07877831734BBB02"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig71EB513D07877831734BBB02
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I am having a little trouble with inotify 0.22. Previous version worked w/o
trouble (even with nvidia and nvsound loaded) with 2.6.12-rc1-kb2 and gamin

Now I use 2.6.12-rc2 with inotify 0.22 and got this after a few minutes of
uptime (compiling some stuff):

Apr  5 09:40:43 tachyon Unable to handle kernel NULL pointer dereference at
virtual address 00000010
Apr  5 09:40:43 tachyon printing eip:
Apr  5 09:40:43 tachyon b0181d83
Apr  5 09:40:43 tachyon *pde = 00000000
Apr  5 09:40:43 tachyon Oops: 0002 [#1]
Apr  5 09:40:43 tachyon PREEMPT
Apr  5 09:40:43 tachyon Modules linked in: nvidia nvsound
Apr  5 09:40:43 tachyon CPU:    0
Apr  5 09:40:43 tachyon EIP:    0060:[<b0181d83>]    Tainted: P      VLI
Apr  5 09:40:43 tachyon EFLAGS: 00210286   (2.6.12-rc2)
Apr  5 09:40:43 tachyon EIP is at inotify_ignore+0x23/0xd0
Apr  5 09:40:43 tachyon eax: 00000000   ebx: b998ce60   ecx: 00000000   edx:
00000000
Apr  5 09:40:43 tachyon esi: 00000000   edi: b998ce60   ebp: 80045102   esp:
b336bf48
Apr  5 09:40:43 tachyon ds: 007b   es: 007b   ss: 0068
Apr  5 09:40:43 tachyon Process gam_server (pid: 4144, threadinfo=b336a000
task=ccf84aa0)
Apr  5 09:40:43 tachyon Stack: b998ce60 b998ce98 08062484 b0181ebf b336bf78
b336bf74 0000003e b0181e30
Apr  5 09:40:43 tachyon c1168b00 08062484 80045102 b016c40b 00000000 c1168b00
c1168b00 00000003
Apr  5 09:40:43 tachyon b336a000 b016c640 00000000 080623d8 c1168b00 00000003
fffffff7 b336a000
Apr  5 09:40:43 tachyon Call Trace:
Apr  5 09:40:43 tachyon [<b0181ebf>] inotify_ioctl+0x8f/0xd0
Apr  5 09:40:43 tachyon [<b0181e30>] inotify_ioctl+0x0/0xd0
Apr  5 09:40:43 tachyon [<b016c40b>] do_ioctl+0x2b/0xa0
Apr  5 09:40:43 tachyon [<b016c640>] vfs_ioctl+0x60/0x210
Apr  5 09:40:43 tachyon [<b016c82d>] sys_ioctl+0x3d/0x70
Apr  5 09:40:43 tachyon [<b0103127>] sysenter_past_esp+0x54/0x75
Apr  5 09:40:43 tachyon Code: 89 58 20 eb c2 8d 76 00 83 ec 0c 89 7c 24 08 89
1c 24 89 c7 89 74 24 04 ff 4f 28 0f 88 2b 03 00 00 8d 47 08 e8 ef f9 12 00 89
c6 <ff> 40 10 ff 47 28 0f 8e 22 03 00 00 85 f6 ba ea ff ff ff 74 65

Cheers,

Prakash

--------------enig71EB513D07877831734BBB02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCUkVBxU2n/+9+t5gRArPDAKC0NaedJMlxbjKGFCLMUcbl1ZhbOgCg5nQH
ICNu0KVUFQMm4wvLjMoT7K8=
=lG0E
-----END PGP SIGNATURE-----

--------------enig71EB513D07877831734BBB02--
