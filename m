Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFJSrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFJSrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 14:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVFJSrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 14:47:06 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:20916 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S261169AbVFJSqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 14:46:42 -0400
Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
From: Tom Duffy <tduffy@sun.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050610165315.GI13234@wotan.suse.de>
References: <1118360779.13654.4.camel@duffman>
	 <20050610165315.GI13234@wotan.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6g6w1Q7apRYD6urjWQpt"
Date: Fri, 10 Jun 2005 11:46:36 -0700
Message-Id: <1118429196.26791.15.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6g6w1Q7apRYD6urjWQpt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-06-10 at 18:53 +0200, Andi Kleen wrote:
> On Thu, Jun 09, 2005 at 04:46:19PM -0700, Tom Duffy wrote:
> > Got this panic when I recently upgraded my BIOS so that it supports k8
> > powernow on SMP dual-core.
>=20
> 2.6.12-rc has a dual core aware powernow k8 driver.

Despite the name of kernel, it is based off of 2.6.12-rc6.

Here is the panic on bootup.

Unable to handle kernel NULL pointer dereference at 0000000000000024 RIP:
<ffffffff8011dadc>{query_current_values_with_pending_wait+60}
PGD 3f255067 PUD 7fe7e067 PMD 0
Oops: 0002 [1] SMP
CPU 1
Modules linked in: mptscsih(U) mptbase(U) sd_mod scsi_mod
Pid: 33, comm: events/7 Not tainted 2.6.11-1.1381_FC5smp
RIP: 0010:[<ffffffff8011dadc>]  sdb1 sdb2
<ffffffff8011dadc>{query_current_values_with_pending_wait+60}
RSP: 0018:ffff81007fd9fdc8  EFLAGS: 00010202
RAX: 000000000000000e RBX: 0000000000000000 RCX: 00000000c0010042
RDX: 0000000000000008 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff81007fd9e000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000080
R13: 0000000000000000 R14: 0000000000000292 R15: ffffffff80112950
FS:  00000000005a5858(0000) GS:ffffffff8050ec00(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000024 CR3: 000000007fd76000 CR4: 00000000000006e0
Process events/7 (pid: 33, threadinfo ffff81007fd9e000, task ffff81007fd430=
70)
Stack: 0000000000000000 ffffffff8011e0b1 0000000000000001 ffff81007fa02d10
       ffff81007fa02d40 ffffffff802e6f23 0000000000000000 0000000000000003
       0000000000000001 0000000000000020
Call Trace:<ffffffff8011e0b1>{powernowk8_get+129} <ffffffff802e6f23>{cpufre=
q_get+115}
       <ffffffff8011298a>{handle_cpufreq_delayed_get+58} <ffffffff8014b9dc>=
{worker_thread+476}
       <ffffffff80134710>{default_wake_function+0} <ffffffff801326a3>{__wak=
e_up_common+67}
       <ffffffff8014b800>{worker_thread+0} <ffffffff80150469>{kthread+217}
       <ffffffff80135c90>{schedule_tail+64} <ffffffff8010f76b>{child_rip+8}
       <ffffffff8011d680>{flat_send_IPI_mask+0} <ffffffff80150390>{kthread+=
0}
       <ffffffff8010f763>{child_rip+0}

Code: 89 47 24 89 57 20 31 c0 48 83 c4 08 c3 66 66 66 90 66 66 90
RIP <ffffffff8011dadc>{query_current_values_with_pending_wait+60} RSP <ffff=
81007fd9fdc8>
CR2: 0000000000000024
 <3>Debug: sleeping function called from invalid context at include/linux/r=
wsem.h:43
in_atomic():0, irqs_disabled():1

Call Trace:<ffffffff8013abc5>{profile_task_exit+21} <ffffffff8013bfe2>{do_e=
xit+34}
       <ffffffff80267378>{do_unblank_screen+40} <ffffffff80124286>{do_page_=
fault+1926}
       <ffffffff8035c032>{thread_return+0} <ffffffff8035c084>{thread_return=
+82}
       <ffffffff8013433d>{activate_task+141} <ffffffff80112950>{handle_cpuf=
req_delayed_get+0}
       <ffffffff8010f5b5>{error_exit+0} <ffffffff80112950>{handle_cpufreq_d=
elayed_get+0}
       <ffffffff8011dadc>{query_current_values_with_pending_wait+60}
       <ffffffff8011e0b1>{powernowk8_get+129} <ffffffff802e6f23>{cpufreq_ge=
t+115}
       <ffffffff8011298a>{handle_cpufreq_delayed_get+58} <ffffffff8014b9dc>=
{worker_thread+476}
       <ffffffff80134710>{default_wake_function+0} <ffffffff801326a3>{__wak=
e_up_common+67}
       <ffffffff8014b800>{worker_thread+0} <ffffffff80150469>{kthread+217}
       <ffffffff80135c90>{schedule_tail+64} <ffffffff8010f76b>{child_rip+8}
       <ffffffff8011d680>{flat_send_IPI_mask+0} <ffffffff80150390>{kthread+=
0}
       <ffffffff8010f763>{child_rip+0}

-tduffy

--=-6g6w1Q7apRYD6urjWQpt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCqeAMdY502zjzwbwRAsraAJ4k3B/9MbPdcl7D+3k543DAOv9ipQCfbydg
h0xSp9VsaaSRzzj/Et36WPk=
=rsvC
-----END PGP SIGNATURE-----

--=-6g6w1Q7apRYD6urjWQpt--
