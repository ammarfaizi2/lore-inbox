Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277436AbUKBJBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277436AbUKBJBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291757AbUKBJAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:00:46 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:22544 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S310655AbUKBI5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:57:35 -0500
Date: Tue, 2 Nov 2004 00:56:50 -0800
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5 (networking problems)
Message-ID: <20041102085650.GA3973@nietzsche.lynx.com>
References: <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <417F7D7D.5090205@stud.feec.vutbr.cz> <20041027134822.GA7980@elte.hu> <417FD9F2.8060002@stud.feec.vutbr.cz> <20041028115719.GA9563@elte.hu> <20041030000234.GA20986@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20041030000234.GA20986@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 29, 2004 at 05:02:34PM -0700, Bill Huey wrote:
> This is in -V5.14

[nasty networking crash trace]

Didn't fix it all...

bill



--sm4nu43k4a2Rpi4c
Content-Type: application/x-troff
Content-Disposition: attachment; filename=t
Content-Transfer-Encoding: quoted-printable

                 180kB/s 1m10s=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0ABUG: circular semaphore deadlock detected!=0A---=
--------------------------------------------=0Aksoftirqd/0/3 is deadlocking=
 current task rpciod/0/250=0A=0A=0A1) rpciod/0/250 is trying to acquire thi=
s lock:=0A [dfefa1a4] {r:0,a:-1,&dev->xmit_lock}=0A.. held by:       ksofti=
rqd/0/    3 [c17946b0, 105]=0A... acquired at:  qdisc_restart+0x262/0x280=
=0A... at: qdisc_restart+0x262/0x280=0A=0A2) ksoftirqd/0/3 is blocked on th=
is lock:=0A [c045cd80] {r:0,a:-1,ptype_lock}=0A.. held by:          rpciod/=
0/  250 [df7ace40, 106]=0A... acquired at:  qdisc_restart+0x24f/0x280=0A=0A=
------------------------------=0A| showing all locks held by: |  (rpciod/0/=
250 [df7ace40, 106]):=0A------------------------------=0A=0A#001:          =
   [c045cd80] {r:0,a:-1,ptype_lock}=0A... acquired at:  qdisc_restart+0x24f=
/0x280=0A=0A------------------------------=0A| showing all locks held by: |=
  (ksoftirqd/0/3 [c17946b0, 105]):=0A------------------------------=0A=0A#0=
01:             [dfefa1a4] {r:0,a:-1,&dev->xmit_lock}=0A... acquired at:  q=
disc_restart+0x262/0x280=0A=0Aksoftirqd/0/3's [blocked] stackdump:=0A=0Ac17=
9fe64 00000046 c17946b0 c140c820 c179e000 c17946b0 c179fe20 c0138fed =0A   =
    c013deeb c0108e33 00000202 c01148ec 00000000 00000001 dce400a0 00000000=
 =0A       c179e000 c17946b0 df7ace40 c140c820 00002102 439c2336 0000015a c=
