Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290652AbSARKLh>; Fri, 18 Jan 2002 05:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290653AbSARKLb>; Fri, 18 Jan 2002 05:11:31 -0500
Received: from th09.opsion.fr ([195.219.20.19]:6664 "HELO th09.opsion.fr")
	by vger.kernel.org with SMTP id <S290652AbSARKLW>;
	Fri, 18 Jan 2002 05:11:22 -0500
Message-ID: <009201c1a008$fe24ed60$6414dbc3@opsion.fr>
From: "marko milovanovic" <m.milo@ifrance.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.4.7 on a 7.2 redhat
Date: Fri, 18 Jan 2002 11:15:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everyone,
we're running a 2.4.7-10smp kernel on a hp lh3000 server with 1gb ram scsi
disks and 2 pentium iii cpus

we have one a day a kernel panic  with this message :
*********************************************
Unable to handle kernel NULL pointer dereference at virtual address 0000000d
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01f35ad>]
EFLAGS: 00010296
eax: e6d9842c   ebx: daabf760   ecx: d763daa0   edx: 00000001
esi: 00000050   edi: 00000001   ebp: d763daa0   esp: ee8b7eb4
ds: 0018   es: 0018   ss: 0018
Process web2 (pid: 31430, stackpage=ee8b7000)
Stack: 00000000 f7d00280 d763daa0 ee8b6000 00000000 00000050 c01ffe1d
d763daa0
       00000050 ffffffea f1a923c4 ee8b7f00 00000010 bffffc18 c01c617f
f1a923c4
       ee8b7f00 00000010 00000000 50000002 00000000 00000000 00000000
00000000
Call Trace: [<c01ffe1d>] [<c01c617f>] [<c01ff470>] [<c01ffc2a>] [<c01c5f63>]
   [<c01c66f5>] [<c01c6715>] [<c01c6c6c>] [<c010716b>]

Code: 8b 42 0c 8b 4c 24 1c 39 41 0c 75 e7 85 ff 74 0e 80 7a 26 00
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
************************************************

we ran it thu ksymoops and here is the result :

root@th00:/usr/local/src: ksymoops -m /boot/System.map < kern
ksymoops 2.4.1 on i686 2.4.7-10smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7-10smp/ (default)
     -m /boot/System.map (specified)

Error (expand_objects): cannot stat(/lib/megaraid.o) for megaraid
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
c01bf9b0, System.map sa
ys c015fa20.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says
f88d9d14, /lib/modules/
2.4.7-10smp/kernel/fs/lockd/lockd.o says f88d9180.  Ignoring
/lib/modules/2.4.7-10smp/kernel/fs/lock
d/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says
f88d9d10, /lib/modules/2.4.7-10s
mp/kernel/fs/lockd/lockd.o says f88d917c.  Ignoring
/lib/modules/2.4.7-10smp/kernel/fs/lockd/lockd.o
 entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says
f88d9d18, /lib/modules/2.4.7
-10smp/kernel/fs/lockd/lockd.o says f88d9184.  Ignoring
/lib/modules/2.4.7-10smp/kernel/fs/lockd/loc
kd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says
f890e160, /lib/modules/2.4.7-10s
mp/kernel/net/sunrpc/sunrpc.o says f890de20.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunrpc/su
nrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says
f890e164, /lib/modules/2.4.7-10
smp/kernel/net/sunrpc/sunrpc.o says f890de24.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunrpc/s
unrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says
f890e168, /lib/modules/2.4.7-10s
mp/kernel/net/sunrpc/sunrpc.o says f890de28.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunrpc/su
nrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says
f890e15c, /lib/modules/2.4.7-10s
mp/kernel/net/sunrpc/sunrpc.o says f890de1c.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunrpc/su
nrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says
f890e13c, /lib/modules/2.
4.7-10smp/kernel/net/sunrpc/sunrpc.o says f890ddfc.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/su
nrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says
f890e12c, /lib/modules/2.4.7-1
0smp/kernel/net/sunrpc/sunrpc.o says f890ddec.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunrpc/
sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says
f890e140, /lib/modules/2.4.
7-10smp/kernel/net/sunrpc/sunrpc.o says f890de00.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunr
pc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says f890e124,
/lib/modules/2.4.7-10smp
/kernel/net/sunrpc/sunrpc.o says f890dde4.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunrpc/sunr
pc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says f890e128,
/lib/modules/2.4.7-10smp
/kernel/net/sunrpc/sunrpc.o says f890dde8.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunrpc/sunr
pc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says f890e120,
/lib/modules/2.4.7-10sm
p/kernel/net/sunrpc/sunrpc.o says f890dde0.  Ignoring
/lib/modules/2.4.7-10smp/kernel/net/sunrpc/sun
rpc.o entry
Warning (compare_maps): mismatch on symbol mega_hbas  , megaraid says
f88438c0, /lib/modules/2.4.7-1
0smp/kernel/drivers/scsi/megaraid.o says f8843600.  Ignoring
/lib/modules/2.4.7-10smp/kernel/drivers
/scsi/megaraid.o entry
Warning (compare_maps): mismatch on symbol sd  , sd_mod says f881cce4,
/lib/modules/2.4.7-10smp/kern
el/drivers/scsi/sd_mod.o says f881cba0.  Ignoring
/lib/modules/2.4.7-10smp/kernel/drivers/scsi/sd_mo
d.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says
f8818088, /lib/modules/2.4.7-1
0smp/kernel/drivers/scsi/scsi_mod.o says f8816910.  Ignoring
/lib/modules/2.4.7-10smp/kernel/drivers
/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says
f88180b4, /lib/modules/2
.4.7-10smp/kernel/drivers/scsi/scsi_mod.o says f881693c.  Ignoring
/lib/modules/2.4.7-10smp/kernel/d
rivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says
f88180b0, /lib/modules/2.4
.7-10smp/kernel/drivers/scsi/scsi_mod.o says f8816938.  Ignoring
/lib/modules/2.4.7-10smp/kernel/dri
vers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says
f88180b8, /lib/modules/2.4.7-
10smp/kernel/drivers/scsi/scsi_mod.o says f8816940.  Ignoring
/lib/modules/2.4.7-10smp/kernel/driver
s/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod
says f8818084, /lib/module
s/2.4.7-10smp/kernel/drivers/scsi/scsi_mod.o says f881690c.  Ignoring
/lib/modules/2.4.7-10smp/kerne
l/drivers/scsi/scsi_mod.o entry
Unable to handle kernel NULL pointer dereference at virtual address 0000000d
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01f35ad>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: e6d9842c   ebx: daabf760   ecx: d763daa0   edx: 00000001
esi: 00000050   edi: 00000001   ebp: d763daa0   esp: ee8b7eb4
ds: 0018   es: 0018   ss: 0018
Process web2 (pid: 31430, stackpage=ee8b7000)
Stack: 00000000 f7d00280 d763daa0 ee8b6000 00000000 00000050 c01ffe1d
d763daa0
       00000050 ffffffea f1a923c4 ee8b7f00 00000010 bffffc18 c01c617f
