Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUFXXp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUFXXp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUFXXp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:45:29 -0400
Received: from smtp08.auna.com ([62.81.186.18]:40868 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S264850AbUFXXo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:44:57 -0400
Date: Fri, 25 Jun 2004 01:44:55 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: gcc-3.4.1 and -Winline
Message-ID: <20040624234455.GA4058@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all...

This are the warnings I get with gcc-3.4.1 CVS, when building 2.6.7-mm2.
Just for if some is really serious, ie, something that does not work if
compiled out-of-line (but I suppose I had noticed ;) ).
Or if it origins a huge performace penalty.

TIA


  CC      arch/i386/kernel/timers/timer_tsc.o
arch/i386/kernel/timers/timer_tsc.c: In function `mark_offset_tsc':
arch/i386/kernel/timers/timer_tsc.c:30: warning: inlining failed in call to=
 'cpufreq_delayed_get': function body not available
arch/i386/kernel/timers/timer_tsc.c:248: warning: called from here

  CC      arch/i386/kernel/smp.o
arch/i386/kernel/smp.c: In function `flush_tlb_others':
arch/i386/kernel/smp.c:161: warning: inlining failed in call to 'send_IPI_m=
ask_bitmask': function not considered for inlining
arch/i386/kernel/smp.c:9: warning: called from here
arch/i386/kernel/smp.c: In function `smp_send_reschedule':
arch/i386/kernel/smp.c:161: warning: inlining failed in call to 'send_IPI_m=
ask_bitmask': function not considered for inlining
arch/i386/kernel/smp.c:9: warning: called from here
arch/i386/kernel/smp.c: In function `smp_call_function':
arch/i386/kernel/smp.c:126: warning: inlining failed in call to '__send_IPI=
_shortcut': function not considered for inlining
arch/i386/kernel/smp.c:21: warning: called from here

  CC      arch/i386/kernel/io_apic.o
arch/i386/kernel/io_apic.c: In function `setup_IO_APIC':
arch/i386/kernel/io_apic.c:2110: warning: inlining failed in call to 'check=
_timer': function not considered for inlining
arch/i386/kernel/io_apic.c:2246: warning: called from here
arch/i386/kernel/io_apic.c: In function `check_timer':
arch/i386/kernel/io_apic.c:2049: warning: inlining failed in call to 'unloc=
k_ExtINT_logic': function not considered for inlining
arch/i386/kernel/io_apic.c:2208: warning: called from here

  CC      kernel/fork.o
kernel/fork.c: In function `copy_mm':
kernel/fork.c:270: warning: inlining failed in call to 'dup_mmap': function=
 not considered for inlining
kernel/fork.c:571: warning: called from here

  CC      mm/rmap.o
mm/rmap.c: In function `try_to_unmap':
mm/rmap.c:653: warning: inlining failed in call to 'try_to_unmap_file': fun=
ction not considered for inlining
mm/rmap.c:774: warning: called from here

  CC      fs/exec.o
fs/exec.c: In function `flush_old_exec':
fs/exec.c:566: warning: inlining failed in call to 'de_thread': function no=
t considered for inlining
fs/exec.c:800: warning: called from here

  CC      fs/namei.o
fs/namei.c: In function `link_path_walk':
fs/namei.c:491: warning: inlining failed in call to 'follow_dotdot': functi=
on not considered for inlining
fs/namei.c:637: warning: called from here
fs/namei.c:491: warning: inlining failed in call to 'follow_dotdot': functi=
on not considered for inlining
fs/namei.c:705: warning: called from here

  CC [M]  fs/nfsd/nfsxdr.o
