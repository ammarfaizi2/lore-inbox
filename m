Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbTFZLNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 07:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265599AbTFZLNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 07:13:36 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:14977 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S265590AbTFZLNY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 07:13:24 -0400
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Edward Tandi <ed@efix.biz>, Timothy Miller <miller@techsource.com>,
       reiser@namesys.com
Subject: Re: AMD MP, SMP, Tyan 2466, REISERFS I/O error
Date: Thu, 26 Jun 2003 08:25:54 -0400
User-Agent: KMail/1.4.3
Cc: Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <BB1F47F5.17533%kernel@mousebusiness.com> <3EFA2939.2060005@techsource.com> <1056583075.31265.22.camel@wires.home.biz>
In-Reply-To: <1056583075.31265.22.camel@wires.home.biz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_6793V5MHHHAGSF077PTN"
Message-Id: <200306260825.54076.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_6793V5MHHHAGSF077PTN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am working on a Tyan 2466 SMP/Athlon server now and am getting tons of=20
reiserf errors (see attached /var/log/syslog) that claim an i/o error, ye=
t=20
the log does not show any errors from the driver (should it?). =20
Unfortunately, Reiser does not indicate which drive the error is produced=
=20
from.  My configuration is:

Tyan 2466 SMP 2 x AMD2400-MP
512 MB PC2100 DDR-> not registered!
Debian woody
2.4.21 reiser
system drive (os, swap) wd800-bb (80 gb ide)
data drives: 3ware 7200, 2 x wd2000 (200 gb ide) RAID-0




On Wednesday 25 June 2003 07:17 pm, Edward Tandi wrote:
> On Wed, 2003-06-25 at 23:59, Timothy Miller wrote:
> > Edward Tandi wrote:
> > > Yes, for SMP mode you absolutely need to use 'registered' RAM. Norm=
al
> > > PC2100 ram will work OK with one processor but quickly fails with t=
wo
> > > (I had the same problems). Apparently, DDR RAM uses one clock edge =
to
> > > transfer in one direction and the opposite edge to transfer back ag=
ain
> > > so the registers do synchronisation between one processor writing t=
o
> > > the same location that the other one reads from. That's how it was
> > > explained to me anyway.
> >
> > DDR memory works very much like single data rate, except that data is
> > transferred (in whichever direction it's going) on both edges of the
> > clock, thus doubling the transfer rate.  The memory does not switch
> > between reading and writing as you describe it.
> >
> > I believe registering is for reliability.  Data is transferred one cl=
ock
> > cycle later but reduces signal loading.
>
> Thanks for the clarification. I do not profess to be an expert in the
> technology. Two writes or a read+write per clock cycle is close enough
> for the purpose of the discussion.
>
> The point I was trying to make is that the registers are there to deal
> with an SMP race condition of some sort. Athlon MP motherboards fitted
> with two processors will not work properly without 'registered' RAM. I
> have hard experience of this and it this experience I am sharing with
> someone who is seeing the same symptoms.
>
> Ed-T.

--=20
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
--------------Boundary-00=_6793V5MHHHAGSF077PTN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="reiserfs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="reiserfs.txt"

Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [22 154 0xfffffffffffffff DIRECT]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5350: reiserfs_delete_solid_item: i/o failure occurred trying to delete [22 154 0x0 SD]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [22 140 0x0 SD] stat datais_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [22 140 0xfffffffffffffff DIRECT]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5350: reiserfs_delete_solid_item: i/o failure occurred trying to delete [22 140 0x0 SD]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [22 101 0x0 SD] stat datais_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [22 101 0xfffffffffffffff DIRECT]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5350: reiserfs_delete_solid_item: i/o failure occurred trying to delete [22 101 0x0 SD]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [22 152 0x0 SD] stat datais_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [22 152 0xfffffffffffffff DIRECT]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5350: reiserfs_delete_solid_item: i/o failure occurred trying to delete [22 152 0x0 SD]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [22 104 0x0 SD] stat datais_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5657: reiserfs_do_truncate: i/o failure occurred trying to truncate [22 104 0xfffffffffffffff DIRECT]
Jun 26 07:04:10 sentry kernel: is_tree_node: node level 11226 does not match to the expected one 1
Jun 26 07:04:10 sentry kernel: vs-5150: search_by_key: invalid format found in block 266772. Fsck?
Jun 26 07:04:10 sentry kernel: vs-5350: reiserfs_delete_solid_item: i/o failure occurred trying to delete [22 104 0x0 SD]


--------------Boundary-00=_6793V5MHHHAGSF077PTN--

