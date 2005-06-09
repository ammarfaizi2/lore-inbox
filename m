Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVFIKcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVFIKcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 06:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVFIKcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 06:32:14 -0400
Received: from lug-owl.de ([195.71.106.12]:48829 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262340AbVFIKcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 06:32:02 -0400
Date: Thu, 9 Jun 2005 12:30:52 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: IPv6 related BUG (./net/ipv6/exthdrs_core.c:ipv6_skip_exthdr())
Message-ID: <20050609103052.GU19479@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TbvQLmyOl28t66Jz"
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TbvQLmyOl28t66Jz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

My bind wasn't working and this showed up in dmesg:

 ------------[ cut here ]------------
kernel BUG at net/ipv6/exthdrs_core.c:80!
invalid operand: 0000 [#1]
SMP=20
Modules linked in: sd_mod capability commoncap ipt_REJECT iptable_filter ip=
_tables e100 floppy dm_mod pcspkr psmouse genrtc unix
CPU:    1
EIP:    0060:[<c02f8556>]    Not tainted VLI
EFLAGS: 00010246   (2.6.11.10lug-owl)=20
EIP is at ipv6_skip_exthdr+0x116/0x148
eax: fffffff2   ebx: 00000000   ecx: 0000005c   edx: dabf3a4c
esi: 00000080   edi: 00000082   ebp: cb9a63e0   esp: dabf3a40
ds: 007b   es: 007b   ss: 0068
Process named (pid: 11120, threadinfo=3Ddabf2000 task=3De706a5a0)
Stack: 00000002 00296b00 dabf3a77 c03a4e40 00000028 cb9a63e0 f6fe6e00 dabf3=
b1c=20
       c01d7189 00000014 00000000 f6fe6210 ce3263c0 003263c0 c03a4e40 c0296=
876=20
       c03a4e40 00000000 c0296b00 80000000 c042f010 ce3263c0 c03aadec c042f=
020=20
Call Trace:
 [<c01d7189>] selinux_parse_skb_ipv6+0x89/0x150
 [<c0296876>] ip_rcv+0x196/0x250
 [<c0296b00>] ip_rcv_finish+0x0/0x280
 [<c027dfaa>] netif_receive_skb+0x23a/0x340
 [<c027e136>] process_backlog+0x86/0x120
 [<c01d729a>] selinux_parse_skb+0x4a/0x90
 [<c01d7efe>] selinux_ip_postroute_last+0xce/0x220
 [<c01d80a4>] selinux_ipv6_postroute_last+0x24/0x30
 [<c02d4c30>] ip6_output_finish+0x0/0x100
 [<c0287a80>] nf_iterate+0x70/0xc0
 [<c02d4c30>] ip6_output_finish+0x0/0x100
 [<c02d4c30>] ip6_output_finish+0x0/0x100
 [<c0287e38>] nf_hook_slow+0x88/0x140
 [<c02d4c30>] ip6_output_finish+0x0/0x100
 [<c02d4c10>] dst_output+0x0/0x20
 [<c02d287e>] ip6_output2+0xbe/0x170
 [<c02d4c30>] ip6_output_finish+0x0/0x100
 [<c02d4c1b>] dst_output+0xb/0x20
 [<c0287e8e>] nf_hook_slow+0xde/0x140
 [<c02d4c10>] dst_output+0x0/0x20
 [<c02d4c10>] dst_output+0x0/0x20
 [<c02d49c9>] ip6_push_pending_frames+0x279/0x3a0
 [<c02d4c10>] dst_output+0x0/0x20
 [<c02e5345>] udp_v6_push_pending_frames+0x145/0x1a0
 [<c02e586f>] udpv6_sendmsg+0x4cf/0x8e0
 [<c01eb0c6>] copy_to_user+0x36/0x60
 [<c027a1b7>] skb_recv_datagram+0xa7/0xb0
 [<c02b6d26>] udp_recvmsg+0x46/0x2b0
 [<c02bdbea>] inet_sendmsg+0x4a/0x70
 [<c0273f13>] sock_sendmsg+0xf3/0x100
 [<c027406c>] sock_recvmsg+0x10c/0x110
 [<c0287e8e>] nf_hook_slow+0xde/0x140
 [<c01169ce>] move_tasks+0x1fe/0x220
 [<c0116f95>] load_balance_newidle+0x75/0x90
 [<c012f710>] autoremove_wake_function+0x0/0x50
 [<c01eb12a>] copy_from_user+0x3a/0x80
 [<c02758b1>] sys_sendmsg+0x151/0x1a0
 [<c011596a>] activate_task+0x8a/0xa0
 [<c0115e87>] try_to_wake_up+0x237/0x260
 [<c0117878>] __wake_up+0x38/0x50
 [<c012fd85>] wake_futex+0x35/0x60
 [<c012fe2b>] futex_wake+0x7b/0xd0
 [<c0275cf2>] sys_socketcall+0x232/0x250
 [<c011febc>] sys_gettimeofday+0x2c/0x70
 [<c0102fc3>] syscall_call+0x7/0xb
Code: 89 f0 83 c4 10 5b 5e 5f 5d c3 c7 04 24 02 00 00 00 89 fa 8d 4c 24 0e =
89 e8 e8 27 07 f8 ff 31 d2 85 c0 8d 44 24 0e 0f 49 d0 eb a6 <0f> 0b 50 00 d=
a 60 34 c0 e9 4d ff ff ff c7 04 24 02 00 00 00 89=20
=20
Machine is a dual P3 Katmai.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--TbvQLmyOl28t66Jz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCqBpcHb1edYOZ4bsRAuOLAKCQx5umrRWRFVCVt07lRbMwqkPxsQCfT0/S
w+NtuHmFo5+gohDisOTZqlU=
=JLLa
-----END PGP SIGNATURE-----

--TbvQLmyOl28t66Jz--