fs/nfsd/nfsxdr.c: In function `nfssvc_encode_attrstat':
fs/nfsd/nfsxdr.c:150: warning: inlining failed in call to 'encode_fattr': f=
unction not considered for inlining
fs/nfsd/nfsxdr.c:386: warning: called from here
fs/nfsd/nfsxdr.c: In function `nfssvc_encode_diropres':
fs/nfsd/nfsxdr.c:150: warning: inlining failed in call to 'encode_fattr': f=
unction not considered for inlining
fs/nfsd/nfsxdr.c:395: warning: called from here
fs/nfsd/nfsxdr.c: In function `nfssvc_encode_readres':
fs/nfsd/nfsxdr.c:150: warning: inlining failed in call to 'encode_fattr': f=
unction not considered for inlining
fs/nfsd/nfsxdr.c:420: warning: called from here

  CC [M]  fs/nfsd/nfs3xdr.o
fs/nfsd/nfs3xdr.c: In function `encode_post_op_attr':
fs/nfsd/nfs3xdr.c:168: warning: inlining failed in call to 'encode_fattr3':=
 function not considered for inlining
fs/nfsd/nfs3xdr.c:246: warning: called from here
fs/nfsd/nfs3xdr.c: In function `encode_wcc_data':
fs/nfsd/nfs3xdr.c:204: warning: inlining failed in call to 'encode_saved_po=
st_attr': function not considered for inlining
fs/nfsd/nfs3xdr.c:269: warning: called from here
fs/nfsd/nfs3xdr.c: In function `nfs3svc_encode_attrstat':
fs/nfsd/nfs3xdr.c:168: warning: inlining failed in call to 'encode_fattr3':=
 function not considered for inlining
fs/nfsd/nfs3xdr.c:618: warning: called from here

  CC      fs/proc/array.o
fs/proc/array.c: In function `proc_pid_status':
fs/proc/array.c:232: warning: inlining failed in call to 'task_sig': functi=
on not considered for inlining
fs/proc/array.c:290: warning: called from here

  CC      drivers/block/elevator.o
drivers/block/elevator.c: In function `__elv_add_request':
include/linux/blkdev.h:617: warning: inlining failed in call to '__generic_=
unplug_device': function body not available
drivers/block/elevator.c:189: warning: called from here

  CC      drivers/char/n_tty.o
drivers/char/n_tty.c: In function `n_tty_receive_buf':
drivers/char/n_tty.c:529: warning: inlining failed in call to 'n_tty_receiv=
e_char': function not considered for inlining
drivers/char/n_tty.c:789: warning: called from here

  CC      drivers/char/vt_ioctl.o
drivers/char/vt_ioctl.c: In function `vt_ioctl':
drivers/char/vt_ioctl.c:187: warning: inlining failed in call to 'do_kdgkb_=
ioctl': function not considered for inlining
drivers/char/vt_ioctl.c:582: warning: called from here

  CC [M]  drivers/i2c/algos/i2c-algo-bit.o
drivers/i2c/algos/i2c-algo-bit.c: In function `bit_xfer':
drivers/i2c/algos/i2c-algo-bit.c:366: warning: inlining failed in call to '=
readbytes': function not considered for inlining
drivers/i2c/algos/i2c-algo-bit.c:494: warning: called from here            =
   =20

  CC [M]  drivers/ieee1394/eth1394.o
drivers/ieee1394/eth1394.c: In function `eth1394_remove':
drivers/ieee1394/eth1394.c:189: warning: inlining failed in call to 'purge_=
partial_datagram': function body not available
drivers/ieee1394/eth1394.c:403: warning: called from here
drivers/ieee1394/eth1394.c: In function `ether1394_host_reset':
drivers/ieee1394/eth1394.c:189: warning: inlining failed in call to 'purge_=
partial_datagram': function body not available
drivers/ieee1394/eth1394.c:708: warning: called from here
drivers/ieee1394/eth1394.c: In function `ether1394_data_handler':
drivers/ieee1394/eth1394.c:1029: warning: inlining failed in call to 'new_p=
artial_datagram': function not considered for inlining
drivers/ieee1394/eth1394.c:1197: warning: called from here
drivers/ieee1394/eth1394.c:1029: warning: inlining failed in call to 'new_p=
artial_datagram': function not considered for inlining
drivers/ieee1394/eth1394.c:1215: warning: called from here

  CC [M]  drivers/net/e1000/e1000_main.o
