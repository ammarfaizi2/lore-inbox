Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbVIICzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbVIICzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbVIICzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:55:06 -0400
Received: from mail02.solnet.ch ([212.101.4.136]:65505 "EHLO mail02.solnet.ch")
	by vger.kernel.org with ESMTP id S965246AbVIICzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:55:04 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>
Subject: 2.6.13-mm2 - drivers/char/speakup/speakup doesn't compile (+warnings from other things)
Date: Fri, 9 Sep 2005 04:52:12 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?utf-8?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/iP?=
 =?utf-8?q?Ov8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B2=7C?=
 =?utf-8?q?l6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?utf-8?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?utf-8?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1870536.kxoOdA8DrI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509090452.16097.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1870536.kxoOdA8DrI
Content-Type: multipart/mixed;
  boundary="Boundary-01=_djPIDyMU4OSoGOG"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_djPIDyMU4OSoGOG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Thursday 08 September 2005 14:30, Andrew Morton a =E9crit=A0:
| - Many tty drivers still won't compile

indeed ... here one of them:

  CC [M]  drivers/char/speakup/speakup.o
drivers/char/speakup/speakup.c: In function 'speakup_paste_selection':
drivers/char/speakup/speakup.c:491: error: 'struct tty_ldisc' has no member=
 named 'receive_room'
drivers/char/speakup/speakup.c:491: error: 'struct tty_ldisc' has no member=
 named 'receive_room'
make[3]: *** [drivers/char/speakup/speakup.o] Error 1
make[2]: *** [drivers/char/speakup] Error 2
make[1]: *** [drivers/char] Error 2

warnings from compile (gcc 4.0.1) till this error can be found in=20
attachement 'build-log-$kernelver-processed'.=20

the xfs trouble with '"__BIG_ENDIAN" is not defined' is now happening since=
 rc6-mm1.

config can be found here:

http://cvs.archlinux.org/cgi-bin/viewcvs.cgi/kernels/kernel26mm/config?rev=
=3D1.34&cvsroot=3DExtra&content-type=3Dtext/vnd.viewcvs-markup

hope this info is usable to somebody out there,

greetings,
Damir

=2D-=20
  Customer: "I'm sorry. I think I just deleted the Internet!"=20
  Tech Support: "That's ok. We have it backed up here on tape somewhere."=20

--Boundary-01=_djPIDyMU4OSoGOG
Content-Type: text/plain;
  charset="iso-8859-1";
  name="build-log-2.6.13-mm2-processed"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="build-log-2.6.13-mm2-processed"

==> Builing kernel 2.6.13-mm2 started at
Fri Sep  9 04:04:45 CEST 2005

arch/i386/kernel/cpu/transmeta.c: In function 'init_transmeta':
arch/i386/kernel/cpu/transmeta.c:11: warning: 'cpu_freq' may be used uninitialized in this function

arch/i386/kernel/apm.c: In function 'suspend':
arch/i386/kernel/apm.c:1186: warning: 'pm_send_all' is deprecated (declared at include/linux/pm.h:122)
arch/i386/kernel/apm.c:1240: warning: 'pm_send_all' is deprecated (declared at include/linux/pm.h:122)
arch/i386/kernel/apm.c: In function 'check_events':
arch/i386/kernel/apm.c:1361: warning: 'pm_send_all' is deprecated (declared at include/linux/pm.h:122)

kernel/resource.c:482: warning: '__check_region' is deprecated (declared at kernel/resource.c:470)

kernel/intermodule.c:178: warning: 'inter_module_register' is deprecated (declared at kernel/intermodule.c:38)
kernel/intermodule.c:179: warning: 'inter_module_unregister' is deprecated (declared at kernel/intermodule.c:78)
kernel/intermodule.c:181: warning: 'inter_module_put' is deprecated (declared at kernel/intermodule.c:159)

