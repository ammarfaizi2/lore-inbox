Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSHVWbF>; Thu, 22 Aug 2002 18:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSHVWbE>; Thu, 22 Aug 2002 18:31:04 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:27777 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S317611AbSHVWbE>; Thu, 22 Aug 2002 18:31:04 -0400
Date: Thu, 22 Aug 2002 18:39:16 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.31 qlogic error "this should not happen"
Message-ID: <20020822223916.GA460@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running bonnie++ with 2.5.31 and 2.5.31-mm1,
a quad xeon with QLogic Corp. QLA2200 (rev 05)
stopped responding.  These were the last lines
in /var/log/messages before the box was rebooted.

kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 7d
kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 18
kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 33
kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 33
kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 69
kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 69
kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 4
kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 1f
kernel: qlogicfc0 : no handle slots, this should not happen.
kernel: hostdata->queued is 6, in_ptr: 3a

This is the qlogic config:
# CONFIG_SCSI_QLOGIC_FAS is not set
CONFIG_SCSI_QLOGIC_ISP=y
CONFIG_SCSI_QLOGIC_FC=y
# CONFIG_SCSI_QLOGIC_FC_FIRMWARE is not set
# CONFIG_SCSI_QLOGIC_1280 is not set

The same config works fine on 2.4.

Anyone know if the newer qlogic driver compatible with 2.5?
http://marc.theaimsgroup.com/?l=linux-kernel&m=102919565520122&w=2

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

