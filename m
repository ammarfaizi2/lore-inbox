Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbUCSWDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUCSWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:03:07 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:17427 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S263012AbUCSWDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:03:03 -0500
Date: Fri, 19 Mar 2004 23:03:47 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Firewire broken in 2.6.4 (detects disk but times out mounting)
Message-ID: <20040319220347.GA10539@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's what happens:

Mar 19 22:00:47 hellhound ieee1394: sbp2: Logged into SBP-2 device
Mar 19 22:00:47 hellhound ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
Mar 19 22:00:47 hellhound Vendor: Maxtor    Model: 5000DV            Rev: 0100
Mar 19 22:00:47 hellhound Type:   Direct-Access                      ANSI SCSI revision: 06
Mar 19 22:00:47 hellhound SCSI device sda: 490232832 512-byte hdwr sectors (250999 MB)
Mar 19 22:00:47 hellhound sda: asking for cache data failed
Mar 19 22:00:47 hellhound sda: assuming drive cache: write through
Mar 19 22:00:47 hellhound /dev/scsi/host0/bus0/target1/lun0: p1
Mar 19 22:00:47 hellhound Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Mar 19 22:00:47 hellhound ip1394: $Rev: 1175 $ Ben Collins <bcollins@debian.org>
Mar 19 22:00:47 hellhound ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[...]
Mar 19 22:01:21 hellhound ieee1394: sbp2: aborting sbp2 command
Mar 19 22:01:21 hellhound 0x28 00 00 00 00 3f 00 00 01 00 
Mar 19 22:01:31 hellhound ieee1394: sbp2: aborting sbp2 command
Mar 19 22:01:31 hellhound 0x00 00 00 00 00 00 
Mar 19 22:01:31 hellhound ieee1394: sbp2: reset requested
Mar 19 22:01:31 hellhound ieee1394: sbp2: Generating sbp2 fetch agent reset
Mar 19 22:01:41 hellhound ieee1394: sbp2: aborting sbp2 command
Mar 19 22:01:41 hellhound 0x00 00 00 00 00 00 
Mar 19 22:01:41 hellhound ieee1394: sbp2: reset requested
Mar 19 22:01:41 hellhound ieee1394: sbp2: Generating sbp2 fetch agent reset
Mar 19 22:02:01 hellhound ieee1394: sbp2: aborting sbp2 command
Mar 19 22:02:01 hellhound 0x00 00 00 00 00 00 
Mar 19 22:02:01 hellhound ieee1394: sbp2: reset requested
Mar 19 22:02:01 hellhound ieee1394: sbp2: Generating sbp2 fetch agent reset
Mar 19 22:02:21 hellhound ieee1394: sbp2: aborting sbp2 command
Mar 19 22:02:21 hellhound 0x00 00 00 00 00 00 
Mar 19 22:02:21 hellhound scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 1 lun 0
Mar 19 22:02:21 hellhound SCSI error : <0 0 1 0> return code = 0x50000
Mar 19 22:02:21 hellhound end_request: I/O error, dev sda, sector 63
Mar 19 22:02:21 hellhound FAT: unable to read boot sector


Any idea?  It is not a general read failure since reading the partition table
worked.  This is on a VIA Athlon XP board.

Felix
