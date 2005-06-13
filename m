Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVFNAV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVFNAV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFNAUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:20:10 -0400
Received: from amdext4.amd.com ([163.181.251.6]:62954 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S261467AbVFMVrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:47:53 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] [OOPS] powernow on smp dual core amd64
Date: Mon, 13 Jun 2005 16:47:35 -0500
Message-ID: <84EA05E2CA77634C82730353CBE3A84301CFC14C@SAUSEXMB1.amd.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [OOPS] powernow on smp dual core amd64
Thread-Index: AcVwXtL5QTmAHd/jRm2DXC6YGKj5VAAAUNRA
From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
To: "Tom Duffy" <tduffy@sun.com>
cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
X-WSS-ID: 6EB321722DO7600284-01-01
Content-Type: multipart/mixed;
 boundary="----_=_NextPart_001_01C57061.828EB914"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C57061.828EB914
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable

> powernow-k8: Found 8 AMD Athlon 64 / Opteron processors=20
> (version 1.40.2)
> powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
> cpu_init done, current fid 0xe, vid 0x8
> powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
> cpu_init done, current fid 0xe, vid 0x8
> powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
> cpu_init done, current fid 0xe, vid 0x8
> powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8 (1350 mV)
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
> cpu_init done, current fid 0xe, vid 0x8

>  sdb:<3>powernowk8_get() cpu is 1
> Unable to handle kernel NULL pointer dereference at=20
> 0000000000000024 RIP:=20
> <ffffffff8011d94c>{query_current_values_with_pending_wait+60}=20
> sdb1 sdb2
>=20
> PGD 3fe74067 PUD 3fd28067 PMD 0
> Oops: 0002 [1] SMP
> CPU 1
> Modules linked in: mptscsih mptbase sd_mod scsi_mod
> Pid: 25, comm: events/7 Not tainted 2.6.12-rc6andro
> RIP: 0010:[<ffffffff8011d94c>]=20
> <ffffffff8011d94c>{query_current_values_with_pending_wait+60}
> RSP: 0000:ffff81007fddbdc8  EFLAGS: 00010202
> RAX: 000000000000000e RBX: 0000000000000000 RCX: 00000000c0010042
> RDX: 0000000000000008 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000080 R08: ffff81007fdda000 R09: ffff81003fd421f0
> R10: 000000000000001c R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000283 R15: ffffffff80112630
> FS:  000000000057d850(0000) GS:ffffffff80498180(0000)=20
> knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000024 CR3: 000000003f415000 CR4:=20
> 00000000000006e0 Process events/7 (pid: 25, threadinfo=20
> ffff81007fdda000, task ffff81003fd421f0)
> Stack: 0000000000000080 ffffffff8011dea1 0000000000000001=20
> ffff81003fd91430
>        ffff81003fd91400 ffffffff802e2b90 0000000000000000=20
> 0000000000000003
>        ffff81007fddbe48 0000000000000001
> Call Trace:<ffffffff8011dea1>{powernowk8_get+145}=20
> <ffffffff802e2b90>{cpufreq_get+96}
>        <ffffffff8011266a>{handle_cpufreq_delayed_get+58}=20
> <ffffffff80148eec>{worker_thread+476}
>        <ffffffff801326d0>{default_wake_function+0}=20
> <ffffffff80130733>{__wake_up_common+67}
>        <ffffffff80148d10>{worker_thread+0}=20
> <ffffffff8014d7a9>{kthread+217}
>        <ffffffff80133be0>{schedule_tail+64}=20
> <ffffffff8010f5b7>{child_rip+8}
>        <ffffffff8011d4f0>{flat_send_IPI_mask+0}=20
> <ffffffff8014d6d0>{kthread+0}
>        <ffffffff8010f5af>{child_rip+0}
>=20
> Code: 89 47 24 89 57 20 31 c0 48 83 c4 08 c3 66 66 66 90 66=20
> 66 90 RIP=20
> <ffffffff8011d94c>{query_current_values_with_pending_wait+60}=20
> RSP <ffff81007fddbdc8>
> CR2: 0000000000000024
>  <5>Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0=20

Okay, I think I have figured this out.  During initialization,
the cpufreq infrastruture only initializes the first core of
each processor.  When a request comes into the second core,
it's data structre is unitialized and we get the null point
dereference.

The solution is to assign the pointer to the data structure for
the first core to all the other cores.

Tom, could you try this patch and see if it helps?

-Mark Langsdorf
AMD, Inc.

------_=_NextPart_001_01C57061.828EB914
Content-Type: application/octet-stream;
 name=jhpn-2.6.12-rc6.patch
Content-Transfer-Encoding: base64
Content-Description: jhpn-2.6.12-rc6.patch
Content-Disposition: attachment;
 filename=jhpn-2.6.12-rc6.patch

LS0tIGxpbnV4LTIuNi4xMi1yYzYvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY3B1ZnJlcS9wb3dlcm5v
dy1rOC5jLm9sZAkyMDA1LTA2LTEyIDE3OjQxOjU1LjEyMzY1MTE4NCAtMDUwMAorKysgbGludXgt
Mi42LjEyLXJjNi9hcmNoL2kzODYva2VybmVsL2NwdS9jcHVmcmVxL3Bvd2Vybm93LWs4LmMJMjAw
NS0wNi0xMiAxNzo0NjozMi43ODA0NDA5MzYgLTA1MDAKQEAgLTQ0LDcgKzQ0LDcgQEAKIAogI2Rl
ZmluZSBQRlggInBvd2Vybm93LWs4OiAiCiAjZGVmaW5lIEJGWCBQRlggIkJJT1MgZXJyb3I6ICIK
LSNkZWZpbmUgVkVSU0lPTiAidmVyc2lvbiAxLjQwLjIiCisjZGVmaW5lIFZFUlNJT04gInZlcnNp
b24gMS40MC40IgogI2luY2x1ZGUgInBvd2Vybm93LWs4LmgiCiAKIC8qIHNlcmlhbGl6ZSBmcmVx
IGNoYW5nZXMgICovCkBAIC05NzgsNyArOTc4LDcgQEAKIHsKIAlzdHJ1Y3QgcG93ZXJub3dfazhf
ZGF0YSAqZGF0YTsKIAljcHVtYXNrX3Qgb2xkbWFzayA9IENQVV9NQVNLX0FMTDsKLQlpbnQgcmM7
CisJaW50IHJjLCBpOwogCiAJaWYgKCFjaGVja19zdXBwb3J0ZWRfY3B1KHBvbC0+Y3B1KSkKIAkJ
cmV0dXJuIC1FTk9ERVY7CkBAIC0xMDY0LDcgKzEwNjQsOSBAQAogCXByaW50aygiY3B1X2luaXQg
ZG9uZSwgY3VycmVudCBmaWQgMHgleCwgdmlkIDB4JXhcbiIsCiAJICAgICAgIGRhdGEtPmN1cnJm
aWQsIGRhdGEtPmN1cnJ2aWQpOwogCi0JcG93ZXJub3dfZGF0YVtwb2wtPmNwdV0gPSBkYXRhOwor
CWZvcl9lYWNoX2NwdV9tYXNrKGksIGNwdV9jb3JlX21hcFtwb2wtPmNwdV0pIHsKKwkJcG93ZXJu
b3dfZGF0YVtpXSA9IGRhdGE7CisJfQogCiAJcmV0dXJuIDA7CiAK

------_=_NextPart_001_01C57061.828EB914--

