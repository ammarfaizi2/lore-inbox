Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVIIUxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVIIUxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVIIUxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:53:52 -0400
Received: from imap.gmx.net ([213.165.64.20]:33444 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030290AbVIIUxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:53:51 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm2 (general protection fault)
Date: Fri, 9 Sep 2005 22:57:18 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4073622.FZj0CGSeOj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509092257.24733.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4073622.FZj0CGSeOj
Content-Type: multipart/mixed;
  boundary="Boundary-01=_ycfIDjaSxXVuql0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_ycfIDjaSxXVuql0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 08 September 2005 14:30, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.=
13
>-mm2/

Hi Andrew,
here is the log from my problem with an usb device (kernel hangs when=20
switching the external hdd on). I hope this log provides useful information=
=2E=20
This bug was already in 2.6.13-mm1.

hth,
dominik

--Boundary-01=_ycfIDjaSxXVuql0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="kernel-bug.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kernel-bug.txt"

general protection fault: 0000 [1] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8026e4e6>] <ffffffff8026e4e6>{_raw_spin_trylock+6}

RSP: 0018:ffff81003e0c3d78  EFLAGS: 00010046

RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000000

RDX: 0000000000000000 RSI: 0000000000000246 RDI: 6b6b6b6b6b6b6b6b

RBP: ffff81003e0c3d78 R08: 0000000000000000 R09: ffff81003883fac8

R10: ffff81003e0c3dd8 R11: 000000000000000b R12: ffff81003fa7ff48

R13: ffff81003dbee9c8 R14: 0000000000000000 R15: ffff81003e9996c8

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 00002aaaaac56480 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: ffff81003e0c3d98 ffffffff80468a9e 000000003e0c3db8 ffff81003883e238=
=20

       ffff81003e0c3dc8 ffffffff802f858f 0000000000000082 ffff81003fa7ff48=
=20

       ffff81003fa7f4f8 ffff81003ea03450=20

Call Trace:<ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_si=
ngle_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20

<ffffffff8010f606>{show_trace+582}

PGD 3e742067 PUD 3e7a3067 PMD 0=20

Oops: 0000 [2] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8010f606>] <ffffffff8010f606>{show_trace+582}

RSP: 0018:ffff81003e0c3b28  EFLAGS: 00010092

RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001

RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001

RBP: ffff81003e0c3b78 R08: 0000000000000005 R09: 0000000000000000

R10: ffff81003e0c3a48 R11: 0000000000000000 R12: ffff81003e0c4000

R13: ffffffff80687fc0 R14: 0000000000000000 R15: 0000000000000000

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000008 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: 0000000000000000 ffffffff8071b0c0 0000000000000000 ffffffff80133c5b=
=20

       000000003e0c3b68 ffff81003e0c3dc8 000000000000000a ffffffff80687fc0=
=20

       ffffffff80683fc0 0000000000000000=20

Call Trace:<ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_st=
ack+232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff8010fae8>{die+56} <ffffffff8046962e>{do_general_protection+=
270}

       <ffffffff8010ec61>{error_exit+0} <ffffffff8026e4e6>{_raw_spin_tryloc=
k+6}

       <ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_single=
_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20

<ffffffff8010f606>{show_trace+582}

PGD 3e742067 PUD 3e7a3067 PMD 0=20

Oops: 0000 [3] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8010f606>] <ffffffff8010f606>{show_trace+582}

RSP: 0018:ffff81003e0c3858  EFLAGS: 00010092

RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001

RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001

RBP: ffff81003e0c38a8 R08: 0000000000000005 R09: 0000000000000000

R10: ffff81003e0c3778 R11: 0000000000000000 R12: ffff81003e0c4000

R13: ffffffff80687fc0 R14: 0000000000000000 R15: 0000000000000000

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000008 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: 0000000000000000 ffffffff8071b0c0 0000000000000000 ffffffff80133c5b=
=20

       000000003e0c3898 ffff81003e0c3b78 000000000000000a ffffffff80687fc0=
=20

       ffffffff80683fc0 0000000000000000=20

Call Trace:<ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_st=
ack+232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff8010fae8>{die+56} <ffffffff8046962e>{do_general_protection+=
270}

       <ffffffff8010ec61>{error_exit+0} <ffffffff8026e4e6>{_raw_spin_tryloc=
k+6}

       <ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_single=
_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20

<ffffffff8010f606>{show_trace+582}

PGD 3e742067 PUD 3e7a3067 PMD 0=20

Oops: 0000 [4] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8010f606>] <ffffffff8010f606>{show_trace+582}

RSP: 0018:ffff81003e0c3588  EFLAGS: 00010092

RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001

RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001

RBP: ffff81003e0c35d8 R08: 0000000000000005 R09: 0000000000000000

