Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271867AbRIDAsu>; Mon, 3 Sep 2001 20:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271868AbRIDAsm>; Mon, 3 Sep 2001 20:48:42 -0400
Received: from [209.250.60.128] ([209.250.60.128]:57092 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S271867AbRIDAs2>; Mon, 3 Sep 2001 20:48:28 -0400
Date: Mon, 3 Sep 2001 19:48:09 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Cc: linux_udf@hpesjro.fc.hp.com, bfennema@falcon.csc.calpoly.edu
Subject: no files shown on UDF DVD
Message-ID: <20010903194809.A15650@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org, linux_udf@hpesjro.fc.hp.com,
	bfennema@falcon.csc.calpoly.edu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 7:37pm  up  1:11,  0 users,  load average: 1.38, 1.20, 1.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When I mount the Matrix DVD using the iso9660 filesystem, it appears
that the filesystem hierarchy is correct.

If, however, I use the udf filesystem, there are exactly zero files
shown as being on the CD.  As I understand it, this should not be the
case.

I've attached the UDF-fs DEBUG messages that resulted from
mounting the DVD.  I hope they're helpful in resolving this.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=udf-debug

UDF-fs DEBUG lowlevel.c:57:udf_get_last_session: XA disk: no, vol_desc_start=0
UDF-fs DEBUG super.c:1410:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:1419:udf_read_super: Lastblock=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG super.c:437:udf_vrs: ISO9660 Primary Volume Descriptor found
UDF-fs DEBUG super.c:446:udf_vrs: ISO9660 Volume Descriptor Set Terminator found
UDF-fs DEBUG super.c:760:udf_load_pvoldesc: recording time 933640160/0, 1999/08/02 17:29 (1e5c)
UDF-fs DEBUG super.c:770:udf_load_pvoldesc: volIdent[] = 'THE_MATRIX_16X9LB_N_AMERICA'
UDF-fs DEBUG super.c:777:udf_load_pvoldesc: volSetIdent[] = '27028BAA'
UDF-fs DEBUG super.c:961:udf_load_logicalvol: Partition (0:0) type 1 on volume 1
UDF-fs DEBUG super.c:971:udf_load_logicalvol: FileSet found in LogicalVolDesc at block=0, partition=0
UDF-fs DEBUG super.c:807:udf_load_partdesc: Searching map: (0 == 0)
UDF-fs DEBUG super.c:881:udf_load_partdesc: Partition (0:0 type 1511) starts at physical 665, block length 4097670
UDF-fs DEBUG super.c:1210:udf_load_partition: Using anchor in block 256
UDF-fs DEBUG super.c:732:udf_find_fileset: Fileset at block=0, partition=0
UDF-fs DEBUG super.c:793:udf_load_fileset: Rootdir at block=2, partition=0
UDF-fs INFO UDF 0.9.4.1-ro (2001/06/13) Mounting volume 'THE_MATRIX_16X9LB_N_AMERICA', timestamp 1999/08/02 19:29 (1ed4)
UDF-fs DEBUG directory.c:237:udf_get_fileident: 0x0 != TID_FILE_IDENT_DESC
UDF-fs DEBUG directory.c:239:udf_get_fileident: offset: 532 sizeof: 38 bufsize: 2048
UDF-fs DEBUG directory.c:237:udf_get_fileident: 0x0 != TID_FILE_IDENT_DESC
UDF-fs DEBUG directory.c:239:udf_get_fileident: offset: 532 sizeof: 38 bufsize: 2048

--bg08WKrSYDhXBjb5--