kernel/power/pm.c:258: warning: 'pm_register' is deprecated (declared at kernel/power/pm.c:62)
kernel/power/pm.c:259: warning: 'pm_unregister' is deprecated (declared at kernel/power/pm.c:85)
kernel/power/pm.c:260: warning: 'pm_unregister_all' is deprecated (declared at kernel/power/pm.c:114)
kernel/power/pm.c:261: warning: 'pm_send_all' is deprecated (declared at kernel/power/pm.c:233)

fs/bio.c: In function 'bio_alloc_bioset':
fs/bio.c:167: warning: 'idx' may be used uninitialized in this function

In file included from fs/cifs/cifsfs.c:38:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/cifssmb.c:36:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/cifs_debug.c:29:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/connect.c:36:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/dir.c:29:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/file.c:32:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/inode.c:28:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/link.c:26:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/misc.c:26:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/netmisc.c:35:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/transport.c:31:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/asn1.c:27:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/xattr.c:26:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/cifsencrypt.c:24:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/fcntl.c:26:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/readdir.c:27:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type
In file included from fs/cifs/ioctl.c:27:
fs/cifs/cifsglob.h:335: warning: type qualifiers ignored on function return type

fs/jfs/jfs_txnmgr.c: In function 'xtLog':
fs/jfs/jfs_txnmgr.c:1917: warning: 'pxd.addr2' may be used uninitialized in this function
fs/jfs/jfs_txnmgr.c:1917: warning: 'pxd.addr1' may be used uninitialized in this function
fs/jfs/jfs_txnmgr.c:1917: warning: 'pxd.len' may be used uninitialized in this function

fs/nfsd/nfsctl.c: In function 'write_filehandle':
fs/nfsd/nfsctl.c:262: warning: 'maxsize' may be used uninitialized in this function

fs/reiser4/inode_ops.c:597: warning: initialization from incompatible pointer type

fs/udf/balloc.c: In function 'udf_table_new_block':
fs/udf/balloc.c:756: warning: 'goal_eloc.logicalBlockNum' may be used uninitialized in this function

fs/udf/super.c: In function 'udf_load_partition':
fs/udf/super.c:1351: warning: 'ino.partitionReferenceNum' may be used uninitialized in this function

In file included from fs/xfs/xfs_acl.c:39:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_acl.c: In function 'xfs_acl_access':
fs/xfs/xfs_acl.c:445: warning: 'matched.ae_perm' may be used uninitialized in this function
In file included from fs/xfs/xfs_alloc.c:48:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_alloc_btree.c:50:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_alloc_btree.c: In function 'xfs_alloc_insrec':
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_startblock' may be used uninitialized in this function
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_blockcount' may be used uninitialized in this function
In file included from fs/xfs/xfs_attr.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_attr_leaf.c:52:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_bmap.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap.c: In function 'xfs_bmap_alloc':
fs/xfs/xfs_bmap.c:2335: warning: 'rtx' is used uninitialized in this function
In file included from fs/xfs/xfs_bmap_btree.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.c:2020:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.c:2534:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_btree.c:51:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_da_btree.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_dir.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_dir2.c:52:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_dir2_block.c:51:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_dir2_data.c:51:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_dir2_leaf.c:54:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_dir2_node.c:51:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_dir2_sf.c:50:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_dir2_sf.c: In function 'xfs_dir2_block_sfsize':
fs/xfs/xfs_dir2_sf.c:110: warning: 'parent' may be used uninitialized in this function
In file included from fs/xfs/xfs_dir_leaf.c:52:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_dir_leaf.c: In function 'xfs_dir_leaf_to_shortform':
fs/xfs/xfs_dir_leaf.c:653: warning: 'parent' may be used uninitialized in this function
In file included from fs/xfs/xfs_error.c:45:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_fsops.c:45:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_ialloc.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_ialloc_btree.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_ialloc_btree.c: In function 'xfs_inobt_insrec':
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_free' is used uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_freecount' is used uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:567: warning: 'nrec.ir_startino' may be used uninitialized in this function
In file included from fs/xfs/xfs_iget.c:49:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_inode.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_inode_item.c:54:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_inode_item.c:344:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_inode_item.c:476:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_iocore.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_iomap.c:48:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_itable.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_dfrag.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_log_recover.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_macros.c:49:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_mount.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_rename.c:44:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_trans.c:48:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_trans_inode.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_utils.c:44:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_vfsops.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_vnodeops.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/xfs_rw.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/linux-2.6/xfs_aops.c:42:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/linux-2.6/xfs_file.c:42:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/linux-2.6/xfs_ioctl.c:46:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/linux-2.6/xfs_iops.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/linux-2.6/xfs_lrw.c:52:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/linux-2.6/xfs_super.c:47:
fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/quota/xfs_dquot.c:47:
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/quota/xfs_dquot_item.c:47:
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/quota/xfs_trans_dquot.c:47:
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/quota/xfs_qm_syscalls.c:46:
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/quota/xfs_qm_bhv.c:47:
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/quota/xfs_qm.c:48:
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined
In file included from fs/xfs/quota/xfs_qm_stats.c:46:
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:508:21: warning: "__BIG_ENDIAN" is not defined
/home/damir/cvsARCH/extra/kernels/kernel26mm/src/linux-2.6.13-mm2/fs/xfs/xfs_bmap_btree.h:626:21: warning: "__BIG_ENDIAN" is not defined