R10: ffff81003e0c34a8 R11: 0000000000000000 R12: ffff81003e0c4000

R13: ffffffff80687fc0 R14: 0000000000000000 R15: 0000000000000000

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000008 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: 0000000000000000 ffffffff8071b0c0 0000000000000000 ffffffff80133c5b=
=20

       000000003e0c35c8 ffff81003e0c38a8 000000000000000a ffffffff80687fc0=
=20

       ffffffff80683fc0 0000000000000000=20

Call Trace:<ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_st=
ack+232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff8010fae8>{die+56} <ffffffff8046962e>{do_general_protection+=
270}

       <ffffffff8010ec61>{error_exit+0} <ffffffff8026e4e6>{_raw_spin_tryloc=
k+6}

       <ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_single=
_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20

<ffffffff8010f606>{show_trace+582}

PGD 3e742067 PUD 3e7a3067 PMD 0=20

Oops: 0000 [5] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8010f606>] <ffffffff8010f606>{show_trace+582}

RSP: 0018:ffff81003e0c32b8  EFLAGS: 00010096

RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001

RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001

RBP: ffff81003e0c3308 R08: 0000000000000005 R09: 0000000000000000

R10: ffff81003e0c31d8 R11: 0000000000000000 R12: ffff81003e0c4000

R13: ffffffff80687fc0 R14: 0000000000000000 R15: 0000000000000000

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000008 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: 0000000000000000 ffffffff8071b0c0 0000000000000000 ffffffff80133c5b=
=20

       000000003e0c32f8 ffff81003e0c35d8 000000000000000a ffffffff80687fc0=
=20

       ffffffff80683fc0 0000000000000000=20

Call Trace:<ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_st=
ack+232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff8010fae8>{die+56} <ffffffff8046962e>{do_general_protection+=
270}

       <ffffffff8010ec61>{error_exit+0} <ffffffff8026e4e6>{_raw_spin_tryloc=
k+6}

       <ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_single=
_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20

<ffffffff8010f606>{show_trace+582}

PGD 3e742067 PUD 3e7a3067 PMD 0=20

Oops: 0000 [6] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8010f606>] <ffffffff8010f606>{show_trace+582}

RSP: 0018:ffff81003e0c2fe8  EFLAGS: 00010092

RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001

RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001

RBP: ffff81003e0c3038 R08: 0000000000000005 R09: 0000000000000000

R10: ffff81003e0c2f08 R11: 0000000000000000 R12: ffff81003e0c4000

R13: ffffffff80687fc0 R14: 0000000000000000 R15: 0000000000000000

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000008 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: 0000000000000000 ffffffff8071b0c0 0000000000000000 ffffffff80133c5b=
=20

       000000003e0c3028 ffff81003e0c3308 000000000000000a ffffffff80687fc0=
=20

       ffffffff80683fc0 0000000000000000=20

Call Trace:<ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_st=
ack+232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff8010fae8>{die+56} <ffffffff8046962e>{do_general_protection+=
270}

       <ffffffff8010ec61>{error_exit+0} <ffffffff8026e4e6>{_raw_spin_tryloc=
k+6}

       <ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_single=
_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20

<ffffffff8010f606>{show_trace+582}

PGD 3e742067 PUD 3e7a3067 PMD 0=20

Oops: 0000 [7] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8010f606>] <ffffffff8010f606>{show_trace+582}

RSP: 0018:ffff81003e0c2d18  EFLAGS: 00010096

RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001

RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001

RBP: ffff81003e0c2d68 R08: 0000000000000005 R09: 0000000000000000

R10: ffff81003e0c2c38 R11: 0000000000000000 R12: ffff81003e0c4000

R13: ffffffff80687fc0 R14: 0000000000000000 R15: 0000000000000000

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000008 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: 0000000000000000 ffffffff8071b0c0 0000000000000000 ffffffff80133c5b=
=20

       000000003e0c2d58 ffff81003e0c3038 000000000000000a ffffffff80687fc0=
=20

       ffffffff80683fc0 0000000000000000=20

Call Trace:<ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_st=
ack+232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff8010fae8>{die+56} <ffffffff8046962e>{do_general_protection+=
270}

       <ffffffff8010ec61>{error_exit+0} <ffffffff8026e4e6>{_raw_spin_tryloc=
k+6}

       <ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_single=
_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20

<ffffffff8010f606>{show_trace+582}

PGD 3e742067 PUD 3e7a3067 PMD 0=20

Oops: 0000 [8] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8010f606>] <ffffffff8010f606>{show_trace+582}

RSP: 0018:ffff81003e0c2a48  EFLAGS: 00010096

RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001

RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001

