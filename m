Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264081AbTEPLNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 07:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTEPLNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 07:13:20 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:7557 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S264081AbTEPLNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 07:13:18 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [OOPS] 2.5.69-mm6
References: <20030516015407.2768b570.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 16 May 2003 13:26:20 +0200
In-Reply-To: <20030516015407.2768b570.akpm@digeo.com>
Message-ID: <87fznfku8z.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton <akpm@digeo.com> writes:
>
> [SNMP]
>

[drm] Initialized radeon 1.8.0 20020828 on minor 0
general protection fault: 33d4 [#1]
CPU:    0
EIP:    0060:[<f09bb169>]    Not tainted VLI
EFLAGS: 00013203
EIP is at radeon_mmap+0x5f/0x21e [radeon]
eax: eac3bee0   ebx: f08e5000   ecx: eac3bee0   edx: eac3bdc0
esi: ec1dde00   edi: 00000000   ebp: eb72df2c   esp: eb72df00
ds: 007b   es: 007b   ss: 0068
Process X (pid: 4427, threadinfo=eb72c000 task=ec16f8c0)
Stack: eb72df2c c01433d5 eed31380 40013000 eb72df2c 00003246 efbeb000 ee9ed500
       ee9ed500 00002000 eed31380 eb72df88 c0142f57 ee9ed500 ec1dde00 eb72df70
       eb72df74 eb72df78 eb72df5c efbeb000 efbeb000 00000003 00000000 ffffffea
Call Trace:
 [<c01433d5>] get_unmapped_area+0xc5/0x129
 [<c0142f57>] do_mmap_pgoff+0x303/0x6bc
 [<c01108a6>] sys_mmap2+0x9b/0xd1
 [<c010ae57>] syscall_call+0x7/0xb
 
Code: ff 83 c4 20 89 d0 5b 5e 5f 5d c3 8b 46 34 89 c3 c1 e3 0c 0f 84 8b 01 00 00 8b 45 ec 8b 88 48 01 00 00 8b 11 8b 02 0f 18 00 00 39 <ca> 74 17 8b
7a 08 85 ff 74 04 39 1f 74 0c 89 c2 8b 00 0f 18 00

This one goes in -mm5 as well, machine runs fine for a while in X, but
trying to switch to a vty send the machine into the tall weeds...

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+xMrYCQ1pa+gRoggRAiFfAKCSaRonv0yTFIgpkZ7mYfzIV7N6tgCeIXEi
j9Uuwx3t5NDUsI4pgcYKxAw=
=KtDZ
-----END PGP SIGNATURE-----
