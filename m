Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSGUCnc>; Sat, 20 Jul 2002 22:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSGUCnc>; Sat, 20 Jul 2002 22:43:32 -0400
Received: from due.stud.ntnu.no ([129.241.56.71]:28076 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S317622AbSGUCn3>;
	Sat, 20 Jul 2002 22:43:29 -0400
Date: Sun, 21 Jul 2002 04:46:33 +0200
From: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.4.18 and 2.4.19 problems
Message-ID: <20020721024633.GA22280@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
References: <20020719192607.GA13880@stud.ntnu.no> <20020719140416.A25577@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719140416.A25577@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield:
> Also, cat /proc/scsi/scsi and /proc/scsi/qla*/[0-9] and see what they show.

test3:~# cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DELL     Model: PERCRAID Mirror  Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: CNSi     Model: G7324            Rev: L400
  Type:   Direct-Access                    ANSI SCSI revision: 03

test3:~# cat /proc/scsi/qla2200/1 
QLogic PCI to Fibre Channel Host Adapter for ISP2100/ISP2200/ISP2200A:
        Firmware version:  2.01.35, Driver version 5.31.RH1
Entry address = f8955060
HBA: QLA2200 , Serial# B50409
Request Queue = 0x36300000, Response Queue = 0x36ddc000
Request Queue count= 512, Response Queue count= 64
Number of pending commands = 0x0
Number of queued commands = 0x0
Number of free request entries = 494
Number of mailbox timeouts = 0
Number of ISP aborts = 0
Number of loop resyncs = 0
Number of retries for empty slots = 0
Number of reqs in retry_q = 0
Number of reqs in done_q = 0
Number of pending in_q reqs = 0
Host adapter: state = UP, flags= 0x20a0837


SCSI Device Information:
scsi-qla0-adapter-node=200000e08b02894b;
scsi-qla0-adapter-port=210000e08b02894b;
scsi-qla0-port-0=1000005013d01808:2000005013d01808;
scsi-qla0-port-1=1000005013d016d3:2000005013d016d3;
scsi-qla0-port-2=1000005013d0158d:2000005013d0158d;
scsi-qla0-port-3=1000005013d0154b:2000005013d0154b;

SCSI LUN Information:
(Id:Lun)
( 3: 0): Total reqs 12, Pending 0, Queued 0, full 0, flags 0x0, 0:0:82,

test3:~# cat /proc/scsi/qla2200/2 
QLogic PCI to Fibre Channel Host Adapter for ISP2100/ISP2200/ISP2200A:
        Firmware version:  2.01.35, Driver version 5.31.RH1
Entry address = f8955060
HBA: QLA2200 , Serial# B50405
Request Queue = 0x362e0000, Response Queue = 0x36d86000
Request Queue count= 512, Response Queue count= 64
Number of pending commands = 0x0
Number of queued commands = 0x0
Number of free request entries = 508
Number of mailbox timeouts = 0
Number of ISP aborts = 0
Number of loop resyncs = 0
Number of retries for empty slots = 0
Number of reqs in retry_q = 0
Number of reqs in done_q = 0
Number of pending in_q reqs = 0
Host adapter: state = UP, flags= 0x20a0837


SCSI Device Information:
scsi-qla1-adapter-node=200000e08b02854b;
scsi-qla1-adapter-port=210000e08b02854b;
scsi-qla1-port-0=1000005013d01808:2000005013d01808;
scsi-qla1-port-1=1000005013d016d3:2000005013d016d3;
scsi-qla1-port-2=1000005013d0158d:2000005013d0158d;
scsi-qla1-port-3=1000005013d0154b:2000005013d0154b;

SCSI LUN Information:
(Id:Lun)


Both controllers should find a disk now, really, but they don't.
Swapping to a newer version of the driver (6.0beta or 6.1beta)
will make it find one drive on each HBA, I'll do that tomorrow
along with logging stuff.

-- 
Thomas
