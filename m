Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbTJ3VL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTJ3VLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:11:25 -0500
Received: from [62.38.227.254] ([62.38.227.254]:8578 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S262887AbTJ3VLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:11:24 -0500
From: "P. Christeas" <p_christ@hol.gr> (by way of P. Christeas
	<p_christ@hol.gr>)
Date: Fri, 31 Oct 2003 00:12:47 +0200
User-Agent: KMail/1.5.3
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test9 breaks cdrecord w. ide-scsi device  
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310310012.47580.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just rebooted my long-running machine and now strongly suspect that it is a 
kernel bug:
I try to burn (dummy mode) 20 tracks of audio on a 'PIONEER DVD-RW  DVR-106D' 
drive.
At -test8 it would work (tested 4 times now, several with even older kernels).
On -test 9 I always (> 15 times tested) get the messages quoted.
The drive is on ide-scsi [M],  sg is built-in, sr is a module. Ask me anything 
else you may want me to try..


cdrecord 2.01.xx :
Track 01:   31 of   38 MB written (fifo 100%) [buf  90%]  19.8x.cdrecord:
 Input/output error. write_g1: scsi sendcmd: no error CDB:  2A 00 00 00 36 F3
 00 00 1B 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 04 00 D3 10 FA 0E 26 01 30 FE 08 01 00 00
Sense Key: 0x4 Hardware Error, Segment 0
Sense Code: 0x08 Qual 0x01 (logical unit communication time-out) Fru 0x0
Sense flags: Blk 13832442 (not valid)
cmd finished after 2.004s timeout 200s

write track data: error after 33085584 bytes
cdrecord: A write error occured.
cdrecord: Please properly read the error message above.
Writing  time:   28.974s
Average write speed 154.5x.
Min drive buffer fill was 79%
Fixating...


cdrecord 1.10:
Track 04:   1 of  33 MB written (fifo  98%).cdrecord.old: Input/output error.
 write_g1: scsi sendcmd: no error CDB:  2A 00 00 00 BE 9D 00 00 1B 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 04 00 D3 10 FA 0E 26 01 30 FE 08 01 00 00
Sense Key: 0x4 Hardware Error, Segment 0
Sense Code: 0x08 Qual 0x01 (logical unit communication time-out) Fru 0x0
Sense flags: Blk 13832442 (not valid)
cmd finished after 2.004s timeout 200s

write track data: error after 1460592 bytes
Sense Bytes: 70 00 00 00 00 00 00 0E 00 00 00 00 00 00 00 00 00 00
Writing  time:   57.892s
Fixating...

