Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132496AbRCZRSx>; Mon, 26 Mar 2001 12:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132491AbRCZRSo>; Mon, 26 Mar 2001 12:18:44 -0500
Received: from client38038.atl.mediaone.net ([24.88.38.38]:19959 "HELO
	whitestar.soark.net") by vger.kernel.org with SMTP
	id <S132489AbRCZRSa>; Mon, 26 Mar 2001 12:18:30 -0500
Date: Mon, 26 Mar 2001 12:17:48 -0500
From: "Zephaniah E\. Hull" <warp@whitestar.soark.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>
Subject: Lovely crash with 2.4.2-ac24.
Message-ID: <20010326121747.A3920@whitestar.soark.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This had hit me a few times with ac18 (I'm not sure it was the same
crash though) and just hit me again with ac24.

Alan cced due to it being in the ac kernels, Andre because the trace
seems to point to the IDE code.

Thanks.

Zephaniah E. Hull.

--=20
 PGP EA5198D1-Zephaniah E. Hull <warp@whitestar.soark.net>-GPG E65A7801
    Keys available at http://whitestar.soark.net/~warp/public_keys.
           CCs of replies from mailing lists are encouraged.

<cas> Mercury: gpm isn't a very good web browser.  fix it.

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=panic

ksymoops 2.3.7 on i586 2.4.2-ac24.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-ac24-c2/ (specified)
     -m /boot/2.4.2-ac24-c2/System.map (specified)

kernel BUG at printk.c:461!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0114fee>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001c   ebx: c1224120     ecx: c025373c       edx: 00000282
esi: c1291000   edi: c129116e     ebp: 00000000       esp: c026be60
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c026b000)
Stack:  00204e00 000001cd c017d8a0 c129107f c0171b9f c1291000 c1291568 c1291168
        00000000 c026bfa4 00000000 7f2ce700 c018bc35 00000000 0018b5a8 c129156d
        c129116e 000001f6 c02ce700 00000000 c02ce700 c119afc8 00000008 004c4000
Call Trace:     [<c017d8a0>] [<c0171b9f>] [<c018bc35>] [<c018d0bc>] [<c019038d>]
[<c0188009>] [<c0188062>] [<c016ff35>] [<c01197e4>] [<c011ab26>] [<c011870f>]
[<c0118647>] [<c0118550>] [<c010a152>] [<c0107120>] [<c0108df0>] [<c0107120>]
[<c0107143>] [<c01071a7>] [<c0106000>] [<c0100191>]
Code: 0f 0b 83 c4 08 b9 3c 37 25 c0 ff 0d 3c 37 25 c0 0f 88 68 64

>>EIP; c0114fee <acquire_console_sem+1e/40>   <=====
Trace; c017d8a0 <con_flush_chars+10/24>
Trace; c0171b9f <n_tty_receive_buf+e2b/edc>
Trace; c018bc35 <ide_dmaproc+13d/204>
Trace; c018d0bc <via82cxxx_dmaproc+a8/bc>
Trace; c019038d <do_rw_disk+141/318>
Trace; c0188009 <start_request+129/1f0>
Trace; c0188062 <start_request+182/1f0>
Trace; c016ff35 <flush_to_ldisc+d9/e0>
Trace; c01197e4 <proc_dointvec_minmax+20/2dc>
Trace; c011ab26 <tqueue_bh+16/1c>
Trace; c011870f <bh_action+1b/60>
Trace; c0118647 <tasklet_hi_action+3b/60>
Trace; c0118550 <do_softirq+40/64>
Trace; c010a152 <do_IRQ+a2/b0>
Trace; c0107120 <default_idle+0/28>
Trace; c0108df0 <ret_from_intr+0/20>
Trace; c0107120 <default_idle+0/28>
Trace; c0107143 <default_idle+23/28>
Trace; c01071a7 <cpu_idle+3f/54>
Trace; c0106000 <empty_bad_pte_table+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c0114fee <acquire_console_sem+1e/40>
00000000 <_EIP>:
Code;  c0114fee <acquire_console_sem+1e/40>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0114ff0 <acquire_console_sem+20/40>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0114ff3 <acquire_console_sem+23/40>
   5:   b9 3c 37 25 c0            mov    $0xc025373c,%ecx
Code;  c0114ff8 <acquire_console_sem+28/40>
   a:   ff 0d 3c 37 25 c0         decl   0xc025373c
Code;  c0114ffe <acquire_console_sem+2e/40>
  10:   0f 88 68 64 00 00         js     647e <_EIP+0x647e> c011b46c <sys_nanosleep+ec/170>

 <0>Kernel panic: Aiee, killing interrupt handler!

--h31gzZEtNLTqOjlF--

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6v3m7RFMAi+ZaeAERAnioAJ42ygF6lxUR/igl0VJVlABQw12lKQCgyjKQ
QAjH18X/i9rjMu+8TvyxKio=
=HIgk
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
