Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbUALICV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 03:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266080AbUALICV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 03:02:21 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:27086 "EHLO mail96.atlas.de")
	by vger.kernel.org with ESMTP id S266077AbUALICI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 03:02:08 -0500
Subject: smbfs-problems with linux-2.6.x and samba 3.0.1 on debian unstable
From: Michael Reincke <reincke.m@atlas.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-M5pb+AxHSnxsFMGSD0OX"
Organization: ATLAS ELEKTRONIK GmbH
Message-Id: <1073894523.18063.42.camel@pcew80.atlas.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 09:02:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M5pb+AxHSnxsFMGSD0OX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

by end of last week i started to give kernel 2.6 a try.  All went fine
execpt for the smbfs.  Which is used via autofs to connect to windows
machine (NT 4.0, 2000 and XP).  Whenn transfering much of data (which
read data, process it and writ it back) with varigated file size the
connection to the windows server stalls. I attach parts of the syslog
which belongs to the problem.  Due to the problems i switched back to
kernel 2.4.24 and as before testing 2.6.x no problems.

Thanks

-- 
Michael Reincke
ATLAS ELEKTRONIK GmbH, Bremen (Germany)
Software Build Management, NUT Team 2
28305 Bremen, Germany
Tel-   : +49 (0)421 457-2302
Fax    : +49 (0)421 457-3913
E-mail : reincke.m@atlas.de