179488c =0ACall Trace:=0A [<c03930a0>] schedule+0x40/0x140 (36)=0A [<c03945=
11>] down_write_mutex+0x1e1/0x290 (92)=0A [<c031c341>] dev_queue_xmit_nit+0=
x41/0x130 (36)=0A [<c032987f>] qdisc_restart+0x24f/0x280 (56)=0A [<c031cd5f=
>] net_tx_action+0xbf/0x150 (44)=0A [<c0126d92>] ___do_softirq+0xc2/0x120 (=
48)=0A [<c0126eb5>] _do_softirq+0x25/0x30 (8)=0A [<c0127446>] ksoftirqd+0xc=
6/0x100 (24)=0A [<c0137dcb>] kthread+0xbb/0xc0 (48)=0A [<c0104559>] kernel_=
thread_helper+0x5/0xc (1048969236)=0A---------------------------=0A| preemp=
t count: 00000002 ]=0A| 2-level deep critical section nesting:=0A----------=
------------------------------=0A.. [<c039285f>] .... __schedule+0x4f/0x850=
=0A.....[<c03930a0>] ..   ( <=3D schedule+0x40/0x140)=0A.. [<c0394ac2>] ...=
=2E _spin_lock_irqsave+0x22/0x80=0A.....[<c03928fe>] ..   ( <=3D __schedule=
+0xee/0x850)=0A=0A=0Arpciod/0/250's [current] stackdump:=0A=0A[<c020f0e3>] =
check_deadlock+0x1d3/0x270=0A[<c020f6e5>] task_blocks_on_sem+0x165/0x1c0=0A=
[<c03944bb>] down_write_mutex+0x18b/0x290=0A[<c0138924>] __mutex_lock+0x44/=
0x60=0A[<c013895d>] _mutex_lock+0x1d/0x30=0A[<c0329892>] qdisc_restart+0x26=
2/0x280=0A[<c0335439>] ip_finish_output+0xd9/0x280=0A[<c033660f>] ip_fragme=
nt+0x6bf/0x860=0A[<c033587b>] ip_output+0x8b/0xa0=0A[<c0337936>] ip_push_pe=
nding_frames+0x356/0x520=0A[<c0357a20>] udp_push_pending_frames+0x160/0x260=
=0A[<c0357f22>] udp_sendmsg+0x3b2/0x7b0=0A[<c03605f0>] inet_sendmsg+0x50/0x=
60=0A[<c0311dd0>] sock_sendmsg+0xc0/0xe0=0A[<c0311e37>] kernel_sendmsg+0x47=
/0x60=0A[<c0358441>] udp_sendpage+0x121/0x150=0A[<c036068f>] inet_sendpage+=
0x8f/0xc0=0A[<c038dc0f>] xdr_sendpages+0x17f/0x280=0A=0Ashowing all tasks:=
=0As            init/    1 [c17953d0, 117] (not blocked)=0As     migration/=
0/    2 [c1794d40,   0] (not blocked)=0AR     ksoftirqd/0/    3 [c17946b0, =
105] blocked on: [c045cd80] {r:0,a:-1,ptype_lock}=0A.. held by:          rp=
ciod/0/  250 [df7ace40, 106]=0A... acquired at:  qdisc_restart+0x24f/0x280=
=0As       desched/0/    4 [c1794020, 105] (not blocked)=0As        events/=
0/    5 [c17b53f0,  98] (not blocked)=0As         khelper/    6 [c17b4d60, =
115] (not blocked)=0As         kthread/    7 [c17b46d0, 107] (not blocked)=
=0As       kblockd/0/    8 [c17b4040, 105] (not blocked)=0As           khub=
d/    9 [dfdd5410, 125] (not blocked)=0As         pdflush/   10 [dfdd4d80, =
118] (not blocked)=0As         pdflush/   11 [dfdd46f0, 116] (not blocked)=
=0As           aio/0/   13 [dfdfd430, 107] (not blocked)=0As         kswapd=
0/   12 [dfdd4060, 116] (not blocked)=0As           IRQ 8/   14 [dfdfcda0, =
 56] (not blocked)=0As          IRQ 12/   16 [dfdfc080,  54] (not blocked)=
=0As           IRQ 6/   17 [dfee5450,  50] (not blocked)=0As         kserio=
d/   15 [dfdfc710, 125] (not blocked)=0As          IRQ 14/   18 [dfee4dc0, =
 51] (not blocked)=0As          IRQ 15/   19 [dfee4730,  52] (not blocked)=
=0As          IRQ 16/   20 [dfee40a0,  53] (not blocked)=0As       scsi_eh_=
0/   21 [dff25470, 119] blocked on: [dff27fa8] {r:0,a:-1,sem.lock}=0A.. hel=
d by:         scsi_eh_0/   21 [dff25470, 119]=0A... acquired at:  scsi_erro=
r_handler+0x5a/0x1d0=0As        ahc_dv_0/   22 [dff24de0, 116] blocked on: =
[dfed99a8] {r:0,a:-1,&ahc->platform_dat}=0A.. held by:          ahc_dv_0/  =
 22 [dff24de0, 116]=0A... acquired at:  ahc_linux_release_simq+0xdd/0xf0=0A=
s           IRQ 1/   23 [dff240c0,  55] (not blocked)=0As       kjournald/ =
  24 [dff24750, 116] (not blocked)=0As           IRQ 4/  153 [dfad40e0,  57=
] (not blocked)=0As           IRQ 3/  156 [dfad4770,  58] (not blocked)=0As=
          IRQ 18/  239 [df4f74b0,  59] (not blocked)=0As         portmap/  =
