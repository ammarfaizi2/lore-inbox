Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbULWTrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbULWTrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 14:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULWTq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 14:46:56 -0500
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:62385 "EHLO
	bgo1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S261293AbULWTpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 14:45:55 -0500
Date: Thu, 23 Dec 2004 20:45:22 +0100
From: Kristian Eide <kreide@online.no>
Subject: Re: raid5 crash
In-reply-to: <16841.65119.240314.917998@cse.unsw.edu.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Message-id: <200412232045.26137.kreide@online.no>
MIME-version: 1.0
Content-type: multipart/signed; boundary=nextPart2210453.Pb6Fs8gehI;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-transfer-encoding: 7bit
References: <200412222304.36585.kreide@online.no>
 <16841.65119.240314.917998@cse.unsw.edu.au>
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2210453.Pb6Fs8gehI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> I doubt very much that this would happen with ext3.  I don't know
> about xfs, but I doubt it would happen their either.
> When using some other filesystem, what sort of data corruption are you
> getting?

This is with ext3:

kernel BUG at drivers/md/raid5.c:813!
invalid operand: 0000 [#1]
Modules linked in: sata_sil libata sbp2 ohci1394 ieee1394 usb_storage ehci_=
hcd=20
usbcore
CPU:    0
EIP:    0060:[<c039cdd2>]    Not tainted VLI
EFLAGS: 00010016   (2.6.9-gentoo-r10)
EIP is at add_stripe_bio+0x1c2/0x200
eax: 493c4b40   ebx: cbc5eaa0   ecx: e8257da0   edx: 00000000
esi: 493c4b18   edi: 00000000   ebp: f58958b0   esp: f5995a98
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 8803, threadinfo=3Df5994000 task=3Dd841aaa0)
Stack: c01551f7 f7ddf200 00000118 f58957c8 493c4b18 00000000 e8257da0 c039e=
092
       f58957c8 e8257da0 00000001 00000000 00000000 f5995af0 f5fde2e0 493c4=
b30
       00000000 00000003 00000004 f5fde2e0 dfe90e00 00000001 00000000 f7d84=
088
Call Trace:
 [<c01551f7>] __getblk+0x37/0x70
 [<c039e092>] make_request+0x122/0x200
 [<c032dc6f>] generic_make_request+0x15f/0x1e0
 [<c032dd4d>] submit_bio+0x5d/0x100
 [<c01b5ec4>] ext3_get_block+0x64/0xb0
 [<c0172d43>] mpage_bio_submit+0x23/0x40
 [<c0173170>] do_mpage_readpage+0x2d0/0x480
 [<c0332b08>] as_next_request+0x38/0x50
 [<c032a706>] elv_next_request+0x16/0x110
 [<c02b4c1e>] kobject_put+0x1e/0x30
 [<c02b4bf0>] kobject_release+0x0/0x10
 [<c02b54df>] radix_tree_node_alloc+0x1f/0x60
 [<c02b5762>] radix_tree_insert+0xe2/0x100
 [<c0136e54>] add_to_page_cache+0x54/0x80
 [<c017346b>] mpage_readpages+0x14b/0x180
 [<c01b5e60>] ext3_get_block+0x0/0xb0
 [<c013ddf4>] read_pages+0x134/0x140
 [<c01b5e60>] ext3_get_block+0x0/0xb0
 [<c013b390>] __alloc_pages+0x1d0/0x370
 [<c013e04f>] do_page_cache_readahead+0xcf/0x130
 [<c013e234>] page_cache_readahead+0x184/0x1e0
 [<c013765c>] do_generic_mapping_read+0x11c/0x4d0
 [<c0137cae>] __generic_file_aio_read+0x1be/0x1f0
 [<c0137a10>] file_read_actor+0x0/0xe0
 [<c02b4c1e>] kobject_put+0x1e/0x30
 [<c0137d3a>] generic_file_aio_read+0x5a/0x80
 [<c015261e>] do_sync_read+0xbe/0xf0
 [<f92cdc66>] ata_qc_complete+0x46/0xe0 [libata]
 [<c011d590>] autoremove_wake_function+0x0/0x60
 [<c036b9aa>] scsi_finish_command+0x7a/0xc0
 [<c011bb9f>] recalc_task_prio+0x8f/0x190
 [<c015270c>] vfs_read+0xbc/0x170
 [<c040e363>] schedule+0x2a3/0x470
 [<c0152a71>] sys_read+0x51/0x80
 [<c010603b>] syscall_call+0x7/0xb
Code: 72 08 0f ba a8 90 00 00 00 02 83 c4 0c 5b 5e 5f 5d c3 89 cb e9 cd fe =
ff=20
ff 8b 5d 00 e9 c5 fe ff ff 77 08 39 f0 0f 86 94 fe ff ff <0f> 0b 2d 0370 92=
=20
44 c0 e9 87 fe ff ff 0f 87 a8 fe ff ff 39 f0

So apparently it can happen with ext3 as well.

=2D-=20
Kristian

--nextPart2210453.Pb6Fs8gehI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBByyBWRBuET7ul/ccRAmSsAKCoF6WPzcDO1KHql0IrtmrE6aLKmgCfdKTf
gJ0G54HRSfam3EINXcPTews=
=RutF
-----END PGP SIGNATURE-----

--nextPart2210453.Pb6Fs8gehI--
