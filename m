Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWDLNvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWDLNvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 09:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWDLNvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 09:51:41 -0400
Received: from lama.bgc-jena.mpg.de ([195.37.229.21]:49101 "EHLO
	lama.bgc-jena.mpg.de") by vger.kernel.org with ESMTP
	id S932173AbWDLNvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 09:51:40 -0400
Message-ID: <443D056F.9030004@bgc-jena.mpg.de>
Date: Wed, 12 Apr 2006 15:49:35 +0200
From: "Dr.Peer-Joachim Koch" <pkoch@bgc-jena.mpg.de>
Organization: MPI for Biogeochemistry
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NFSD stops working
References: <443B8417.8020706@bgc-jena.mpg.de>
In-Reply-To: <443B8417.8020706@bgc-jena.mpg.de>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040609070004030105090100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040609070004030105090100
Content-Type: multipart/mixed;
 boundary="------------070604020500060206090907"

This is a multi-part message in MIME format.
--------------070604020500060206090907
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

here is some output from /var/log/messages

and also this one comes sometimes very often:
Apr 11 15:07:34 sizilia kernel: RPC svc_write_space: some sleeping on 
00000100eeb86c80
Apr 11 15:07:51 sizilia last message repeated 1829 times
                                               ^^^^

sizilia:~ # grep "Apr 11 16:34" /var/log/messages
Apr 11 16:34:04 sizilia kernel: Unable to handle kernel NULL pointer 
dereference at 000000000000003c RIP:
Apr 11 16:34:04 sizilia kernel: <ffffffff80231b56>{__down_read+6}
Apr 11 16:34:04 sizilia kernel: PML4 ebfb3067 PGD f08b0067 PMD 0
Apr 11 16:34:04 sizilia kernel: Oops: 0002 [1] SMP
Apr 11 16:34:04 sizilia kernel: CPU 0
Apr 11 16:34:04 sizilia kernel: Pid: 32304, comm: nfsd Tainted: P   U 
(2.6.5-7.191-smp SLES9_SP2_BRANCH-200506281458560000)
Apr 11 16:34:04 sizilia kernel: RIP: 0010:[<ffffffff80231b56>] 
<ffffffff80231b56>{__down_read+6}
Apr 11 16:34:04 sizilia kernel: RSP: 0018:00000100e5b13688  EFLAGS: 00010006
Apr 11 16:34:04 sizilia kernel: RAX: 00000100f2a84d20 RBX: 
fffffffffffffff4 RCX: 00000100d530d000
Apr 11 16:34:04 sizilia kernel: RDX: 00000100f7fef288 RSI: 
00000000ffffffff RDI: 0000000000000038
Apr 11 16:34:04 sizilia kernel: RBP: 00000100d4b93000 R08: 
0000010037ffe810 R09: 0000000000000000
Apr 11 16:34:04 sizilia kernel: R10: 00000100f7fef298 R11: 
00000100f7fef2a8 R12: 00000100f54a8c00
Apr 11 16:34:04 sizilia kernel: R13: 0000000000001000 R14: 
0000000000001000 R15: 0000000000000001
Apr 11 16:34:04 sizilia kernel: FS:  0000002a9588e6e0(0000) 
GS:ffffffff80562e80(0000) knlGS:00000000556d5860
Apr 11 16:34:04 sizilia kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Apr 11 16:34:04 sizilia kernel: CR2: 000000000000003c CR3: 
0000000000101000 CR4: 00000000000006e0
Apr 11 16:34:04 sizilia kernel: Process nfsd (pid: 32304, threadinfo 
00000100e5b12000, task 00000100f2a84d20)
Apr 11 16:34:04 sizilia kernel: Stack: 0000000000001000 0000000000001000 
0000000000000001 0000000000000246
Apr 11 16:34:04 sizilia kernel:        fffffffffffffff4 ffffffff80193097 
00000004ecccad58 00000100f6265c00
Apr 11 16:34:04 sizilia kernel:        00000100d530d900 0000000000000001
Apr 11 16:34:04 sizilia kernel: Call 
Trace:<ffffffff80193097>{bio_map_user+247} 
<ffffffffa034cb61>{:cvfs:linuxif_map_bio+49}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa0387cdd>{:cvfs:cv_buf_strat+525} 
<ffffffffa03b6a77>{:cvfs:cvZoneAlloc+679}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa036f796>{:cvfs:CvDoIo+1190} 
<ffffffffa037036f>{:cvfs:cvStrategy+2575}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03881ac>{:cvfs:AlignedIO+380} <ffffffffa037273c>{:cvfs:rwcvp+5516}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03bc01b>{:cvfs:MdOsAlloc+139} 
<ffffffffa0352251>{:cvfs:cv_uio_allocate_using_uio+161}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03737f1>{:cvfs:read_cvp+273} 
<ffffffffa038f332>{:cvfs:cvfs_read+210}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa04fffd0>{:nfsd:nfsd_acceptable+0} 
<ffffffff8018c74a>{do_readv_writev+490}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa034c730>{:cvfs:cvfs_read_wrapper+0} 
<ffffffffa034d9df>{:cvfs:linuxif_is_procname+31}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa038f407>{:cvfs:cvfs_open+55} 
<ffffffffa05026d2>{:nfsd:nfsd_read+818}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa0509d60>{:nfsd:nfsd3_proc_read+240} 
<ffffffffa04fd130>{:nfsd:nfsd_dispatch+256}
Apr 11 16:34:04 sizilia kernel: 
<ffffffff803522d2>{svc_process+1010} 
<ffffffff80135c50>{default_wake_function+0}
Apr 11 16:34:04 sizilia kernel:        <ffffffffa04fd460>{:nfsd:nfsd+0} 
<ffffffffa04fd6a5>{:nfsd:nfsd+581}
Apr 11 16:34:04 sizilia kernel: 
<ffffffff8013aa56>{schedule_tail+70} <ffffffff801112b7>{child_rip+8}
Apr 11 16:34:04 sizilia kernel:        <ffffffffa04fd460>{:nfsd:nfsd+0} 
<ffffffffa04fd460>{:nfsd:nfsd+0}
Apr 11 16:34:04 sizilia kernel:        <ffffffff801112af>{child_rip+0}
Apr 11 16:34:04 sizilia kernel:
Apr 11 16:34:04 sizilia kernel: Code: f0 fe 4f 04 0f 88 d2 00 00 00 8b 
07 85 c0 78 15 48 8d 4f 08
Apr 11 16:34:04 sizilia kernel: RIP <ffffffff80231b56>{__down_read+6} 
RSP <00000100e5b13688>
Apr 11 16:34:04 sizilia kernel: CR2: 000000000000003c
Apr 11 16:34:04 sizilia kernel:  <1>Unable to handle kernel NULL pointer 
dereference at 000000000000003c RIP:
Apr 11 16:34:04 sizilia kernel: <ffffffff80231b56>{__down_read+6}
Apr 11 16:34:04 sizilia kernel: PML4 ebfb3067 PGD f08b0067 PMD 0
Apr 11 16:34:04 sizilia kernel: Oops: 0002 [2] SMP
Apr 11 16:34:04 sizilia kernel: CPU 0
Apr 11 16:34:04 sizilia kernel: Pid: 32305, comm: nfsd Tainted: P   U 
(2.6.5-7.191-smp SLES9_SP2_BRANCH-200506281458560000)
Apr 11 16:34:04 sizilia kernel: RIP: 0010:[<ffffffff80231b56>] 
<ffffffff80231b56>{__down_read+6}
Apr 11 16:34:04 sizilia kernel: RSP: 0018:00000100e8525688  EFLAGS: 00010006
Apr 11 16:34:04 sizilia kernel: RAX: 00000100eafdb390 RBX: 
fffffffffffffff4 RCX: 0000000000000000
Apr 11 16:34:04 sizilia kernel: RDX: 0000010037ffe800 RSI: 
00000000000000d0 RDI: 0000000000000038
Apr 11 16:34:04 sizilia kernel: RBP: 00000100d4ed1000 R08: 
0000000000000000 R09: 00000100f7ec1910
Apr 11 16:34:04 sizilia kernel: R10: 00000100f7f27880 R11: 
0000000000000002 R12: 00000100f54a8c00
Apr 11 16:34:04 sizilia kernel: R13: 0000000000001000 R14: 
0000000000001000 R15: 0000000000000001
Apr 11 16:34:04 sizilia kernel: FS:  0000002a9588e6e0(0000) 
GS:ffffffff80562e80(0000) knlGS:00000000556d5860
Apr 11 16:34:04 sizilia kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Apr 11 16:34:04 sizilia kernel: CR2: 000000000000003c CR3: 
0000000000101000 CR4: 00000000000006e0
Apr 11 16:34:04 sizilia kernel: Process nfsd (pid: 32305, threadinfo 
00000100e8524000, task 00000100eafdb390)
Apr 11 16:34:04 sizilia kernel: Stack: 0000000000000000 fffffffffffffff4 
00000100d4ed1000 0000000000000246
Apr 11 16:34:04 sizilia kernel:        fffffffffffffff4 ffffffff80193097 
00000004ecccad58 00000100f6265c00
Apr 11 16:34:04 sizilia kernel:        00000100d530d8c0 0000000000000001
Apr 11 16:34:04 sizilia kernel: Call 
Trace:<ffffffff80193097>{bio_map_user+247} 
<ffffffffa034cb61>{:cvfs:linuxif_map_bio+49}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa0387cdd>{:cvfs:cv_buf_strat+525} 
<ffffffffa03b6a77>{:cvfs:cvZoneAlloc+679}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa036f796>{:cvfs:CvDoIo+1190} 
<ffffffffa037036f>{:cvfs:cvStrategy+2575}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03881ac>{:cvfs:AlignedIO+380} <ffffffffa037273c>{:cvfs:rwcvp+5516}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03bc01b>{:cvfs:MdOsAlloc+139} 
<ffffffffa0352251>{:cvfs:cv_uio_allocate_using_uio+161}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03737f1>{:cvfs:read_cvp+273} 
<ffffffffa038f332>{:cvfs:cvfs_read+210}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa04fffd0>{:nfsd:nfsd_acceptable+0} 
<ffffffff8018c74a>{do_readv_writev+490}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa034c730>{:cvfs:cvfs_read_wrapper+0} 
<ffffffffa034d9df>{:cvfs:linuxif_is_procname+31}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa038f407>{:cvfs:cvfs_open+55} 
<ffffffff8018db13>{open_private_file+195}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa0501dbe>{:nfsd:nfsd_open+302} 
<ffffffffa05026d2>{:nfsd:nfsd_read+818}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa0509d60>{:nfsd:nfsd3_proc_read+240} 
<ffffffffa04fd130>{:nfsd:nfsd_dispatch+256}
Apr 11 16:34:04 sizilia kernel: 
<ffffffff803522d2>{svc_process+1010} 
<ffffffff80135c50>{default_wake_function+0}
Apr 11 16:34:04 sizilia kernel:        <ffffffffa04fd460>{:nfsd:nfsd+0} 
<ffffffffa04fd6a5>{:nfsd:nfsd+581}
Apr 11 16:34:04 sizilia kernel:        <ffffffff801112b7>{child_rip+8} 
<ffffffffa04fd460>{:nfsd:nfsd+0}
Apr 11 16:34:04 sizilia kernel:        <ffffffffa04fd460>{:nfsd:nfsd+0} 
<ffffffff801112af>{child_rip+0}
Apr 11 16:34:04 sizilia kernel:
Apr 11 16:34:04 sizilia kernel:
Apr 11 16:34:04 sizilia kernel: Code: f0 fe 4f 04 0f 88 d2 00 00 00 8b 
07 85 c0 78 15 48 8d 4f 08
Apr 11 16:34:04 sizilia kernel: RIP <ffffffff80231b56>{__down_read+6} 
RSP <00000100e8525688>
Apr 11 16:34:04 sizilia kernel: CR2: 000000000000003c
Apr 11 16:34:04 sizilia kernel:  <1>Unable to handle kernel NULL pointer 
dereference at 000000000000003c RIP:
Apr 11 16:34:04 sizilia kernel: klogd 1.4.1, ---------- state change 
----------
Apr 11 16:34:04 sizilia kernel: <ffffffff80231b56>{__down_read+6}
Apr 11 16:34:04 sizilia kernel: PML4 f542a067 PGD f55ef067 PMD 0
Apr 11 16:34:04 sizilia kernel: Oops: 0002 [3] SMP
Apr 11 16:34:04 sizilia kernel: CPU 1
Apr 11 16:34:04 sizilia kernel: Pid: 32306, comm: nfsd Tainted: P   U 
(2.6.5-7.191-smp SLES9_SP2_BRANCH-200506281458560000)
Apr 11 16:34:04 sizilia kernel: RIP: 0010:[<ffffffff80231b56>] 
<ffffffff80231b56>{__down_read+6}
Apr 11 16:34:04 sizilia kernel: RSP: 0018:00000100e56e7688  EFLAGS: 00010006
Apr 11 16:34:04 sizilia kernel: RAX: 00000100eafdaa80 RBX: 
fffffffffffffff4 RCX: 0000000000000000
Apr 11 16:34:04 sizilia kernel: RDX: 00000100f7fc9400 RSI: 
00000000000000d0 RDI: 0000000000000038
Apr 11 16:34:04 sizilia kernel: RBP: 00000100d86bc000 R08: 
0000000000000000 R09: 00000100f7ec1950
Apr 11 16:34:04 sizilia kernel: R10: 00000100f7ea7298 R11: 
00000100f7ea72a8 R12: 00000100f54a8c00
Apr 11 16:34:04 sizilia kernel: R13: 0000000000001000 R14: 
0000000000001000 R15: 0000000000000001
Apr 11 16:34:04 sizilia kernel: FS:  0000002a9588e6e0(0000) 
GS:ffffffff80562f00(0000) knlGS:0000000056d95bb0
Apr 11 16:34:04 sizilia kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Apr 11 16:34:04 sizilia kernel: CR2: 000000000000003c CR3: 
0000000037e06000 CR4: 00000000000006e0
Apr 11 16:34:04 sizilia kernel: Process nfsd (pid: 32306, threadinfo 
00000100e56e6000, task 00000100eafdaa80)
Apr 11 16:34:04 sizilia kernel: Stack: 0000000000000000 fffffffffffffff4 
00000100d86bc000 0000000000000246
Apr 11 16:34:04 sizilia kernel:        fffffffffffffff4 ffffffff80193097 
00000004ecccad58 00000100f6265c00
Apr 11 16:34:04 sizilia kernel:        00000100d530dd00 0000000000000001
Apr 11 16:34:04 sizilia kernel: Call 
Trace:<ffffffff80193097>{bio_map_user+247} 
<ffffffffa034cb61>{:cvfs:linuxif_map_bio+49}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa0387cdd>{:cvfs:cv_buf_strat+525} 
<ffffffffa03b6a77>{:cvfs:cvZoneAlloc+679}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa036f796>{:cvfs:CvDoIo+1190} 
<ffffffffa037036f>{:cvfs:cvStrategy+2575}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03881ac>{:cvfs:AlignedIO+380} <ffffffffa037273c>{:cvfs:rwcvp+5516}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03bc01b>{:cvfs:MdOsAlloc+139} 
<ffffffffa0352251>{:cvfs:cv_uio_allocate_using_uio+161}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa03737f1>{:cvfs:read_cvp+273} 
<ffffffffa038f332>{:cvfs:cvfs_read+210}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa04fffd0>{:nfsd:nfsd_acceptable+0} 
<ffffffff8018c74a>{do_readv_writev+490}
Apr 11 16:34:04 sizilia kernel: 
<ffffffffa034c730>{:cvfs:cvfs_read_wrapper+0} 
<ffffffffa034d9df>{:cvfs:linuxif_is_procname+31}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa038f407>{:cvfs:cvfs_open+55} 
<ffffffff8018db13>{open_private_file+195}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa0501dbe>{:nfsd:nfsd_open+302} 
<ffffffffa05026d2>{:nfsd:nfsd_read+818}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa0509d60>{:nfsd:nfsd3_proc_read+240} 
<ffffffffa04fd130>{:nfsd:nfsd_dispatch+256}
Apr 11 16:34:05 sizilia kernel: 
<ffffffff803522d2>{svc_process+1010} 
<ffffffff80135c50>{default_wake_function+0}
Apr 11 16:34:05 sizilia kernel:        <ffffffffa04fd460>{:nfsd:nfsd+0} 
<ffffffffa04fd6a5>{:nfsd:nfsd+581}
Apr 11 16:34:05 sizilia kernel:        <ffffffff801112b7>{child_rip+8} 
<ffffffffa04fd460>{:nfsd:nfsd+0}
Apr 11 16:34:05 sizilia kernel:        <ffffffffa04fd460>{:nfsd:nfsd+0} 
<ffffffff801112af>{child_rip+0}
Apr 11 16:34:05 sizilia kernel:
Apr 11 16:34:05 sizilia kernel:
Apr 11 16:34:05 sizilia kernel: Code: f0 fe 4f 04 0f 88 d2 00 00 00 8b 
07 85 c0 78 15 48 8d 4f 08
Apr 11 16:34:05 sizilia kernel: RIP <ffffffff80231b56>{__down_read+6} 
RSP <00000100e56e7688>
Apr 11 16:34:05 sizilia kernel: CR2: 000000000000003c
Apr 11 16:34:05 sizilia kernel:  <1>Unable to handle kernel NULL pointer 
dereference at 000000000000003c RIP:
Apr 11 16:34:05 sizilia kernel: <ffffffff80231b56>{__down_read+6}
Apr 11 16:34:05 sizilia kernel: PML4 f16c2067 PGD e320f067 PMD 0
Apr 11 16:34:05 sizilia kernel: Oops: 0002 [4] SMP
Apr 11 16:34:05 sizilia kernel: CPU 0
Apr 11 16:34:05 sizilia kernel: Pid: 32307, comm: nfsd Tainted: P   U 
(2.6.5-7.191-smp SLES9_SP2_BRANCH-200506281458560000)
Apr 11 16:34:05 sizilia kernel: RIP: 0010:[<ffffffff80231b56>] 
<ffffffff80231b56>{__down_read+6}
Apr 11 16:34:05 sizilia kernel: RSP: 0018:00000100e758b688  EFLAGS: 00010006
Apr 11 16:34:05 sizilia kernel: RAX: 00000100e917d5e0 RBX: 
fffffffffffffff4 RCX: 0000000000000000
Apr 11 16:34:05 sizilia kernel: RDX: 0000010037ffe800 RSI: 
00000000000000d0 RDI: 0000000000000038
Apr 11 16:34:05 sizilia kernel: RBP: 00000100d51c0000 R08: 
0000000000000000 R09: 00000100f7ec1c70
Apr 11 16:34:05 sizilia kernel: R10: 00000100f7f27880 R11: 
0000000000000002 R12: 00000100f54a8c00
Apr 11 16:34:05 sizilia kernel: R13: 0000000000001000 R14: 
0000000000001000 R15: 0000000000000001
Apr 11 16:34:05 sizilia kernel: FS:  0000002a9588e6e0(0000) 
GS:ffffffff80562e80(0000) knlGS:00000000556d5860
Apr 11 16:34:05 sizilia kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Apr 11 16:34:05 sizilia kernel: CR2: 000000000000003c CR3: 
0000000000101000 CR4: 00000000000006e0
Apr 11 16:34:05 sizilia kernel: Process nfsd (pid: 32307, threadinfo 
00000100e758a000, task 00000100e917d5e0)
Apr 11 16:34:05 sizilia kernel: Stack: 0000000000000000 fffffffffffffff4 
00000100d51c0000 0000000000000246
Apr 11 16:34:05 sizilia kernel:        fffffffffffffff4 ffffffff80193097 
00000004ecccad58 00000100f6265c00
Apr 11 16:34:05 sizilia kernel:        00000100d530d880 0000000000000001
Apr 11 16:34:05 sizilia kernel: Call 
Trace:<ffffffff80193097>{bio_map_user+247} 
<ffffffffa034cb61>{:cvfs:linuxif_map_bio+49}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa0387cdd>{:cvfs:cv_buf_strat+525} 
<ffffffffa03b6a77>{:cvfs:cvZoneAlloc+679}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa036f796>{:cvfs:CvDoIo+1190} 
<ffffffffa037036f>{:cvfs:cvStrategy+2575}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa03881ac>{:cvfs:AlignedIO+380} <ffffffffa037273c>{:cvfs:rwcvp+5516}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa03bc01b>{:cvfs:MdOsAlloc+139} 
<ffffffffa0352251>{:cvfs:cv_uio_allocate_using_uio+161}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa03737f1>{:cvfs:read_cvp+273} 
<ffffffffa038f332>{:cvfs:cvfs_read+210}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa04fffd0>{:nfsd:nfsd_acceptable+0} 
<ffffffff8018c74a>{do_readv_writev+490}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa034c730>{:cvfs:cvfs_read_wrapper+0} 
<ffffffffa034d9df>{:cvfs:linuxif_is_procname+31}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa038f407>{:cvfs:cvfs_open+55} 
<ffffffff8018db13>{open_private_file+195}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa0501dbe>{:nfsd:nfsd_open+302} 
<ffffffffa05026d2>{:nfsd:nfsd_read+818}
Apr 11 16:34:05 sizilia kernel: 
<ffffffffa0509d60>{:nfsd:nfsd3_proc_read+240} 
<ffffffffa04fd130>{:nfsd:nfsd_dispatch+256}
Apr 11 16:34:05 sizilia kernel: 
<ffffffff803522d2>{svc_process+1010} 
<ffffffff80135c50>{default_wake_function+0}
Apr 11 16:34:05 sizilia kernel:        <ffffffffa04fd460>{:nfsd:nfsd+0} 
<ffffffffa04fd6a5>{:nfsd:nfsd+581}
Apr 11 16:34:05 sizilia kernel:        <ffffffff801112b7>{child_rip+8} 
<ffffffffa04fd460>{:nfsd:nfsd+0}
Apr 11 16:34:05 sizilia kernel:        <ffffffffa04fd460>{:nfsd:nfsd+0} 
<ffffffff801112af>{child_rip+0}
Apr 11 16:34:05 sizilia kernel:
Apr 11 16:34:05 sizilia kernel:
Apr 11 16:34:05 sizilia kernel: Code: f0 fe 4f 04 0f 88 d2 00 00 00 8b 
07 85 c0 78 15 48 8d 4f 08
Apr 11 16:34:05 sizilia kernel: RIP <ffffffff80231b56>{__down_read+6} 
RSP <00000100e758b688>
Apr 11 16:34:05 sizilia kernel: CR2: 000000000000003c

-- 
Mit freundlichem Gruss
     Peer-Joachim Koch
_________________________________________________________
Max-Planck-Institut fuer Biogeochemie
Dr. Peer-Joachim Koch
Hans-Knöll Str.10            Telefon: ++49 3641 57-6705
D-07745 Jena                 Telefax: ++49 3641 57-7705

--------------070604020500060206090907
Content-Type: text/x-vcard; charset=utf-8;
 name="pkoch.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pkoch.vcf"

begin:vcard
fn:Peer-Joachim Koch
n:Koch;Peer-Joachim
org;quoted-printable:MPI f=C3=BCr Biogeochemie;DVA
adr:;;Hans-Knoell-Str. 10;Jena;;07745;Germany
email;internet:pkoch@bgc-jena.mpg.de
title:Dr. 
tel;work:+49 3641 576705
tel;fax:+49 3641 577705
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------070604020500060206090907--

--------------ms040609070004030105090100
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIYIjCC
BWAwggRIoAMCAQICBAZ7GSYwDQYJKoZIhvcNAQEFBQAwWzELMAkGA1UEBhMCREUxEzARBgNV
BAoTCkRGTi1WZXJlaW4xEDAOBgNVBAsTB0RGTi1QS0kxJTAjBgNVBAMTHERGTi1WZXJlaW4g
UENBIENsYXNzaWMgLSBHMDEwHhcNMDUwNDEyMDk1NzQ1WhcNMDkwNDEyMDk1NzQ1WjB3MQsw
CQYDVQQGEwJERTEgMB4GA1UEChMXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxCzAJBgNVBAsT
AkNBMRswGQYDVQQDExJNUEctQ0EgRWJlbmUgMSBHMDExHDAaBgkqhkiG9w0BCQEWDW1wZy1j
YUBtcGcuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAnExqQ1dHhxIiLBie
Q0yudMlYybZLqfGXMbWGouxKS/SqzEkFrGv46k7gCVVbsZqWuZuCVShw3fYDTZEd6Qst1YT2
egeAQ1/gg2UEZGkkQ3Lueabljs4Zk3NQOEkvhkQxY0PTjiksRvc658/jk+wx6UMO+/DnIHkG
5B0rwaE0vYNoDdiFq8G6ROfcJSm8ymsa46h7KbhhbQJcaWVLDGe6ILep1pzkxYbPzUEZRXk+
618nM3wSe4voaPf/4jqSxi/QuQV6B26CO3NU72is6sEOyzTBbMyFiramfMCnos87rUQrb4+1
+chGBuT+euqx/DGBU+mP493+yNiTmFozPpolAgMBAAGjggIOMIICCjAdBgNVHQ4EFgQUEEdF
A//6Fa2drJbYQbaLvYNy+7EwHwYDVR0jBBgwFoAUg647zJPhJFJ66SBPg3CiKt17LwEwDwYD
VR0TAQH/BAUwAwEB/zCBxwYDVR0fBIG/MIG8MFygWqBYhlZodHRwOi8vY2RwMS5wY2EuZGZu
LmRlL2Rmbi1wa2kvY2VydGlmaWNhdGlvbi94NTA5L2NsYXNzaWMvZzEvZGF0YS9jcmxzL3Jv
b3QtY2EtY3JsLmNybDBcoFqgWIZWaHR0cDovL2NkcDIucGNhLmRmbi5kZS9kZm4tcGtpL2Nl
cnRpZmljYXRpb24veDUwOS9jbGFzc2ljL2cxL2RhdGEvY3Jscy9yb290LWNhLWNybC5jcmww
gdwGCCsGAQUFBwEBBIHPMIHMMGQGCCsGAQUFBzAChlhodHRwOi8vY2RwMS5wY2EuZGZuLmRl
L2Rmbi1wa2kvY2VydGlmaWNhdGlvbi94NTA5L2NsYXNzaWMvZzEvZGF0YS9jZXJ0cy9yb290
LWNhLWNlcnQuY3J0MGQGCCsGAQUFBzAChlhodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1w
a2kvY2VydGlmaWNhdGlvbi94NTA5L2NsYXNzaWMvZzEvZGF0YS9jZXJ0cy9yb290LWNhLWNl
cnQuY3J0MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQUFAAOCAQEAS3Wxv5klmkyqWrxJ
scLw2HcD0T8XAVIoabwuWVRrvCr2Yz5CPMTP+YcegdXfbFcgR2Q8Yf5i3FAUpkVQ3sivoDs6
cGYPNPA/D7aOKSFgP0pIW260lE6Xhs+flT9Ay73BgsaOD0eFtek7AVUfoZMLe1SJT/uk3PPa
JCJ0fREqVYXsWkCTE6vWCqHkXH/Mq6D8uW8xg1Lvft7EVbIZ42k5LccJfDKTh7rsxWL5Mo9+
U8pbBN6g3R05yQoYtnEFj5bZWAnLiPDVm+BVLy0kkPw5UuNdhrMXXJFEqEMUagoY7pDjGZ5B
/my1D2Vr8CxTcO8kvWTx5mp7c2elYSpVWmqWUTCCBeIwggTKoAMCAQICCmIhkHsAAAAAALIw
DQYJKoZIhvcNAQEFBQAwcjELMAkGA1UEBhMCREUxIDAeBgNVBAoTF01heC1QbGFuY2stR2Vz
ZWxsc2NoYWZ0MQswCQYDVQQLEwJDQTEoMCYGA1UEAxMfTVBHLUNBIEViZW5lIDIgRzAxLjEg
R2VuZXJpYy1DQTEKMAgGA1UEBRMBMjAeFw0wNTA2MTQxNDI4NTNaFw0wNjA2MTQxNDI4NTNa
MIG2MQswCQYDVQQGEwJERTEgMB4GA1UEChMXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxLjAs
BgNVBAsTJU1heC1QbGFuY2stSW5zdGl0dXQgZnVlciBCaW9nZW9jaGVtaWUxDDAKBgNVBAsT
A0VEVjEhMB8GA1UEAxMYUGVlci1Kb2FjaGltIFRvYmlhcyBLb2NoMSQwIgYJKoZIhvcNAQkB
FhVwa29jaEBiZ2MtamVuYS5tcGcuZGUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMR/
7HDx0cNAhMi1bLfpinO/wAlwFHhf3TU9b7SnxVr4yTrFwY4jVJ+GUV+HdzdVYYvU/ko4FBT1
yJm6LPjZ3yhgraldSbyr58bNSrX0IXsX2fG9d7FT6kXzRL2HIH+9V1yVytv5X5chFBYzhNfk
5wgJZgFycPeuyXjHwgcFr4opAgMBAAGjggK3MIICszAdBgNVHQ4EFgQUa43ouVb2vUpFwWf7
iw1tsHihW0UwHwYDVR0jBBgwFoAUJX+a5vFX3O9TPG2441lqJOyHDpIwgZ0GA1UdHwSBlTCB
kjCBj6CBjKCBiYY+aHR0cDovL2NhLm1wZy5kZS9jcmwvZWJlbmUyL2cwMS4xL21wZy1jYS1l
YmVuZTItZ2VuZXJpYy1jYS5jcmyGR2h0dHA6Ly9wY2EuZ3dkZy5kZS9jcmwvbXBnLWNhL2Vi
ZW5lMi9nMDEuMS9tcGctY2EtZWJlbmUyLWdlbmVyaWMtY2EuY3JsMIG1BggrBgEFBQcBAQSB
qDCBpTBMBggrBgEFBQcwAYZAaHR0cDovL2NhLm1wZy5kZS9jZXJ0cy9lYmVuZTIvZzAxLjEv
bXBnLWNhLWViZW5lMi1nZW5lcmljLWNhLmNydDBVBggrBgEFBQcwAYZJaHR0cDovL3BjYS5n
d2RnLmRlL2NlcnRzL21wZy1jYS9lYmVuZTIvZzAxLjEvbXBnLWNhLWViZW5lMi1nZW5lcmlj
LWNhLmNydDAMBgNVHRMBAf8EAjAAMAsGA1UdDwQEAwIFoDA8BgkrBgEEAYI3FQcELzAtBiUr
BgEEAYI3FQjspRKBm6kVg7mbIYaC7CWCqL1gH4GE022GnNs7AgFkAgEDMDUGA1UdJQQuMCwG
CisGAQQBgjcUAgIGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoDBDBDBgkrBgEEAYI3
FQoENjA0MAwGCisGAQQBgjcUAgIwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQwDAYKKwYBBAGC
NwoDBDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAIAw
BwYFKw4DAgcwCgYIKoZIhvcNAwcwDQYJKoZIhvcNAQEFBQADggEBAGJWFAOvuQAubxtqBBcS
wYWsVWhzqlD5Ryeztd0zlWP1+bGNo9SZM49KrZyI5LOk0jYo6XtOLSpAieZ77LC6/MmMVl3V
o4EJBkDCzWo7z25Dawj6E1zSaZjlXXEvkWs4ykoV4M+2b174Rd/ZLx/6kLftsu8HwP+0Xj4/
rvbioesuUm3f/PS1xcnsJMhX6owGKcjCJ8Rxi0U/BxGeYHVpyrDzBjfVmPCO5RrpliNcFir3
Sp1sEGVAaV3mTRfMLWQJAd/7VZVYewjUpReXzxCrmw5wAQU/ZUosVfcPsKYv1fa184ZaqSAr
ixHa0Vt7xbSa1AB6Q4S7+8eym7cdpcDRCmYwggXiMIIEyqADAgECAgpiIZB7AAAAAACyMA0G
CSqGSIb3DQEBBQUAMHIxCzAJBgNVBAYTAkRFMSAwHgYDVQQKExdNYXgtUGxhbmNrLUdlc2Vs
bHNjaGFmdDELMAkGA1UECxMCQ0ExKDAmBgNVBAMTH01QRy1DQSBFYmVuZSAyIEcwMS4xIEdl
bmVyaWMtQ0ExCjAIBgNVBAUTATIwHhcNMDUwNjE0MTQyODUzWhcNMDYwNjE0MTQyODUzWjCB
tjELMAkGA1UEBhMCREUxIDAeBgNVBAoTF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MS4wLAYD
VQQLEyVNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgQmlvZ2VvY2hlbWllMQwwCgYDVQQLEwNF
RFYxITAfBgNVBAMTGFBlZXItSm9hY2hpbSBUb2JpYXMgS29jaDEkMCIGCSqGSIb3DQEJARYV
cGtvY2hAYmdjLWplbmEubXBnLmRlMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEf+xw
8dHDQITItWy36Ypzv8AJcBR4X901PW+0p8Va+Mk6xcGOI1SfhlFfh3c3VWGL1P5KOBQU9ciZ
uiz42d8oYK2pXUm8q+fGzUq19CF7F9nxvXexU+pF80S9hyB/vVdclcrb+V+XIRQWM4TX5OcI
CWYBcnD3rsl4x8IHBa+KKQIDAQABo4ICtzCCArMwHQYDVR0OBBYEFGuN6LlW9r1KRcFn+4sN
bbB4oVtFMB8GA1UdIwQYMBaAFCV/mubxV9zvUzxtuONZaiTshw6SMIGdBgNVHR8EgZUwgZIw
gY+ggYyggYmGPmh0dHA6Ly9jYS5tcGcuZGUvY3JsL2ViZW5lMi9nMDEuMS9tcGctY2EtZWJl
bmUyLWdlbmVyaWMtY2EuY3JshkdodHRwOi8vcGNhLmd3ZGcuZGUvY3JsL21wZy1jYS9lYmVu
ZTIvZzAxLjEvbXBnLWNhLWViZW5lMi1nZW5lcmljLWNhLmNybDCBtQYIKwYBBQUHAQEEgagw
gaUwTAYIKwYBBQUHMAGGQGh0dHA6Ly9jYS5tcGcuZGUvY2VydHMvZWJlbmUyL2cwMS4xL21w
Zy1jYS1lYmVuZTItZ2VuZXJpYy1jYS5jcnQwVQYIKwYBBQUHMAGGSWh0dHA6Ly9wY2EuZ3dk
Zy5kZS9jZXJ0cy9tcGctY2EvZWJlbmUyL2cwMS4xL21wZy1jYS1lYmVuZTItZ2VuZXJpYy1j
YS5jcnQwDAYDVR0TAQH/BAIwADALBgNVHQ8EBAMCBaAwPAYJKwYBBAGCNxUHBC8wLQYlKwYB
BAGCNxUI7KUSgZupFYO5myGGguwlgqi9YB+BhNNthpzbOwIBZAIBAzA1BgNVHSUELjAsBgor
BgEEAYI3FAICBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQwQwYJKwYBBAGCNxUK
BDYwNDAMBgorBgEEAYI3FAICMAoGCCsGAQUFBwMCMAoGCCsGAQUFBwMEMAwGCisGAQQBgjcK
AwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgCAMAcG
BSsOAwIHMAoGCCqGSIb3DQMHMA0GCSqGSIb3DQEBBQUAA4IBAQBiVhQDr7kALm8bagQXEsGF
rFVoc6pQ+Ucns7XdM5Vj9fmxjaPUmTOPSq2ciOSzpNI2KOl7Ti0qQInme+ywuvzJjFZd1aOB
CQZAws1qO89uQ2sI+hNc0mmY5V1xL5FrOMpKFeDPtm9e+EXf2S8f+pC37bLvB8D/tF4+P672
4qHrLlJt3/z0tcXJ7CTIV+qMBinIwifEcYtFPwcRnmB1acqw8wY31ZjwjuUa6ZYjXBYq90qd
bBBlQGld5k0XzC1kCQHf+1WVWHsI1KUXl88Qq5sOcAEFP2VKLFX3D7CmL9X2tfOGWqkgK4sR
2tFbe8W0mtQAekOEu/vHspu3HaXA0QpmMIIG7jCCBdagAwIBAgIBAjANBgkqhkiG9w0BAQUF
ADB3MQswCQYDVQQGEwJERTEgMB4GA1UEChMXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxCzAJ
BgNVBAsTAkNBMRswGQYDVQQDExJNUEctQ0EgRWJlbmUgMSBHMDExHDAaBgkqhkiG9w0BCQEW
DW1wZy1jYUBtcGcuZGUwHhcNMDUwNDE5MTQyODI1WhcNMDcwNDE5MTQyODI1WjByMQswCQYD
VQQGEwJERTEgMB4GA1UEChMXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxCzAJBgNVBAsTAkNB
MSgwJgYDVQQDEx9NUEctQ0EgRWJlbmUgMiBHMDEuMSBHZW5lcmljLUNBMQowCAYDVQQFEwEy
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuvp3Dvb016R0lYMOZWwAKzUaHNuT
sbb3BWMug2JFmiq1eJHlrtd5zEUThjRUnPHMEDt/GT38fvyXbHWyUMTbbdB0pL8VxsyFLQNY
wXwEHoHdrnAjzDoatJ8zhGObRMgVvaw158efkwCcz3JE/KY5GOEp+J0NOdGjTwkRw16Gylfq
54g23xY6tIbdbc3QTlTsZA1Y48B9tR2M/fha27nVnaAA8RQNmcAW0EIp7icnQzKqRxMVQsTa
ohwqHq2FYLah9c9fZCjjRlPL+oCu++WnIQtHVl1j27wAPV87+spB7OUqssZxGvsXstCCW3qe
o1BxAYDVsrSnDa09P8IB54rnmwIDAQABo4IDiDCCA4QwDwYDVR0TAQH/BAUwAwEB/zALBgNV
HQ8EBAMCAQYwTAYJYIZIAYb4QgENBD8WPVN1Ym9yZGluYXRlIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5IC0gTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQwHQYDVR0OBBYEFCV/mubxV9zvUzxt
uONZaiTshw6SMIGGBgNVHSMEfzB9gBQQR0UD//oVrZ2slthBtou9g3L7saFfpF0wWzELMAkG
A1UEBhMCREUxEzARBgNVBAoTCkRGTi1WZXJlaW4xEDAOBgNVBAsTB0RGTi1QS0kxJTAjBgNV
BAMTHERGTi1WZXJlaW4gUENBIENsYXNzaWMgLSBHMDGCBAZ7GSYwGAYDVR0RBBEwD4ENbXBn
LWNhQG1wZy5kZTAJBgNVHRIEAjAAMEAGCWCGSAGG+EIBBAQzFjFodHRwOi8vY2EubXBnLmRl
L2NybC9lYmVuZTEvZzAxL21wZy1jYS1lYmVuZTEuY3JsMEAGCWCGSAGG+EIBAwQzFjFodHRw
Oi8vY2EubXBnLmRlL2NybC9lYmVuZTEvZzAxL21wZy1jYS1lYmVuZTEuY3JsMIGEBgNVHR8E
fTB7MDegNaAzhjFodHRwOi8vY2EubXBnLmRlL2NybC9lYmVuZTEvZzAxL21wZy1jYS1lYmVu
ZTEuY3JsMECgPqA8hjpodHRwOi8vcGNhLmd3ZGcuZGUvY3JsL21wZy1jYS9lYmVuZTEvZzAx
L21wZy1jYS1lYmVuZTEuY3JsMIGbBggrBgEFBQcBAQSBjjCBizA/BggrBgEFBQcwAoYzaHR0
cDovL2NhLm1wZy5kZS9jZXJ0cy9lYmVuZTEvZzAxL21wZy1jYS1lYmVuZTEuY3J0MEgGCCsG
AQUFBzAChjxodHRwOi8vcGNhLmd3ZGcuZGUvY2VydHMvbXBnLWNhL2ViZW5lMS9nMDEvbXBn
LWNhLWViZW5lMS5jcnQwHwYJYIZIAYb4QgECBBIWEGh0dHA6Ly9jYS5tcGcuZGUwMQYJYIZI
AYb4QgEIBCQWImh0dHA6Ly9jYS5tcGcuZGUvcG9saWN5L2luZGV4Lmh0bWwwTAYDVR0gBEUw
QzBBBg0rBgEEAYGdSDIBAwEBMDAwLgYIKwYBBQUHAgEWImh0dHA6Ly9jYS5tcGcuZGUvcG9s
aWN5L2luZGV4Lmh0bWwwDQYJKoZIhvcNAQEFBQADggEBAF9c4RguQ5az0Ey1FtiZIllC2uNS
vyWIvCSQqkoCDSk75sb2QvwI8ZbtQpzXJkjSRYJdzoKHv3cO3XCYUM6Vw1XisOhzYsltUlk8
VCVRSxhdFm9f/Yg/OOksEtyNH0YnK9NKspuqppd6+/jaC93vY6cWwdcHkTAZkGlhm407zNN7
7CTBSmN71U3R1MH4TLVwRq569c7foPhdsFfqd2D3/svSaIHyGfLcHwNFiozf8RJlp4RMEV4u
56Xk35kC0lzL/DVvrIEtpxopHm0z5VMUWf9jgzWpK2X8gEMk/dP7OZJiS3UROW2ALMZez6+l
DIMebDVL7WpCLycpPAAt8WdAE5MxggMGMIIDAgIBATCBgDByMQswCQYDVQQGEwJERTEgMB4G
A1UEChMXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxCzAJBgNVBAsTAkNBMSgwJgYDVQQDEx9N
UEctQ0EgRWJlbmUgMiBHMDEuMSBHZW5lcmljLUNBMQowCAYDVQQFEwEyAgpiIZB7AAAAAACy
MAkGBSsOAwIaBQCgggHbMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTA2MDQxMjEzNDkzNVowIwYJKoZIhvcNAQkEMRYEFFzknnxeLHMsQdpb9Wkk7euLQoGD
MFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3
DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAwcjEL
MAkGA1UEBhMCREUxIDAeBgNVBAoTF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQswCQYDVQQL
EwJDQTEoMCYGA1UEAxMfTVBHLUNBIEViZW5lIDIgRzAxLjEgR2VuZXJpYy1DQTEKMAgGA1UE
BRMBMgIKYiGQewAAAAAAsjCBkwYLKoZIhvcNAQkQAgsxgYOggYAwcjELMAkGA1UEBhMCREUx
IDAeBgNVBAoTF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MQswCQYDVQQLEwJDQTEoMCYGA1UE
AxMfTVBHLUNBIEViZW5lIDIgRzAxLjEgR2VuZXJpYy1DQTEKMAgGA1UEBRMBMgIKYiGQewAA
AAAAsjANBgkqhkiG9w0BAQEFAASBgMF+2acka6+NVJlUkM1hXuKz0lPPRPsrVizyo3I9vJri
vzstr49oEm/rHTvakS+cq1iIdzaLKmulcbyU1DMxVdZV2+QWoRrNyVmSoH+eN1FNflHxNUYR
ooprLqs5Uo3UNWm0Mk4HMjEKF47s4efGF1+/+F7MLrk0rflU4No88vV0AAAAAAAA
--------------ms040609070004030105090100--


