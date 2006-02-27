Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWB0NFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWB0NFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 08:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWB0NFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 08:05:36 -0500
Received: from mxout5.netvision.net.il ([194.90.9.29]:54121 "EHLO
	mxout5.netvision.net.il") by vger.kernel.org with ESMTP
	id S1751184AbWB0NFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 08:05:35 -0500
Date: Mon, 27 Feb 2006 15:05:26 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: problems with scsi_transport_fc and qla2xxx
To: linux-kernel@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <1413265398.20060227150526@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm checking 2.6.16-rc5 with 2 QLogic 2312 adapters using qla2xxx
driver from 2.6.16-rc5.
As with earlier kernels, I think > 2.6.12 (since scsi_transport_fc
gained functionality) I have the following problem.
2 scsi hosts available, 4 and 5 (for QLogic).
I disconnect the cable from one of QLogic cards. After timeout I have
the message
rport-4:0-0: blocked FC remote port time out: removing target and saving binding
and appropriate SCSI devices that came from adapter 4 disappear from
/proc/scsi/scsi.
So far, so good.
I reconnect the cable, the directory
/sys/class/fc_remote_ports/rport-4:0-1 appears along with the old
ones rport-4:0-0 and rport-5:0-0, so currently I have 3.
However, no automatic rescan appears on adapter 4.
What's worse, if I try echo "0 1 0" > /sys/class/scsi_host/host4/scan
the process is stuck.
Please advise.

Thanks,

Maxim.