--=-M5pb+AxHSnxsFMGSD0OX
Content-Disposition: attachment; filename=samba
Content-Type: text/plain; name=samba; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Jan  9 09:07:00 pcew80 kernel: smb_add_request: request [c19db180, mid=25674] timed out!
Jan  9 09:07:00 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:07:03 pcew80 kernel: smb_receive_header: short packet: 0
Jan  9 09:07:33 pcew80 kernel: smb_add_request: request [c19db180, mid=38555] timed out!
Jan  9 09:07:33 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:07:33 pcew80 kernel: smb_add_request: request [c19db280, mid=38556] timed out!
Jan  9 09:07:33 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:08:08 pcew80 kernel: smb_add_request: request [c19db180, mid=42773] timed out!
Jan  9 09:08:08 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:08:41 pcew80 kernel: smb_add_request: request [c19db280, mid=8255] timed out!
Jan  9 09:08:41 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:09:53 pcew80 kernel: smb_add_request: request [c19db280, mid=25694] timed out!
Jan  9 09:09:53 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:10:57 pcew80 kernel: smb_add_request: request [c19db180, mid=31595] timed out!
Jan  9 09:10:57 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:13:15 pcew80 kernel: smb_add_request: request [c19dbe80, mid=18059] timed out!
Jan  9 09:13:15 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:13:47 pcew80 kernel: smb_add_request: request [c19dbe80, mid=42667] timed out!
Jan  9 09:13:47 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:13:50 pcew80 kernel: smb_get_length: Invalid NBT packet, code=2f
Jan  9 09:13:50 pcew80 kernel: smb_errno: class ERRSRV, code 91 from command 0x4
Jan  9 09:14:20 pcew80 kernel: smb_add_request: request [c19dbe80, mid=55474] timed out!
Jan  9 09:14:20 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 09:23:18 pcew80 kernel: smb_add_request: request [c19dbe80, mid=32499] timed out!
Jan  9 09:29:58 pcew80 kernel: smb_add_request: request [c19db080, mid=16978] timed out!
Jan  9 09:43:57 pcew80 kernel: smb_add_request: request [c19db080, mid=54426] timed out!
Jan  9 09:43:57 pcew80 kernel: smb_open: bcb6/SensorConfig_c.h,v open failed, result=-5
Jan  9 09:44:34 pcew80 kernel: smb_add_request: request [c19db180, mid=21404] timed out!
Jan  9 10:05:50 pcew80 kernel: smb_add_request: request [c19dbd80, mid=44975] timed out!
Jan  9 10:05:50 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:11:22 pcew80 kernel: smb_add_request: request [c19db080, mid=11535] timed out!
Jan  9 10:11:22 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:11:52 pcew80 kernel: smb_add_request: request [c19db080, mid=17680] timed out!
Jan  9 10:11:52 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:12:23 pcew80 kernel: smb_add_request: request [c19db080, mid=26133] timed out!
Jan  9 10:12:23 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:12:53 pcew80 kernel: smb_add_request: request [c19db080, mid=36696] timed out!
Jan  9 10:12:53 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:13:23 pcew80 kernel: smb_add_request: request [c19db080, mid=46787] timed out!
Jan  9 10:13:23 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:13:54 pcew80 kernel: smb_add_request: request [c19db080, mid=55174] timed out!
Jan  9 10:13:54 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:14:47 pcew80 kernel: smb_add_request: request [c19db080, mid=15937] timed out!
Jan  9 10:14:47 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:15:18 pcew80 kernel: smb_add_request: request [c19db280, mid=21937] timed out!
Jan  9 10:15:18 pcew80 kernel: smb_open: evoexamplelocalframe1/EVOExampleLocalFrame1Unit.dfm,v open failed, result=-5
Jan  9 10:15:48 pcew80 kernel: smb_add_request: request [c19db080, mid=40582] timed out!
Jan  9 10:15:48 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:16:23 pcew80 kernel: smb_add_request: request [c19db080, mid=50279] timed out!
Jan  9 10:16:23 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:16:54 pcew80 kernel: smb_add_request: request [c19db080, mid=59423] timed out!
Jan  9 10:16:54 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:17:26 pcew80 kernel: smb_add_request: request [c19db080, mid=6612] timed out!
Jan  9 10:17:26 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:17:57 pcew80 kernel: smb_add_request: request [c19db080, mid=13650] timed out!
Jan  9 10:17:57 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:18:27 pcew80 kernel: smb_add_request: request [c19db080, mid=22726] timed out!
Jan  9 10:18:27 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:18:57 pcew80 kernel: smb_add_request: request [c19db080, mid=29484] timed out!
Jan  9 10:19:28 pcew80 kernel: smb_add_request: request [c19db080, mid=37714] timed out!
Jan  9 10:19:28 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:19:58 pcew80 kernel: smb_add_request: request [c19db080, mid=44935] timed out!
Jan  9 10:19:58 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:20:03 pcew80 kernel: smbiod_handle_request: smbiod got a request ... and we don't implement oplocks!
Jan  9 10:20:33 pcew80 kernel: smb_add_request: request [c19db080, mid=56737] timed out!
Jan  9 10:20:33 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 10:20:33 pcew80 kernel: smb_add_request: request [c19db280, mid=56738] timed out!
Jan  9 10:20:37 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56739] timed out!
Jan  9 10:21:03 pcew80 kernel: smb_add_request: request [c19db080, mid=56740] timed out!
Jan  9 10:21:03 pcew80 kernel: smb_file_write: lib_bcb6/,WSSInterface_RTP.lib, validation failed, error=4294967291
Jan  9 10:21:03 pcew80 kernel: smb_add_request: request [c19db280, mid=56741] timed out!
Jan  9 10:21:12 pcew80 kernel: smb_add_request: request [c19dbd80, mid=56742] timed out!
Jan  9 10:21:33 pcew80 kernel: smb_add_request: request [c19db280, mid=56743] timed out!
Jan  9 10:21:33 pcew80 kernel: smb_add_request: request [c19db080, mid=56744] timed out!
Jan  9 10:21:47 pcew80 kernel: smb_add_request: request [c19db180, mid=56745] timed out!
Jan  9 10:22:03 pcew80 kernel: smb_add_request: request [c19db280, mid=56746] timed out!
Jan  9 10:22:03 pcew80 kernel: smb_add_request: request [c19db080, mid=56747] timed out!
Jan  9 10:22:22 pcew80 kernel: smb_add_request: request [c19dbd80, mid=56748] timed out!
Jan  9 10:22:33 pcew80 kernel: smb_add_request: request [c19db280, mid=56749] timed out!
Jan  9 10:22:33 pcew80 kernel: smb_add_request: request [c19db080, mid=56750] timed out!
Jan  9 10:22:33 pcew80 kernel: smb_lookup: find common/opsw failed, error=-5
Jan  9 10:22:57 pcew80 kernel: smb_add_request: request [c19dbd80, mid=56751] timed out!
Jan  9 10:23:03 pcew80 kernel: smb_add_request: request [c19db280, mid=56752] timed out!
Jan  9 10:23:03 pcew80 kernel: smb_add_request: request [c19db080, mid=56753] timed out!
Jan  9 10:23:32 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56754] timed out!
Jan  9 10:23:33 pcew80 kernel: smb_add_request: request [c19db280, mid=56755] timed out!
Jan  9 10:23:33 pcew80 kernel: smb_add_request: request [c19db080, mid=56756] timed out!
Jan  9 10:24:03 pcew80 kernel: smb_add_request: request [c19db280, mid=56757] timed out!
Jan  9 10:24:03 pcew80 kernel: smb_add_request: request [c19db080, mid=56758] timed out!
Jan  9 10:24:07 pcew80 kernel: smb_add_request: request [c19dbd80, mid=56759] timed out!
Jan  9 10:24:08 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56760] timed out!
Jan  9 10:24:08 pcew80 kernel: smbiod_handle_request: smbiod got a request ... and we don't implement oplocks!
Jan  9 10:24:33 pcew80 kernel: smb_add_request: request [c19db280, mid=56761] timed out!
Jan  9 10:24:33 pcew80 kernel: smb_add_request: request [c19db080, mid=56762] timed out!
Jan  9 10:24:33 pcew80 kernel: smb_lookup: find common/opsw failed, error=-5
Jan  9 10:24:38 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56763] timed out!
Jan  9 10:24:42 pcew80 kernel: smb_add_request: request [c19db180, mid=56764] timed out!
Jan  9 10:25:03 pcew80 kernel: smb_add_request: request [c19db280, mid=56765] timed out!
Jan  9 10:25:08 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56766] timed out!
Jan  9 10:25:08 pcew80 kernel: smb_lookup: find R/runtime failed, error=-5
Jan  9 10:25:17 pcew80 kernel: smb_add_request: request [c19db380, mid=56767] timed out!
Jan  9 10:25:33 pcew80 kernel: smb_add_request: request [c19db280, mid=56768] timed out!
Jan  9 10:25:38 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56769] timed out!
Jan  9 10:25:52 pcew80 kernel: smb_add_request: request [c19db180, mid=56770] timed out!
Jan  9 10:26:03 pcew80 kernel: smb_add_request: request [c19db280, mid=56771] timed out!
Jan  9 10:26:08 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56772] timed out!
Jan  9 10:26:27 pcew80 kernel: smb_add_request: request [c19db080, mid=56773] timed out!
Jan  9 10:26:33 pcew80 kernel: smb_add_request: request [c19db280, mid=56774] timed out!
Jan  9 10:26:33 pcew80 kernel: smb_lookup: find lib_bcb6/,WSSInterface_RTP.lib, failed, error=-5
Jan  9 10:26:38 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56775] timed out!
Jan  9 10:26:38 pcew80 kernel: smb_lookup: find R/runtime failed, error=-5
Jan  9 10:27:02 pcew80 kernel: smb_add_request: request [c19db180, mid=56776] timed out!
Jan  9 10:27:03 pcew80 kernel: smb_add_request: request [c19db280, mid=56777] timed out!
Jan  9 10:27:08 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56778] timed out!
Jan  9 10:27:33 pcew80 kernel: smb_add_request: request [c19db280, mid=56779] timed out!
Jan  9 10:27:37 pcew80 kernel: smb_add_request: request [c19db080, mid=56780] timed out!
Jan  9 10:27:38 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56781] timed out!
Jan  9 10:27:38 pcew80 kernel: smb_lookup: find rcs_root/R failed, error=-5
Jan  9 10:28:08 pcew80 kernel: smb_add_request: request [c19dbe80, mid=56782] timed out!
Jan  9 10:28:08 pcew80 kernel: smb_lookup: find rcs_root/R failed, error=-5
Jan  9 10:28:08 pcew80 kernel: smb_add_request: request [c19db080, mid=56783] timed out!
Jan  9 10:28:12 pcew80 kernel: smb_add_request: request [c19db180, mid=56784] timed out!
Jan  9 10:28:17 pcew80 kernel: smb_get_length: Invalid NBT packet, code=4d
Jan  9 10:28:38 pcew80 kernel: smb_add_request: request [c19db080, mid=56785] timed out!
Jan  9 10:28:38 pcew80 kernel: smb_lookup: find //rcs_root failed, error=-5
Jan  9 10:28:47 pcew80 kernel: smb_add_request: request [c19db380, mid=56786] timed out!
Jan  9 10:29:23 pcew80 kernel: smb_proc_readdir_long: error=-512, breaking
Jan  9 10:37:59 pcew80 nmbd[1011]: [2004/01/09 10:37:59, 0] nmbd/nmbd.c:terminate(54)
Jan  9 10:37:59 pcew80 nmbd[1011]:   Got SIGTERM: going down...
Jan  9 15:12:10 pcew80 kernel: smb_add_request: request [dd47c080, mid=9767] timed out!
Jan  9 15:12:10 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 15:12:41 pcew80 kernel: smb_add_request: request [dd47c080, mid=23077] timed out!
Jan  9 15:12:41 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 15:13:12 pcew80 kernel: smb_add_request: request [dd47c080, mid=34144] timed out!
Jan  9 15:13:12 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 15:13:42 pcew80 kernel: smb_add_request: request [dd47c080, mid=44446] timed out!
Jan  9 15:13:42 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 15:14:15 pcew80 kernel: smb_add_request: request [dd47c080, mid=57300] timed out!
Jan  9 15:14:15 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 15:14:49 pcew80 kernel: smb_add_request: request [dd47c080, mid=14143] timed out!
Jan  9 15:14:49 pcew80 kernel: smb_writepage_sync: failed write, wsize=4096, result=-5
Jan  9 15:26:15 pcew80 kernel: smb_add_request: request [dce8f080, mid=10126] timed out!
Jan  9 15:26:15 pcew80 kernel: smb_proc_readdir_long: error=-5, breaking
Jan  9 15:26:35 pcew80 kernel: smb_get_length: Invalid NBT packet, code=1b
Jan  9 15:26:36 pcew80 kernel: smb_errno: class ERRSRV, code 91 from command 0x4
Jan  9 15:27:05 pcew80 kernel: smb_add_request: request [dce8f080, mid=22299] timed out!
Jan  9 15:27:05 pcew80 kernel: smb_proc_readdir_long: error=-5, breaking
Jan  9 15:27:51 pcew80 kernel: smb_add_request: request [dce8fd80, mid=28394] timed out!
Jan  9 15:27:51 pcew80 kernel: smb_proc_readdir_long: error=-5, breaking
Jan  9 15:28:05 pcew80 kernel: smbiod_handle_request: smbiod got a request ... and we don't implement oplocks!
Jan  9 15:28:05 pcew80 kernel: smb_get_length: Invalid NBT packet, code=73
Jan  9 15:28:06 pcew80 kernel: smb_errno: class ERRSRV, code 91 from command 0x4
Jan  9 15:28:35 pcew80 kernel: smb_add_request: request [dce8fd80, mid=40492] timed out!
Jan  9 15:29:20 pcew80 kernel: smb_add_request: request [dce8fd80, mid=52316] timed out!
Jan  9 15:29:20 pcew80 kernel: smb_proc_readdir_long: error=-5, breaking
Jan  9 15:30:03 pcew80 kernel: smb_add_request: request [dce8fd80, mid=3439] timed out!
Jan  9 15:30:03 pcew80 kernel: smb_lookup: find opsw/tpc failed, error=-5
Jan  9 15:30:39 pcew80 kernel: smb_add_request: request [dce8fd80, mid=18429] timed out!
Jan  9 15:30:39 pcew80 kernel: smb_proc_readdir_long: error=-5, breaking
Jan  9 15:32:01 pcew80 kernel: smb_add_request: request [dce8fd80, mid=39840] timed out!
Jan  9 15:32:01 pcew80 kernel: smb_proc_readdir_long: error=-5, breaking
Jan  9 15:33:56 pcew80 kernel: smb_add_request: request [dce8f080, mid=4434] timed out!
Jan  9 15:33:56 pcew80 kernel: smb_open: resource/symb_830.bmp,v open failed, result=-5
Jan  9 15:34:31 pcew80 kernel: smb_add_request: request [dce8fd80, mid=14310] timed out!
Jan  9 15:35:06 pcew80 kernel: smb_add_request: request [dce8fd80, mid=24554] timed out!
Jan  9 15:35:06 pcew80 kernel: smb_lookup: find omniORB/omniORB-4.0.2 failed, error=-5
Jan  9 15:35:38 pcew80 kernel: smb_add_request: request [dce8f080, mid=33501] timed out!
Jan  9 15:35:38 pcew80 kernel: smb_open: include/EVOEditGraphObjectSubscriberUnit.h,v open failed, result=-5
Jan  9 15:36:06 pcew80 kernel: smb_add_request: request [dce8fc80, mid=45541] timed out!
Jan  9 15:36:09 pcew80 kernel: smb_add_request: request [dce8f080, mid=47221] timed out!
Jan  9 15:36:42 pcew80 kernel: smb_add_request: request [dce8f080, mid=60123] timed out!
Jan  9 15:37:28 pcew80 kernel: smb_add_request: request [dce8fd80, mid=14246] timed out!
Jan  9 15:37:28 pcew80 kernel: smb_open: Compiled/EVOFramework-Demo-Introduction_26.au,v open failed, result=-5
Jan  9 15:37:59 pcew80 kernel: smb_add_request: request [dce8f080, mid=25651] timed out!
Jan  9 15:38:29 pcew80 kernel: smb_add_request: request [dce8f080, mid=38454] timed out!
Jan  9 15:38:34 pcew80 kernel: smb_add_request: request [dce8fc80, mid=40444] timed out!
Jan  9 15:38:34 pcew80 kernel: smb_lookup: find LinkLNAInitFrame/,LinkLNAInitFrameUnit.cpp, failed, error=-5
Jan  9 15:39:00 pcew80 kernel: smb_add_request: request [dce8f080, mid=49811] timed out!
Jan  9 15:39:00 pcew80 kernel: smb_open: include/Meteo_Tx.h,v open failed, result=-5
Jan  9 15:39:00 pcew80 kernel: smb_get_length: Invalid NBT packet, code=74
Jan  9 15:39:31 pcew80 kernel: smb_add_request: request [dce8fb80, mid=8510] timed out!
Jan  9 15:42:55 pcew80 kernel: smb_add_request: request [dce8fe80, mid=8511] timed out!
Jan  9 15:53:07 pcew80 kernel: smb_delete_inode: could not close inode 201156
Jan  9 15:53:07 pcew80 kernel: smb_lookup: find LinkLNAInitFrame/,LinkLNAInitFrameUnit.cpp, failed, error=-4
Jan  9 15:54:05 pcew80 kernel: smb_lookup: find common/opsw failed, error=-4
Jan  9 15:57:00 pcew80 kernel: smb_add_request: request [dce8f980, mid=8513] timed out!
Jan  9 15:57:30 pcew80 kernel: smb_add_request: request [dce8f980, mid=8514] timed out!
Jan  9 15:58:00 pcew80 kernel: smb_add_request: request [dce8f980, mid=8515] timed out!
Jan  9 15:58:00 pcew80 kernel: smb_lookup: find cm_tools/copy_label.pl failed, error=-5
Jan  9 15:58:30 pcew80 kernel: smb_add_request: request [dce8f980, mid=8516] timed out!
Jan  9 15:58:30 pcew80 kernel: smb_lookup: find cm_tools/copy_label.pl failed, error=-5
Jan  9 15:59:01 pcew80 kernel: smb_add_request: request [dce8fd80, mid=8517] timed out!
Jan  9 15:59:31 pcew80 kernel: smb_add_request: request [dce8fd80, mid=8518] timed out!
Jan  9 16:00:01 pcew80 kernel: smb_add_request: request [dce8fd80, mid=8519] timed out!
Jan  9 16:00:31 pcew80 kernel: smb_add_request: request [dce8fd80, mid=8520] timed out!
Jan  9 16:00:31 pcew80 kernel: smb_lookup: find cm_tools/.copy_label.pl.swp failed, error=-5
Jan  9 16:01:53 pcew80 kernel: smb_lookup: find common/opsw failed, error=-4
Jan  9 16:05:31 pcew80 kernel: smb_add_request: request [dce8fa80, mid=8523] timed out!
Jan  9 16:05:48 pcew80 kernel: smb_lookup: find cm_tools/generate_diff_devLabel_head.pl failed, error=-512
Jan  9 16:10:27 pcew80 kernel: smb_add_request: request [dce8f980, mid=8525] timed out!
Jan  9 16:15:30 pcew80 kernel: smb_lookup: find //cm_tools failed, error=-512
Jan  9 16:15:30 pcew80 kernel: smb_lookup: find build_parser/update failed, error=-512
Jan  9 16:15:30 pcew80 kernel: smb_lookup: find bootserver/apt-build failed, error=-512
Jan  9 16:19:02 pcew80 kernel: smb_lookup: find //cm_tools failed, error=-512
Jan  9 16:19:02 pcew80 kernel: smb_lookup: find build_parser/update failed, error=-512
Jan  9 16:30:40 pcew80 kernel: smb_receive_header: short packet: 0
Jan  9 16:31:10 pcew80 kernel: smb_add_request: request [c6a16280, mid=14068] timed out!
Jan  9 16:31:10 pcew80 kernel: smb_add_request: request [c6a16080, mid=14069] timed out!
Jan  9 16:57:26 pcew80 kernel: smb_add_request: request [c7afa080, mid=385] timed out!
Jan  9 16:58:01 pcew80 kernel: smb_add_request: request [cf19be80, mid=386] timed out!
Jan  9 16:58:01 pcew80 kernel: smb_add_request: request [cf19bd80, mid=387] timed out!
Jan  9 16:58:31 pcew80 kernel: smb_add_request: request [cf19bd80, mid=388] timed out!
Jan  9 16:58:36 pcew80 kernel: smb_add_request: request [cf19b080, mid=389] timed out!
Jan  9 16:59:11 pcew80 kernel: smb_add_request: request [c4513e80, mid=390] timed out!
Jan  9 16:59:11 pcew80 kernel: smb_add_request: request [c4513d80, mid=391] timed out!
Jan  9 16:59:41 pcew80 kernel: smb_add_request: request [c4513d80, mid=392] timed out!
Jan  9 16:59:46 pcew80 kernel: smb_add_request: request [c4513080, mid=393] timed out!
Jan  9 17:00:21 pcew80 kernel: smb_add_request: request [c5d5ae80, mid=394] timed out!
Jan  9 17:00:21 pcew80 kernel: smb_add_request: request [c5d5ad80, mid=395] timed out!
Jan  9 17:00:39 pcew80 kernel: smb_add_request: request [c5d5a080, mid=396] timed out!
Jan  9 17:00:45 pcew80 nmbd[1048]: [2004/01/09 17:00:45, 0] nmbd/nmbd.c:terminate(54)
Jan  9 17:00:45 pcew80 nmbd[1048]:   Got SIGTERM: going down...
Jan  9 17:00:51 pcew80 kernel: smb_add_request: request [c5d5ad80, mid=397] timed out!
Jan  9 17:31:59 pcew80 nmbd[920]: [2004/01/09 17:31:59, 0] nmbd/nmbd.c:terminate(54)
Jan  9 17:31:59 pcew80 nmbd[920]:   Got SIGTERM: going down...

--=-M5pb+AxHSnxsFMGSD0OX--

