Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUBKNWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 08:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUBKNWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 08:22:47 -0500
Received: from palrel10.hp.com ([156.153.255.245]:7844 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263661AbUBKNWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 08:22:16 -0500
Reply-To: <vanami@india.hp.com>
From: "veeresh" <vanami@india.hp.com>
To: "'Andrew Vasquez'" <praka@users.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: "SAIDU BUHARI (HP-India,ex2) (E-mail)" <saidu.buhari@hp.com>
Subject: RE: Kernel panic on Redhat Linux AS2.1 with QLogic 2342 HBA
Date: Wed, 11 Feb 2004 18:51:56 +0530
Message-ID: <00de01c3f0a2$073c8200$3bda4c0f@nt21859>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00DF_01C3F0D0.20F707F0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <20040210182513.GA114@praka.local.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00DF_01C3F0D0.20F707F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thanks for your quick response..

Yes, the software prepares SCSI commands and sends them down via generic
device driver SG. In our case the device file for related to device
connected(LTO-2 FC interface tape drive) is "/dev/sg0".
I have logged list of CDB the software sends to a device using SG driver and
the attached the same. The log shows that the last CDB was Receive
diagnostic command. I ran multiple times the software, but the SCSI command
that failed was the same.

Please let me know if you need any information.

Best regards,
Veeresh

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Andrew Vasquez
Sent: Tuesday, February 10, 2004 11:55 PM
To: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
Cc: veeresh
Subject: Re: Kernel panic on Redhat Linux AS2.1 with QLogic 2342 HBA


On Tue, 10 Feb 2004, veeresh wrote:

> Kernel panic information:
> kernel BUG at /usr/src/linux-2.4/include/asm/pci.h:145!
> invalid operand: 0000
> Kernel 2.4.9-e.25smp
> CPU: 2
> EIP: 0010:[<f8891658>] Tainted: P
> EFLAGS: 00010086
> EIP is at qla2x00_64bit_start_scsi [qla2300] 0x498

One of the scatter-gather entries of a SCSI command was NULL.  Is any
of the software you are running preparing SCSI commands and sending
them down via SG perhaps?  What type of I/O is occuring when the
failure occurs?

Regards,
Andrew Vasquez
QLogic Corporation
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_00DF_01C3F0D0.20F707F0
Content-Type: application/octet-stream;
	name="CDB.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="CDB.log"

Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
Before third ioctl
Third ioctl is successful
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->6
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->29
sensebuf[13]-->3
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->e5
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Before calling first ioctl
First ioctl is successful
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
Before third ioctl
Third ioctl is successful
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->2
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->3a
sensebuf[13]-->0
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->6b
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
UnSuccessful TUR Cmd
Before calling first ioctl
First ioctl is successful
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221137512
CDB[0]-->#12
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#40
CDB[5]-->#0
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->6
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->29
sensebuf[13]-->3
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->e5
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->2
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->3a
sensebuf[13]-->0
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->6b
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221137944
CDB[0]-->#12
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#40
CDB[5]-->#0
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
Before third ioctl
Third ioctl is successful
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->2
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->3a
sensebuf[13]-->0
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->6b
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
Before third ioctl
Third ioctl is successful
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->2
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->3a
sensebuf[13]-->0
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->6b
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221132156
CDB[0]-->#12
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#40
CDB[5]-->#0
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->2
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->3a
sensebuf[13]-->0
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->6b
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->2
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->3a
sensebuf[13]-->0
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->6b
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221128232
CDB[0]-->#12
CDB[1]-->#1
CDB[2]-->#80
CDB[3]-->#0
CDB[4]-->#4
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221128508
CDB[0]-->#12
CDB[1]-->#1
CDB[2]-->#c0
CDB[3]-->#0
CDB[4]-->#4
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221128508
CDB[0]-->#12
CDB[1]-->#1
CDB[2]-->#c1
CDB[3]-->#0
CDB[4]-->#4
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:151844088
CDB[0]-->#12
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#5c
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:152317528
CDB[0]-->#12
CDB[1]-->#1
CDB[2]-->#80
CDB[3]-->#0
CDB[4]-->#e
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:152500248
CDB[0]-->#12
CDB[1]-->#1
CDB[2]-->#c0
CDB[3]-->#0
CDB[4]-->#60
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:151813688
CDB[0]-->#12
CDB[1]-->#1
CDB[2]-->#c1
CDB[3]-->#0
CDB[4]-->#60
CDB[5]-->#0
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->2
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->3a
sensebuf[13]-->0
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->6b
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Data Direction:SG_DXFER_NONE
Data buffer address:0
CDB[0]-->#0
CDB[1]-->#0
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
sensebuf[0]-->70
sensebuf[1]-->0
sensebuf[2]-->2
sensebuf[3]-->0
sensebuf[4]-->0
sensebuf[5]-->0
sensebuf[6]-->0
sensebuf[7]-->e
sensebuf[8]-->0
sensebuf[9]-->0
sensebuf[10]-->0
sensebuf[11]-->0
sensebuf[12]-->3a
sensebuf[13]-->0
sensebuf[14]-->0
sensebuf[15]-->0
sensebuf[16]-->2c
sensebuf[17]-->6b
sensebuf[18]-->0
sensebuf[19]-->0
sensebuf[20]-->0
sensebuf[21]-->0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221127360
CDB[0]-->#3c
CDB[1]-->#3
CDB[2]-->#11
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
CDB[6]-->#0
CDB[7]-->#0
CDB[8]-->#4
CDB[9]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221127360
CDB[0]-->#3c
CDB[1]-->#3
CDB[2]-->#12
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
CDB[6]-->#0
CDB[7]-->#0
CDB[8]-->#4
CDB[9]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221127360
CDB[0]-->#3c
CDB[1]-->#3
CDB[2]-->#13
CDB[3]-->#0
CDB[4]-->#0
CDB[5]-->#0
CDB[6]-->#0
CDB[7]-->#0
CDB[8]-->#4
CDB[9]-->#0
Data Direction:SG_DXFER_TO_DEV
Data buffer address:142959164
CDB[0]-->#1d
CDB[1]-->#1
CDB[2]-->#0
CDB[3]-->#0
CDB[4]-->#8
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:151416608
CDB[0]-->#1c
CDB[1]-->#0
CDB[2]-->#93
CDB[3]-->#0
CDB[4]-->#90
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221127980
CDB[0]-->#1c
CDB[1]-->#1
CDB[2]-->#a5
CDB[3]-->#0
CDB[4]-->#4
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221127968
CDB[0]-->#1c
CDB[1]-->#1
CDB[2]-->#a5
CDB[3]-->#0
CDB[4]-->#4
CDB[5]-->#0
Data Direction:SG_DXFER_FROM_DEV
Data buffer address:3221127980
CDB[0]-->#1c
CDB[1]-->#1
CDB[2]-->#84
CDB[3]-->#0
CDB[4]-->#4
CDB[5]-->#0
Before third ioctl

------=_NextPart_000_00DF_01C3F0D0.20F707F0--

