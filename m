Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbUKWKOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbUKWKOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUKWKOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:14:23 -0500
Received: from pop.gmx.de ([213.165.64.20]:13802 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262352AbUKWKNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:13:36 -0500
X-Authenticated: #4512188
Message-ID: <41A30D3E.9090506@gmx.de>
Date: Tue, 23 Nov 2004 11:13:18 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
References: <200411221530.30325.lkml@kcore.org> <20041122155106.GG2714@holomorphy.com>
In-Reply-To: <20041122155106.GG2714@holomorphy.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9FABCCCCF0C7D5396BCF1C01"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9FABCCCCF0C7D5396BCF1C01
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:
> On Mon, Nov 22, 2004 at 03:30:29PM +0100, Jan De Luyck wrote:
> 
>>[resend with correct email address for LKML]
>>[Please CC all answers from linux-xfs to me, since I'm not subscribed on that list]
>>Yesterday I encountered an on-the-fly corruption of my /home filesystem. It worked perfectly one second, the next I hit these nice errors:
>>Nov 21 16:37:22 precious kernel: 0x0: 31 9e ce 63 cf ff 9c cf ff 31 61 63 ff ff ff ff 
>>Nov 21 16:37:23 precious kernel: Filesystem "hda5": XFS internal error xfs_da_do_buf(2) at line 2273 of file fs/xfs/xfs_da_btree.c.  Caller 0xc01fb908
>>Nov 21 16:37:23 precious kernel:  [xfs_da_do_buf+905/2160] xfs_da_do_buf+0x389/0x870
> 
> 
> I don't have any ideas at the moment, but please cc: me also. I'd like
> to watch for issues I do understand as this bug's nature is clarified.

While we are at it: Is xfs known to be broken while preempt is on? (Esp 
using ck's preemp big kernel lock?) I got following using a raid0 setup 
with xfs. I thought it would be a driver issue, but reformatting to ext3 
the stripe array runs now w/o probs for a few days. (xfs crapped out 
after a few hours on heavy disk activity.)

Nov 21 10:10:15 tachyon ata2: command 0x25 timeout, stat 0xd0 host_stat 0x61
Nov 21 10:10:15 tachyon ata2: status=0xd0 { Busy }
Nov 21 10:10:15 tachyon SCSI error : <1 0 0 0> return code = 0x8000002
Nov 21 10:10:15 tachyon Current sdb: sense = 70 10
Nov 21 10:10:15 tachyon end_request: I/O error, dev sdb, sector 10480847
Nov 21 10:10:15 tachyon ATA: abnormal status 0xD0 on port 0xF08060C7
Nov 21 10:10:15 tachyon ATA: abnormal status 0xD0 on port 0xF08060C7
Nov 21 10:10:15 tachyon ATA: abnormal status 0xD0 on port 0xF08060C7
Nov 21 10:10:45 tachyon ata2: command 0x25 timeout, stat 0xd0 host_stat 0x61
Nov 21 10:10:45 tachyon ata2: status=0xd0 { Busy }
Nov 21 10:10:45 tachyon SCSI error : <1 0 0 0> return code = 0x8000002
Nov 21 10:10:45 tachyon Current sdb: sense = 70 10
Nov 21 10:10:45 tachyon end_request: I/O error, dev sdb, sector 10480855
Nov 21 10:10:45 tachyon I/O error in filesystem ("md0") meta-data dev 
md0 block 0x13fd990       ("xfs_trans_read_buf") error 5 buf count 8192

etc...

If you need more infos (dmesg, .config, etc) let me know.

Prakash

--------------enig9FABCCCCF0C7D5396BCF1C01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBow1CxU2n/+9+t5gRAlxSAKCrkxPRzSkwXgpNOxx9W/qRWXZoVgCgpzmP
rVsMuFAZQ0QY7BlCWDlE4fo=
=XRsr
-----END PGP SIGNATURE-----

--------------enig9FABCCCCF0C7D5396BCF1C01--
