Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUH3MJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUH3MJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUH3MJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:09:33 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:62184 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S267815AbUH3MI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:08:29 -0400
Date: Mon, 30 Aug 2004 17:38:09 +0530
From: Joshua N Pritikin <jpritikin@pobox.com>
To: coreteam@netfilter.org
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: an oops possibly due to an SMP related bug in netfilter
Message-ID: <20040830120809.GB1029@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
X-Request-PGP: http://openheartlogic.org/personal/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With a big thanks to netconsole, I am able to present you with an oops
in the netfilter code.  This occurred in a vanilla 2.6.7 kernel.  Let
me know what more details I can provide about the system in question.

(Perhaps I am one of the few people crazy enough to run a firewall on
an SMP machine.  ;-)

Unable to handle kernel NULL pointer dereference
 at virtual address 00000000=20
 printing eip:=20
c8895955=20
*pde =3D 00000000=20
Oops: 0000 [#1]=20
SMP=20
=20
Modules linked in:
 netconsole
 mga
 nbd
 ipt_MASQUERADE
 iptable_nat
 ipt_LOG
 ipt_limit
 ipt_state
 iptable_filter
 ip_tables
 dm_mod
 reiserfs
 snd_dummy
 snd_pcm_oss
 snd_mixer_oss
 snd_pcm
 snd_timer
 snd
 snd_page_alloc
 sctp
 via_agp
 agpgart
 af_key
 rtc
 8139too
 mii
 crc32
 psmouse
 uhci_hcd
 ip_conntrack_ftp
 ip_conntrack
=20
CPU:    0=20
EIP:    0060:[<c8895955>]    Not tainted=20
EFLAGS: 00010246   (2.6.7) =20
EIP is at __ip_conntrack_find+0x179/0x1a0 [ip_conntrack]=20
eax: 00000001   ebx: 00000000   ecx: c0353cc0   edx: 00000000=20
esi: 00000000   edi: 00000000   ebp: c0353c88   esp: c0353c6c=20
ds: 007b   es: 007b   ss: 0068=20
Process swapper (pid: 0, threadinfo=3Dc0352000 task=3Dc0300980)
=20
Stack:=20
c0352000=20
c7ced540=20
00000000=20
c600ce2c=20
00000768=20
c0352000=20
00000000=20
c0353ca0=20
=20
      =20
c889600c=20
c0353cc0=20
c7ced540=20
c0353cc0=20
c7ced540=20
c0353cd0=20
c89a8e9f=20
c0353cc0=20
=20
      =20
c7ced540=20
c0353cc0=20
c0353d8c=20
c0353dbc=20
c0353d8c=20
02130644=20
c0356e00=20
0400a8c0=20
=20
Call Trace:=20
 [<c01068e3>]=20
show_stack+0x83/0x90
=20
 [<c0106a22>]=20
show_registers+0x112/0x17c
=20
 [<c0106b90>]=20
die+0x7c/0xe8
=20
 [<c011385b>]=20
do_page_fault+0x337/0x48e
=20
 [<c0106571>]=20
error_code+0x2d/0x38
=20
 [<c889600c>]=20
ip_conntrack_tuple_taken+0x90/0xec [ip_conntrack]
=20
 [<c89a8e9f>]=20
ip_nat_used_tuple+0x1f/0x28 [iptable_nat]
=20
 [<c89a957b>]=20
get_unique_tuple+0xe7/0x1e8 [iptable_nat]
=20
 [<c89a9706>]=20
ip_nat_setup_info+0x8a/0x350 [iptable_nat]
=20
 [<c89a89ee>]=20
ip_nat_rule_find+0x8e/0x9c [iptable_nat]
=20
 [<c89a81f7>]=20
gcc2_compiled.+0x1f7/0x2cc [iptable_nat]
=20
 [<c0240df6>]=20
nf_iterate+0x3a/0xb0
=20
 [<c0241128>]=20
nf_hook_slow+0xa0/0x128
=20
 [<c024cd40>]=20
ip_rcv+0x1b8/0x204
=20
 [<c0238954>]=20
netif_receive_skb+0x150/0x180
=20
 [<c88c9c8d>]=20
rtl8139_rx+0x191/0x240 [8139too]
=20
 [<c88c9eb2>]=20
rtl8139_poll+0x4e/0xd8 [8139too]
=20
 [<c0238b1b>]=20
net_rx_action+0x7f/0x120
=20
 [<c011d6ed>]=20
__do_softirq+0x5d/0xbc
=20
 [<c011d777>]=20
do_softirq+0x2b/0x3c
=20
 [<c0107d45>]=20
do_IRQ+0x111/0x120
=20
 [<c0106474>]=20
common_interrupt+0x18/0x20
=20
 [<c0103fb6>]=20
cpu_idle+0x3a/0x48
=20
 [<c01002b9>]=20
rest_init+0x49/0x50
=20
 [<c0354968>]=20
start_kernel+0x1a4/0x1a8
=20
 [<c01001e0>]=20
0xc01001e0
=20
=20
Code:=20
8b=20
03=20
0f=20
18=20
00=20
90=20
8b=20
45=20
f4=20
03=20
05=20
0c=20
f0=20
89=20
c8=20
39=20
c3=20
0f=20
85=20
39=20
=20
=20
Kernel panic: Fatal exception in interrupt=20
In interrupt handler - not syncing=20
=20
-------
Here is my NAT table:

always:~# iptables -t nat -L -v
Chain PREROUTING (policy ACCEPT 10 packets, 626 bytes)
 pkts bytes target     prot opt in     out     source               destina=
tion=20

Chain POSTROUTING (policy ACCEPT 41 packets, 3413 bytes)
 pkts bytes target     prot opt in     out     source               destina=
tion=20
   98  6388 MASQUERADE  all  --  any    eth1    anywhere             anywhe=
re=20

Chain OUTPUT (policy ACCEPT 136 packets, 9621 bytes)
 pkts bytes target     prot opt in     out     source               destina=
tion=20

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBMxipqcqnlKSmC70RAu7CAJwPJw+TdKk45w5oO6QirXYs+tijqQCeNA12
CwspE7DnMZ23thrbi0FqSAA=
=KIxd
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