ipc/msg.c: In function 'sys_msgctl':
ipc/msg.c:333: warning: 'setbuf.qbytes' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.mode' may be used uninitialized in this function

ipc/sem.c: In function 'semctl_down':
ipc/sem.c:803: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/sem.c:803: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/sem.c:803: warning: 'setbuf.mode' may be used uninitialized in this function

drivers/atm/nicstar.c: In function 'process_rsq':
drivers/atm/nicstar.c:2125: warning: 'previous' may be used uninitialized in this function

drivers/atm/iphase.c:961: warning: 'tcnter' defined but not used
drivers/atm/iphase.c:963: warning: 'xdump' defined but not used

drivers/block/DAC960.c: In function 'DAC960_DetectController':
drivers/block/DAC960.c:2723: warning: 'ErrorStatus' may be used uninitialized in this function
drivers/block/DAC960.c:2723: warning: 'Parameter0' may be used uninitialized in this function
drivers/block/DAC960.c:2723: warning: 'Parameter1' may be used uninitialized in this function

drivers/char/agp/efficeon-agp.c: In function 'efficeon_create_gatt_table':
drivers/char/agp/efficeon-agp.c:222: warning: passing argument 1 of 'virt_to_phys' makes pointer from integer without a cast

drivers/char/agp/via-agp.c: In function 'agp_via_suspend':
drivers/char/agp/via-agp.c:454: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result
drivers/char/agp/via-agp.c: In function 'agp_via_resume':
drivers/char/agp/via-agp.c:463: warning: ignoring return value of 'pci_set_power_state', declared with attribute warn_unused_result

drivers/char/drm/drm_stub.c: In function 'drm_get_dev':
drivers/char/drm/drm_stub.c:248: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result

drivers/char/speakup/speakup.c: In function 'speakup_paste_selection':
drivers/char/speakup/speakup.c:491: error: 'struct tty_ldisc' has no member named 'receive_room'
drivers/char/speakup/speakup.c:491: error: 'struct tty_ldisc' has no member named 'receive_room'
make[3]: *** [drivers/char/speakup/speakup.o] Error 1
make[2]: *** [drivers/char/speakup] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2
==> Kernel build failed; time now is
Fri Sep  9 04:26:50 CEST 2005

--Boundary-01=_djPIDyMU4OSoGOG--

--nextPart1870536.kxoOdA8DrI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDIPjgPABWKV6NProRAp6DAJ4p3faQlZUFR9g8UTqdU82DZndA/ACZAXoE
yqweAc99GWz1r1R/tI3/y+s=
=JoH3
-----END PGP SIGNATURE-----

--nextPart1870536.kxoOdA8DrI--