244 [df4f6790, 116] (not blocked)=0AR        rpciod/0/  250 [df7ace40, 106]=
 (not blocked)=0As           lockd/  251 [df7ac7b0, 118] (not blocked)=0As =
        syslogd/  335 [df7ac120, 116] (not blocked)=0As           klogd/  3=
38 [df4f6100, 117] (not blocked)=0As            famd/  355 [dee7ee80, 119] =
(not blocked)=0As             gpm/  359 [df4f6e20, 116] (not blocked)=0As  =
         inetd/  364 [dfad4e00, 120] (not blocked)=0As            ntop/  37=
1 [dee7e7f0, 116] (not blocked)=0As            ntop/  460 [dce24850, 116] (=
not blocked)=0As            ntop/  461 [dd5d4180, 117] (not blocked)=0As   =
         ntop/  462 [dcd1e1a0, 117] (not blocked)=0As            ntop/  463=
 [dcd1f550, 117] (not blocked)=0As            ntop/  487 [dc45d5b0, 117] (n=
ot blocked)=0As            ntop/  492 [dc8c8870, 117] (not blocked)=0AR    =
        ntop/  494 [dc8c81e0, 115] (not blocked)=0As            sshd/  380 =
[dd5d5530, 120] (not blocked)=0As             xfs/  390 [df7ad4d0, 116] (no=
t blocked)=0As       rpc.statd/  478 [dd5d4ea0, 117] (not blocked)=0As     =
        atd/  512 [dcd1eec0, 118] (not blocked)=0As            cron/  518 [=
dce241c0, 117] (not blocked)=0As           getty/  532 [dfad5490, 117] (not=
 blocked)=0As           getty/  533 [dce24ee0, 117] (not blocked)=0As      =
     getty/  534 [dcd1e830, 117] (not blocked)=0As           getty/  535 [d=
ce25570, 117] (not blocked)=0As           getty/  536 [dc45c890, 117] (not =
blocked)=0As           getty/  538 [df35b5d0, 117] (not blocked)=0As       =
    getty/  539 [df35af40, 116] (not blocked)=0As            tcsh/  540 [de=
e7e160, 117] (not blocked)=0As             csh/  577 [dd5d4810, 117] (not b=
locked)=0As       mass_test/ 3320 [df35a220, 118] (not blocked)=0As        =
    find/ 3322 [dc45cf20, 119] (not blocked)=0AR         apt-get/ 9083 [caf=
51690, 115] (not blocked)=0AR            http/ 9706 [caf502e0, 115] (not bl=
ocked)=0AR            find/11732 [dee7f510, 120] (not blocked)=0A=0A-------=
--------------------=0A| showing all locks held: |=0A----------------------=
-----=0A=0A#001:             [cac38168] {r:0,a:-1,kernel/fork.c:342}=0A.. h=
eld by:              find/11732 [dee7f510, 120]=0A... acquired at:  exit_mm=
ap+0x2a/0x130=0A=0A#002:             [c03fcc00] {r:0,a:-1,&zone->lru_lock}=
=0A.. held by:              find/11732 [dee7f510, 120]=0A... acquired at:  =
__page_cache_release+0x2d/0x120=0A=0A#003:             [c045cd80] {r:0,a:-1=
,ptype_lock}=0A.. held by:          rpciod/0/  250 [df7ace40, 106]=0A... ac=
quired at:  qdisc_restart+0x24f/0x280=0A=0A#004:             [dfefa1a4] {r:=
0,a:-1,&dev->xmit_lock}=0A.. held by:       ksoftirqd/0/    3 [c17946b0, 10=
5]=0A... acquired at:  qdisc_restart+0x262/0x280=0A=0A#005:             [df=
efa1e8] {r:0,a:-1,&dev->queue_lock}=0A.. held by:          rpciod/0/  250 [=
df7ace40, 106]=0A... acquired at:  dev_queue_xmit+0x1fe/0x2d0=0A=0A#006:   =
          [c0455300] {r:0,a:-1,tasklist_lock}=0A.. held by:          rpciod=
/0/  250 [df7ace40, 106]=0A... acquired at:  show_all_locks+0x30/0x130=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=0A=0A=0A=0A
--sm4nu43k4a2Rpi4c--