RBP: ffff81003e0c2a98 R08: 0000000000000005 R09: 0000000000000000

R10: ffff81003e0c2968 R11: 0000000000000000 R12: ffff81003e0c4000

R13: ffffffff80687fc0 R14: 0000000000000000 R15: 0000000000000000

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000008 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: 0000000000000000 ffffffff8071b0c0 0000000000000000 ffffffff80133c5b=
=20

       000000003e0c2a88 ffff81003e0c2d68 000000000000000a ffffffff80687fc0=
=20

       ffffffff80683fc0 0000000000000000=20

Call Trace:<ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_st=
ack+232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff8010fae8>{die+56} <ffffffff8046962e>{do_general_protection+=
270}

       <ffffffff8010ec61>{error_exit+0} <ffffffff8026e4e6>{_raw_spin_tryloc=
k+6}

       <ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_single=
_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20

<ffffffff8010f606>{show_trace+582}

PGD 3e742067 PUD 3e7a3067 PMD 0=20

Oops: 0000 [9] PREEMPT SMP=20

CPU 0=20

Modules linked in:

Pid: 2106, comm: usb-stor-scan Not tainted 2.6.13-mm2 #6

RIP: 0010:[<ffffffff8010f606>] <ffffffff8010f606>{show_trace+582}

RSP: 0018:ffff81003e0c2778  EFLAGS: 00010096

RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001

RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000001

RBP: ffff81003e0c27c8 R08: 0000000000000005 R09: 0000000000000000

R10: ffff81003e0c2698 R11: 0000000000000000 R12: ffff81003e0c4000

R13: ffffffff80687fc0 R14: 0000000000000000 R15: 0000000000000000

=46S:  00002aaaaadfdb00(0000) GS:ffffffff806e1840(0000) knlGS:0000000000000=
000

CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b

CR2: 0000000000000008 CR3: 000000003e5fa000 CR4: 00000000000006e0

Process usb-stor-scan (pid: 2106, threadinfo ffff81003e0c2000, task ffff810=
03ea03450)

Stack: 0000000000000000 ffffffff8071b0c0 0000000000000000 ffffffff80133c5b=
=20

       000000003e0c27b8 ffff81003e0c2a98 000000000000000a ffffffff80687fc0=
=20

       ffffffff80683fc0 0000000000000000=20

Call Trace:<ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_st=
ack+232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff80469f53>{do_page_fault+1843} <ffffffff8013487b>{vprintk+89=
1}

       <ffffffff8013487b>{vprintk+891} <ffffffff8010ec61>{error_exit+0}

       <ffffffff8010f606>{show_trace+582} <ffffffff8010f602>{show_trace+578}

       <ffffffff80133c5b>{print_tainted+187} <ffffffff8010f738>{show_stack+=
232}

       <ffffffff8010f7de>{show_registers+142} <ffffffff8010fa6c>{__die+156}

       <ffffffff8010fae8>{die+56} <ffffffff8046962e>{do_general_protection+=
270}

       <ffffffff8010ec61>{error_exit+0} <ffffffff8026e4e6>{_raw_spin_tryloc=
k+6}

       <ffffffff80468a9e>{_spin_lock+30} <ffffffff802f858f>{cfq_exit_single=
_io_context+95}

       <ffffffff802f8639>{cfq_exit_io_context+41} <ffffffff802eeea4>{exit_i=
o_context+148}

       <ffffffff801365ef>{do_exit+159} <ffffffff80468f1d>{_spin_unlock_irqr=
estore+29}

       <ffffffff8013718e>{complete_and_exit+30} <ffffffff803a684e>{usb_stor=
_scan_thread+414}

       <ffffffff8014b050>{autoremove_wake_function+0} <ffffffff8014b050>{au=
toremove_wake_function+0}

       <ffffffff80469014>{_spin_unlock_irq+20} <ffffffff8010ee16>{child_rip=
+8}

       <ffffffff803a66b0>{usb_stor_scan_thread+0} <ffffffff8010ee0e>{child_=
rip+0}

      =20

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:=20


--Boundary-01=_ycfIDjaSxXVuql0--

--nextPart4073622.FZj0CGSeOj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQyH3NAvcoSHvsHMnAQIQrQP7BHB08XIzI7pbbEY+hg1he6Uyu7ibsek9
hA4nwniHFJ0U8NMK8mg7MQmbSHLltV2IF0kB7lvMuINWtfezAT1KFmjMuk6DIVNC
z+HC4y8klXqf9XDWHCPcp70S/Z+UvhbSxjkrdrVax5MgPaV6quDonM3o7r8So9Cj
7Eum/7qKpXw=
=dB8z
-----END PGP SIGNATURE-----

--nextPart4073622.FZj0CGSeOj--
