Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbTCMDbe>; Wed, 12 Mar 2003 22:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbTCMDbe>; Wed, 12 Mar 2003 22:31:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:43754 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262145AbTCMDbc>; Wed, 12 Mar 2003 22:31:32 -0500
Date: Wed, 12 Mar 2003 19:42:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Shane Shrybman <shrybman@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.5.64
Message-ID: <82830000.1047526931@[10.10.2.4]>
In-Reply-To: <1047526326.2261.9.camel@mars.goatskin.org>
References: <1047526326.2261.9.camel@mars.goatskin.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========929770887=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========929770887==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Looks like the attatched patch might help.

M.

--On Wednesday, March 12, 2003 22:32:06 -0500 Shane Shrybman <shrybman@sympatico.ca> wrote:

> Hi,
> 
> Got this oops during boot up. Machine is still alive.
> 
> Athlon TB, IDE
> 
> hde: drive_cmd: error=0x04 { DriveStatusError }
> hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> hde: drive_cmd: error=0x04 { DriveStatusError }
> SCSI subsystem initialized
> parport_pc: Via 686A parallel port disabled in BIOS
> lp: driver loaded but no devices found
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000006c
>  printing eip:
> d88f440e
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0060:[<d88f440e>]    Not tainted
> EFLAGS: 00010206
> EIP is at rpc_depopulate+0x1e/0x120 [sunrpc]
> eax: 00000000   ebx: d5e6ba80   ecx: 0000006c   edx: d5e6baf4
> esi: d5e6ba80   edi: d5731dc0   ebp: 00000000   esp: d59bdcd4
> ds: 007b   es: 007b   ss: 0068
> Process rpc.nfsd (pid: 1290, threadinfo=d59bc000 task=d5ea26c0)
> Stack: 00000000 00000000 d5e6ba80 d5e6ba80 d5731dc0 00000000 d88f4942
> d5e6ba80 
>        d5d0a800 d7ffaac0 d59bdcf8 00000282 d56ccd40 00000010 00000001
> d88eba5d 
>        d6054d40 d59bddb4 d5c11740 d88e6302 d6054dd4 d6054d40 d88e6378
> d6054d40 
> Call Trace:
>  [<d88f4942>] rpc_rmdir+0x52/0x90 [sunrpc]
>  [<d88eba5d>] rpcauth_destroy+0xd/0x60 [sunrpc]
>  [<d88e6302>] rpc_destroy_client+0x42/0x70 [sunrpc]
>  [<d88e6378>] rpc_release_client+0x48/0x50 [sunrpc]
>  [<d88eac04>] rpc_release_task+0x1b4/0x1e0 [sunrpc]
>  [<d88ea5b5>] __rpc_execute+0x355/0x360 [sunrpc]
>  [<c0119380>] default_wake_function+0x0/0x20
>  [<d88e65ee>] rpc_call_setup+0x3e/0x60 [sunrpc]
>  [<d88e64d8>] rpc_call_sync+0x68/0xa0 [sunrpc]
>  [<d88e64e9>] rpc_call_sync+0x79/0xa0 [sunrpc]
>  [<d88fffb8>] all_tasks+0x0/0x8 [sunrpc]
>  [<d88fffb8>] all_tasks+0x0/0x8 [sunrpc]
>  [<d89001f4>] pmap_procedures+0x30/0x60 [sunrpc]
>  [<d88e9700>] gcc2_compiled.+0x0/0xa0 [sunrpc]
>  [<d88f6116>] +0xc52/0x105c [sunrpc]
>  [<d890023c>] pmap_program+0x0/0x24 [sunrpc]
>  [<d88f1558>] rpc_register+0xf8/0x130 [sunrpc]
>  [<c0133807>] __alloc_pages+0x87/0x2b0
>  [<d89001f4>] pmap_procedures+0x30/0x60 [sunrpc]
>  [<d89001f4>] pmap_procedures+0x30/0x60 [sunrpc]
>  [<c0130000>] filemap_fdatawait+0xc0/0x160
>  [<d89273e0>] nfsd_program+0x0/0x20 [nfsd]
>  [<d88eccc5>] svc_register+0x85/0xe0 [sunrpc]
>  [<d89273e0>] nfsd_program+0x0/0x20 [nfsd]
>  [<d8927fd8>] nfsd_version3+0x0/0x28 [nfsd]
>  [<d88ec92e>] gcc2_compiled.+0xce/0xe0 [sunrpc]
>  [<d89130a9>] nfsd_svc+0x89/0x1a0 [nfsd]
>  [<d89273e0>] nfsd_program+0x0/0x20 [nfsd]
>  [<d89137ef>] gcc2_compiled.+0x10f/0x130 [nfsd]
>  [<c0152c6f>] path_release+0xf/0x30
>  [<c016870f>] sys_nfsservctl+0xaf/0xf0
>  [<c013da04>] sys_munmap+0x34/0x50
>  [<c010a767>] syscall_call+0x7/0xb
> 
> Code: ff 48 6c 0f 88 60 09 00 00 b8 00 e0 ff ff 21 e0 ff 40 10 8b 
> 
> Regards,
> 
> Shane
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


--==========929770887==========
Content-Type: text/plain; charset=us-ascii; name=271-nfs_fix
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=271-nfs_fix; size=531

diff -urpN -X /home/fletch/.diff.exclude 270-cleaner_inodes/net/sunrpc/clnt.c 271-nfs_fix/net/sunrpc/clnt.c
--- 270-cleaner_inodes/net/sunrpc/clnt.c	Fri Feb 21 23:40:49 2003
+++ 271-nfs_fix/net/sunrpc/clnt.c	Wed Mar  5 11:22:28 2003
@@ -208,7 +208,8 @@ rpc_destroy_client(struct rpc_clnt *clnt
 		rpcauth_destroy(clnt->cl_auth);
 		clnt->cl_auth = NULL;
 	}
-	rpc_rmdir(clnt->cl_pathname);
+	if (clnt->cl_pathname[0])
+		rpc_rmdir(clnt->cl_pathname);
 	if (clnt->cl_xprt) {
 		xprt_destroy(clnt->cl_xprt);
 		clnt->cl_xprt = NULL;

--==========929770887==========--

