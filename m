Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266410AbTGJSxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbTGJSxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:53:22 -0400
Received: from dsl-62-3-122-163.zen.co.uk ([62.3.122.163]:13696 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S266410AbTGJSvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:51:38 -0400
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
From: Anders Karlsson <anders@trudheim.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Oleg Drokin <green@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0D88CB.3090303@gmx.net>
References: <3F0D761E.2050702@gmx.net>
	 <1057851052.7753.6.camel@tor.trudheim.com>  <3F0D88CB.3090303@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cR082lS5+xRlXFD7OOmw"
Organization: Trudheim Technology Limited
Message-Id: <1057863974.2788.5.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 10 Jul 2003 20:06:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cR082lS5+xRlXFD7OOmw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-10 at 16:39, Carl-Daniel Hailfinger wrote:

> Was there any disk activity after it became unresponsive? If not, please
> provide a (partially) decoded SysRq-T. I'm only interested in the decoded
> stack trace of the hung process (it should have a "D" after the process n=
ame).

Right, I have collected the details that was asked for. Carl-Daniel
suggested a way of tricking the system into doing an fsck without
tampering with the filesystem itself. Please find below the data I
copied out and decoded. If there is anything else I can do, let me know.
If there is any data about my system you require, let me know.

Output from Alt SysRq P:

Pid: 160, comm:        fsck.ext3
EIP: 0010:[<c01b0f43>]  CPU: 0  EFLAGS: 00000246   Not Tainted
EAX: 00000000 EBX: 00000000 ECX: c0338c00 EDX: 00000007
ESI: c0338c00 EDI: eee68000 EBP: eee69de8 DS: 0018 ES: 0018
CR0: 80050033 CR2: 400dcff0 CR3: 2ee6b000 CR4: 000006d0

Call trace: [<c01b1584>] [<c01b1bfb>] [<c01b1cca>] [<c0141643>]
[<c014178f>] [<c01417a4>] [<c0141887>] [<c01464e1>] [<c0141b61>]
[<c0108f83>]

Output from Alt SysRq T:

fsck.ext3      D  current   3808   160  149     (NOTLB)
Call Trace: [<c014178f>] [<c01417a4>] [<c0141887>] [<c01464e1>]
[<c0141b61>] [<c0108f83>]


ksymoops 2.4.8 on i686 2.4.22-pre3-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre3-ac1/ (default)
     -m /boot/System.map-2.4.22-pre3-ac1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol zeroes  , ipsec says
f23fdf00, /lib/modules/2.4.22-pre3-ac1/kernel/net/ipsec/ipsec.o says
f23fdde0.  Ignoring
/lib/modules/2.4.22-pre3-ac1/kernel/net/ipsec/ipsec.o entry
Pid: 160, comm:        fsck.ext3
EIP: 0010:[<c01b0f43>]  CPU: 0  EFLAGS: 00000246   Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 00000000 EBX: 00000000 ECX: c0338c00 EDX: 00000007
ESI: c0338c00 EDI: eee68000 EBP: eee69de8 DS: 0018 ES: 0018
Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register
line ignored
CR0: 80050033 CR2: 400dcff0 CR3: 2ee6b000 CR4: 000006d0
Call trace: [<c01b1584>] [<c01b1bfb>] [<c01b1cca>] [<c0141643>]
[<c014178f>] [<c01417a4>] [<c0141887>] [<c01464e1>] [<c0141b61>]
[<c0108f83>]
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c01b0f43 <__get_request_wait+ae/f6>   <=3D=3D=3D=3D=3D

>>ECX; c0338c00 <ide_hwifs+c0/2af8>
>>ESI; c0338c00 <ide_hwifs+c0/2af8>
>>EDI; eee68000 <_end+2eb17bf4/304bcc54>
>>EBP; eee69de8 <_end+2eb199dc/304bcc54>

Trace; c01b1584 <__make_request+167/71a>
Trace; c01b1bfb <generic_make_request+c4/13a>
Trace; c01b1cca <submit_bh+59/a0>
Trace; c0141643 <write_locked_buffers+2a/36>
Trace; c014178f <write_some_buffers+140/142>
Trace; c01417a4 <write_unlocked_buffers+13/1d>
Trace; c0141887 <sync_buffers+1a/75>
Trace; c01464e1 <__block_fsync+2f/6c>
Trace; c0141b61 <sys_fsync+93/de>
Trace; c0108f83 <system_call+33/38>


4 warnings issued.  Results may not be reliable.



--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-cR082lS5+xRlXFD7OOmw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA/DbkmLYywqksgYBoRAjUSAKClgr1XQfC07w4KINul3tXDs6pAjQCggJ7y
BvC/PbuGskyHYfy7UMsGMLs=
=cRFT
-----END PGP SIGNATURE-----

--=-cR082lS5+xRlXFD7OOmw--