f1a923c4
                       ee8b7f00 00000010 00000000 50000002 00000000 00000000
00000000 00000000
                            Call Trace: [<c01ffe1d>] [<c01c617f>]
[<c01ff470>] [<c01ffc2a>] [<c01c5f
63>]
                               [<c01c66f5>] [<c01c6715>] [<c01c6c6c>]
[<c010716b>]
                                 Code: 8b 42 0c 8b 4c 24 1c 39 41 0c 75 e7
85 ff 74 0e 80 7a 26 00

>>EIP; c01f35ad <tcp_v4_get_port+14d/290>   <=====
Trace; c01ffe1d <inet_bind+17d/290>
Trace; c01c617f <sys_bind+4f/70>
Trace; c01ff470 <inet_sock_destruct+0/180>
Trace; c01ffc2a <inet_create+23a/260>
Trace; c01c5f63 <sock_create+f3/120>
Trace; c01c66f5 <sys_setsockopt+45/70>
Trace; c01c6715 <sys_setsockopt+65/70>
Trace; c01c6c6c <sys_socketcall+7c/200>
Trace; c010716b <system_call+33/38>
Code;  c01f35ad <tcp_v4_get_port+14d/290>
00000000 <_EIP>:
Code;  c01f35ad <tcp_v4_get_port+14d/290>   <=====
   0:   8b 42 0c                  mov    0xc(%edx),%eax   <=====
Code;  c01f35b0 <tcp_v4_get_port+150/290>
   3:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c01f35b4 <tcp_v4_get_port+154/290>
   7:   39 41 0c                  cmp    %eax,0xc(%ecx)
Code;  c01f35b7 <tcp_v4_get_port+157/290>
   a:   75 e7                     jne    fffffff3 <_EIP+0xfffffff3> c01f35a0
<tcp_v4_get_port+140/29
0>
Code;  c01f35b9 <tcp_v4_get_port+159/290>
   c:   85 ff                     test   %edi,%edi
Code;  c01f35bb <tcp_v4_get_port+15b/290>
   e:   74 0e                     je     1e <_EIP+0x1e> c01f35cb
<tcp_v4_get_port+16b/290>
Code;  c01f35bd <tcp_v4_get_port+15d/290>
  10:   80 7a 26 00               cmpb   $0x0,0x26(%edx)

                                  <0>Kernel panic: Aiee, killing interrupt
handler!

21 warnings and 4 errors issued.  Results may not be reliable.
root@th00:/usr/local/src:

do you have any idea what is going on?
the servers is mainly used as sendmail and pop and wen servers.
we handle up to 1 million mail per day and accept roughly 1000 connections
per seconds on the web.

thanks very much for your help and your good work on the kernel!
_________________________________
marko milovanovic

 
______________________________________________________________________________
ifrance.com, l'email gratuit le plus complet de l'Internet !
vos emails depuis un navigateur, en POP3, sur Minitel, sur le WAP...
http://www.ifrance.com/_reloc/email.emailif


