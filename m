Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTLPV10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbTLPV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:27:26 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:29621 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S262758AbTLPV1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:27:25 -0500
To: linux-kernel@vger.kernel.org
Subject: DV failed to configure device 
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Tue, 16 Dec 2003 16:27:24 -0500
Message-ID: <9cfhe00mp1f.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running 2.4.23 I get the following message from the aic7xxx driver
during boot:

scsi1:A:3:0: DV failed to configure device.  Please file a bug report against th
is driver.
(scsi1:A:3): 160.000MB/s transfers (80.000MHz DT, offset 31, 16bit)
  Vendor: JetStor   Model: III IDE           Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c7d74418, I/O limit 524287Mb (mask 0x7fffffffff)
  Vendor: JetStor   Model: III IDE           Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c7d74e18, I/O limit 524287Mb (mask 0x7fffffffff)
scsi1:A:3:0: Tagged Queuing enabled.  Depth 253
scsi1:A:3:1: Tagged Queuing enabled.  Depth 253
Attached scsi disk sdb at scsi1, channel 0, id 3, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 3, lun 1
SCSI device sdb: 2941353984 512-byte hdwr sectors (1505973 MB)
 sdb: sdb1
SCSI device sdc: 2451128320 512-byte hdwr sectors (1254978 MB)
 sdc: sdc1

(The key bit is the first line... the rest are hopefully enough
context to make it useful ;-)  This happens to be a RAID I have
attached to the HBA, a 39160, but I get this message with other,
smaller RAIDs as well.)

I am dutifully filing a bug report, but frankly I have no idea either
from the message or the driver README or the driver source if I should
actually care.  Should I?  What's DV, and how is the device not
configured?  It seems to work ok.

I sent mail to Justin Gibbs but never got a response.

Ian

