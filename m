Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965767AbWKUHXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965767AbWKUHXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 02:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966910AbWKUHXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 02:23:13 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:55974 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S965767AbWKUHXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 02:23:12 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Tue, 21 Nov 2006 08:22:47 +0100
MIME-Version: 1.0
Subject: (Fwd) Re: [NFS] 2.6.16 with XEN (x86_64): nfsserver crashed kernel
Message-ID: <4562B75A.4193.14B08E07@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.10.0+V=4.10+U=2.07.149+R=02 October 2006+T=193646@20061121.071116Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As advised, I'm forwarding this kernel oops from SuSE/Novell SLES10 x86_64 to this 
list. The Oops happened during shutdown of Domain 0 of XEN. Problem occurred only 
once so far.

Regards,
Ulrich
P.S: It would be good if an open source product like SLES would allow users to 
report bugs like that directly into Novell's bugzilla. Currently Novell must 
magically know what the problems in their products are, and the user has to hope 
that a fix will come up automagically as well...

------- Forwarded message follows -------
On Mon, 2006-11-20 at 12:17 +0100, Ulrich Windl wrote:
> Hi,
> 
> while investigating the problem of being unable to get NFS locks with SLES10 on 
> AMD Opteron in XEN (kernel-xen-2.6.16.21-0.25), it seems NFS server crashed the 
> kernel during shutdown. I have a log from serial console:
> 
> Boot logging started on /dev/ttyS0(/dev/console) at Mon Nov 20 11:23:17 2006
> Master Resource Control: previous runlevel: 3, switching to runlevel: 
> [80C[10D[1m6[m
> 
> Shutting down the Firewall [80C[10D[1;33mskipped[m
> Unable to handle kernel paging request at 0000000100000027 RIP: 
> <ffffffff8012746c>{dup_fd+412}
> PGD 13b1e067 PUD 0 
> Oops: 0002 [1] SMP 
> last sysfs file: /devices/pci0000:00/0000:00:01.0/0000:01:01.1/subsystem_device
> CPU 2 
> Modules linked in: nfs nfsd exportfs lockd nfs_acl sunrpc hfs vfat fat joydev st 
> nls_utf8 xt_pkttype ipt_LOG xt_limit ipt_TCPMSS xt_physdev bridge blkbk netbk 
> netloop af_packet bonding button battery ac ip6t_REJECT xt_tcpudp ipt_REJECT 
> xt_state iptable_mangle iptable_nat ip_nat sr_mod iptable_filter ip6table_mangle 
> ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables ipv6 loop 
> usb_storage usbhid hw_random ohci_hcd i2c_amd756 usbcore shpchp i2c_amd8111 
> i2c_core pci_hotplug ide_cd cdrom e1000 reiserfs dm_snapshot dm_mod fan thermal 
> processor sg mptsas mptscsih mptbase scsi_transport_sas amd74xx sd_mod scsi_mod 
> ide_disk ide_core
> Pid: 27024, comm: nfsserver Not tainted 2.6.16.21-0.25-xen #1
> RIP: e030:[<ffffffff8012746c>] <ffffffff8012746c>{dup_fd+412}
> RSP: e02b:ffff88000e013d98  EFLAGS: 00010206
> RAX: dfffffffffffffff RBX: ffff8800155bd800 RCX: 000000000000003d
> RDX: 0000000000000000 RSI: ffff88000f1b9000 RDI: 00000000ffffffff
> RBP: ffff880000666b80 R08: 000000000000003e R09: ffff8800186362c0
> R10: ffff880014aa49f0 R11: 000000000000003e R12: 0000000000000100
> R13: ffff8800089c5b80 R14: ffff8800089c5ed8 R15: ffff88000e013e04
> FS:  00002b37d9ce9ae0(0000) GS:ffffffff80421100(0000) knlGS:0000000000000000
> CS:  e033 DS: 0000 ES: 0000
> Process nfsserver (pid: 27024, threadinfo ffff88000e012000, task 
> ffff8800075b2080)
> Stack: 0000000045618214 ffff8800005b3350 ffff8800005b3350 ffff8800005b3100 
>        00000001075b2080 ffff8800005b3100 0000000000000000 ffff8800005b3100 
>        ffff8800075b2080 0000000000000000 
> Call Trace: <ffffffff8012759d>{copy_files+79} 
> <ffffffff801281d3>{copy_process+1235}
>        <ffffffff801297d4>{do_fork+197} <ffffffff8010aa6a>{system_call+134}
>        <ffffffff80179bff>{sys_newstat+40} <ffffffff80134b82>{sigprocmask+180}
>        <ffffffff8010aa6a>{system_call+134} 
> <ffffffff8010ae25>{ptregscall_common+61}
> 
> Code: f0 ff 47 28 eb 1f 49 8b 71 20 4c 89 c2 44 88 c1 48 c1 ea 06 
> RIP <ffffffff8012746c>{dup_fd+412} RSP <ffff88000e013d98>
> CR2: 0000000100000027

It looks as if you might be running the userland NFS server. That won't
support NFS locking. If your applications require locking, then you need
to use the kernel NFS server, knfsd.

As for the Oops, that is a different matter: it should never be possible
for a user process to crash the kernel. However I cannot see that the
above relates to NFS in any way, so you are probably better off
reporting this to the main kernel mailing list at
linux-kernel@vger.kernel.org.

Cheers,
  Trond

------- End of forwarded message -------