drivers/net/e1000/e1000_main.c: In function `e1000_up':
drivers/net/e1000/e1000_main.c:136: warning: inlining failed in call to 'e1=
000_irq_enable': function body not available
drivers/net/e1000/e1000_main.c:274: warning: called from here
drivers/net/e1000/e1000_main.c: In function `e1000_down':
drivers/net/e1000/e1000_main.c:135: warning: inlining failed in call to 'e1=
000_irq_disable': function body not available
drivers/net/e1000/e1000_main.c:284: warning: called from here
drivers/net/e1000/e1000_main.c: In function `e1000_clean_rx_irq':
drivers/net/e1000/e1000_main.c:155: warning: inlining failed in call to 'e1=
000_rx_checksum': function body not available
drivers/net/e1000/e1000_main.c:2327: warning: called from here

  CC      drivers/scsi/sg.o
drivers/scsi/sg.c: In function `sg_ioctl':
drivers/scsi/sg.c:209: warning: inlining failed in call to 'sg_jif_to_ms': =
function body not available
drivers/scsi/sg.c:930: warning: called from here
drivers/scsi/sg.c: In function `sg_cmd_done':
drivers/scsi/sg.c:209: warning: inlining failed in call to 'sg_jif_to_ms': =
function body not available
drivers/scsi/sg.c:1253: warning: called from here

  CC [M]  net/bluetooth/l2cap.o
net/bluetooth/l2cap.c: In function `l2cap_recv_frame':
net/bluetooth/l2cap.c:1637: warning: inlining failed in call to 'l2cap_sig_=
channel': function not considered for inlining
net/bluetooth/l2cap.c:1793: warning: called from here
net/bluetooth/l2cap.c: In function `l2cap_sig_channel':
net/bluetooth/l2cap.c:1356: warning: inlining failed in call to 'l2cap_conn=
ect_req': function not considered for inlining
net/bluetooth/l2cap.c:1661: warning: called from here

  CC [M]  net/bluetooth/bnep/core.o
net/bluetooth/bnep/core.c: In function `bnep_session':
net/bluetooth/bnep/core.c:293: warning: inlining failed in call to 'bnep_rx=
_frame': function not considered for inlining
net/bluetooth/bnep/core.c:473: warning: called from here

  CC [M]  net/bluetooth/rfcomm/core.o
net/bluetooth/rfcomm/core.c: In function `rfcomm_worker':
net/bluetooth/rfcomm/core.c:1695: warning: inlining failed in call to 'rfco=
mm_process_sessions': function not considered for inlining
net/bluetooth/rfcomm/core.c:1743: warning: called from here

  CC [M]  net/ipv4/netfilter/ip_tables.o
net/ipv4/netfilter/ip_tables.c: In function `translate_table':
net/ipv4/netfilter/ip_tables.c:671: warning: inlining failed in call to 'ch=
eck_entry': function not considered for inlining
net/ipv4/netfilter/ip_tables.c:850: warning: called from here

  CC [M]  net/sunrpc/xprt.o
net/sunrpc/xprt.c: In function `xprt_reserve':
net/sunrpc/xprt.c:84: warning: inlining failed in call to 'do_xprt_reserve'=
: function body not available
net/sunrpc/xprt.c:1307: warning: called from here


--=20
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Cooker) for i586
Linux 2.6.7-jam4 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-0.3mdk)) #2

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA22d3RlIHNEGnKMMRAhZhAJ0bafSMnc4EFjgrf/6qwEq0uM39kQCcD3yp
r4fg6Ji7KuRGoNsAORGnxaA=
=x0uh
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
