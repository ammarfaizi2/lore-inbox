Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUJOXQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUJOXQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 19:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUJOXQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 19:16:50 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:27152 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267350AbUJOXQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 19:16:47 -0400
Date: Fri, 15 Oct 2004 16:16:09 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041015231609.GA23505@nietzsche.lynx.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20041015102633.GA20132@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2004 at 12:26:33PM +0200, Ingo Molnar wrote:
> 
> i have released the -U3 PREEMPT_REALTIME patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3

Atomic violations:

bill


--17pEHd4RhPHOinZp
Content-Type: application/x-troff
Content-Disposition: attachment; filename=t
Content-Transfer-Encoding: quoted-printable

Debug: sleeping function called from invalid context swapper(0) at kernel/m=
utex.c:25=0Ain_atomic():1 [00010002], irqs_disabled():1=0A [<c011db0a>] __m=
ight_sleep+0xca/0xe0=0A [<c0136d09>] _mutex_lock+0x29/0x70=0A [<c010c77d>] =
set_rtc_mmss+0x1d/0x1d0=0A [<c0129d39>] update_wall_time_one_tick+0x9/0xb0=
=0A [<c0129df5>] update_wall_time+0x15/0x50=0A [<c010ca4f>] timer_interrupt=
+0xff/0x130=0A [<c013f8e6>] handle_IRQ_event+0x46/0x80=0A [<c013fa27>] __do=
_IRQ+0x107/0x160=0A [<c0108e0b>] do_IRQ+0x4b/0x60=0A [<c0104340>] default_i=
dle+0x0/0x40=0A [<c01070b8>] common_interrupt+0x18/0x20=0A [<c0104340>] def=
ault_idle+0x0/0x40=0A [<c011007b>] mtrr_del_page+0x3b/0x1d0=0A [<c010437a>]=
 default_idle+0x3a/0x40=0A [<c0104423>] cpu_idle+0x63/0x90=0A [<c0628a5c>] =
start_kernel+0x1ac/0x1f0=0A [<c0628440>] unknown_bootoption+0x0/0x180=0Apre=
empt count: 2=0Aentry 1: cpu_idle+0x38/0x90 / (start_kernel+0x1ac/0x1f0)=0A=
entry 2: _spin_lock+0x22/0x80 / (timer_interrupt+0x1b/0x130)=0A=0A=0A=0A=0A=
Initializing CPU#0=0AKernel command line: root=3D/dev/sdb2 maxcpus=3D1 prof=
ile=3D2 kgdbwwait kgdb8250=3D1,38400 console=3Dtty0 console=3Dkgdb mem=3D52=
4288K=0Akernel profiling enabled (shift: 2)=0A(swapper/0): new 265219 us ma=
ximum-latency critical section.=0A =3D> started at: <start_kernel+0x48/0x1f=
0>=0A =3D> ended at:   <cond_resched+0x25/0x80>=0A [<c0138108>] touch_preem=
pt_timing+0x48/0x50=0A [<c0138022>] check_preempt_timing+0x162/0x200=0A [<c=
04e8ed5>] cond_resched+0x25/0x80=0A [<c0138108>] touch_preempt_timing+0x48/=
0x50=0A [<c04e8ed5>] cond_resched+0x25/0x80=0A [<c04e8ed5>] cond_resched+0x=
25/0x80=0A [<c013968d>] register_cpu_notifier+0x2d/0x80=0A [<c0639ad7>] rcu=
_init+0x97/0xa0=0A [<c062896c>] start_kernel+0xbc/0x1f0=0A [<c0628440>] unk=
nown_bootoption+0x0/0x180=0Apreempt count: 1=0Aentry 1: start_kernel+0x48/0=
x1f0 / (0xc0100211)=0APID hash table entries: 4096 (order: 12, 65536 bytes)=
=0A(swapper/0): new 382088 us maximum-latency critical section.=0A =3D> sta=
rted at: <cond_resched+0x25/0x80>=0A =3D> ended at:   <cond_resched+0x25/0x=
80>=0A [<c0138108>] touch_preempt_timing+0x48/0x50=0A [<c0138022>] check_pr=
eempt_timing+0x162/0x200=0A [<c04e8ed5>] cond_resched+0x25/0x80=0A [<c01381=
08>] touch_preempt_timing+0x48/0x50=0A [<c04e8ed5>] cond_resched+0x25/0x80=
=0A [<c04e8ed5>] cond_resched+0x25/0x80=0A [<c013968d>] register_cpu_notifi=
er+0x2d/0x80=0A [<c0639775>] init_timers+0x35/0x60=0A [<c062897b>] start_ke=
rnel+0xcb/0x1f0=0A [<c0628440>] unknown_bootoption+0x0/0x180=0Apreempt coun=
t: 1=0Aentry 1: start_kernel+0x48/0x1f0 / (0xc0100211)=0ADetected 852.053 M=
Hz processor.=0AUsing tsc for high-res timesource=0A(swapper/0): new 744706=
 us maximum-latency critical section.=0A =3D> started at: <cond_resched+0x2=
5/0x80>=0A =3D> ended at:   <cond_resched+0x25/0x80>=0A [<c0138108>] touch_=
preempt_timing+0x48/0x50=0A [<c0138022>] check_preempt_timing+0x162/0x200=
=0A [<c04e8ed5>] cond_resched+0x25/0x80=0A [<c0138108>] touch_preempt_timin=
g+0x48/0x50=0A [<c04e8ed5>] cond_resched+0x25/0x80=0A [<c04e8ed5>] cond_res=
ched+0x25/0x80=0A [<c0136d11>] _mutex_lock+0x31/0x70=0A [<c0136da6>] _mutex=
_lock_irqsave+0x16/0x20=0A [<c03a0587>] tty_register_ldisc+0x37/0xc0=0A [<c=
0642068>] console_init+0x28/0x50=0A [<c062898a>] start_kernel+0xda/0x1f0=0A=
 [<c0628440>] unknown_bootoption+0x0/0x180=0Apreempt count: 1=0Aentry 1: st=
art_kernel+0x48/0x1f0 / (0xc0100211)=0A=0A=0A=0A
--17pEHd4RhPHOinZp--
