Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbUCRScU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUCRScT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:32:19 -0500
Received: from main.gmane.org ([80.91.224.249]:23193 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262855AbUCRSa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:30:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Edd Dumbill <edd@usefulinc.com>
Subject: Re: problem with sbp2 / ieee1394 in kernel 2.6.3
Date: Thu, 18 Mar 2004 18:03:10 +0000
Message-ID: <1079632990.11136.30.camel@saag>
References: <1079406471.5971.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: starway.heddley.com
In-Reply-To: <1079406471.5971.20.camel@localhost.localdomain>
X-Mailer: Ximian Evolution 1.5.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-15 at 20:07 -0700, Bob Gill wrote:
> Hi.  I occasionally had problems like you describe 'sbp2 aborting
> request', but on my system sbp2 would always recover.  All I would see
> were a delay in data access, and an entry in /var/log/messages.  There
> were a lot of changes to ieee1394 between 2.6.3 and 2.6.4, and haven't
> seen sbp2 fail since (two or three patches) before 2.6.4.  Try the 2.6.4
> kernel (or newer) and see if that helps.

I'm also seeing the same errors on 2.6.4  (XP 2800+, nForce2 chipset)
with a Lacie external firewire drive.  The drive used to work OK on my
2.4.18 powerpc box.


Mar 17 13:17:49 starway kernel: sbp2: $Rev: 1170 $ Ben Collins
<bcollins@debian.org>
Mar 17 13:17:49 starway kernel: scsi2 : SCSI emulation for IEEE-1394
SBP-2 Devices
Mar 17 13:17:49 starway kernel: ieee1394: sbp2: Logged into SBP-2 device
Mar 17 13:17:49 starway kernel: ieee1394: sbp2: Node 0-00:1023: Max
speed [S400] - Max payload [2048]
Mar 17 13:17:49 starway kernel:   Vendor: IC35L080  Model: AVVA07-0
Rev: VA4O
Mar 17 13:17:49 starway kernel:   Type:   Direct-Access
ANSI SCSI revision: 06
Mar 17 13:17:49 starway kernel: SCSI device sdc: 160836480 512-byte hdwr
sectors (82348 MB)
Mar 17 13:17:49 starway kernel: sdc: asking for cache data failed
Mar 17 13:17:49 starway kernel: sdc: assuming drive cache: write through
Mar 17 13:17:49 starway kernel:  sdc: sdc1
Mar 17 13:17:49 starway kernel: Attached scsi disk sdc at scsi2, channel
0, id 0
Mar 17 13:17:49 starway kernel: Attached scsi generic sg2 at scsi2,
channel 0, id 0, lun 0,  type 0

....

Mar 17 15:38:22 starway kernel: ieee1394: sbp2: aborting sbp2 command
Mar 17 15:38:22 starway kernel: Read (10) 00 06 fe f4 ff 00 00 08 00
Mar 17 15:38:22 starway kernel: ieee1394: sbp2: aborting sbp2 command
Mar 17 15:38:22 starway kernel: Read (10) 00 06 fe f5 0f 00 00 08 00
Mar 17 15:38:22 starway kernel: ieee1394: sbp2: aborting sbp2 command
Mar 17 15:38:22 starway kernel: Read (10) 00 06 fe f5 1f 00 00 08 00
Mar 17 15:38:22 starway kernel: ieee1394: sbp2: aborting sbp2 command
Mar 17 15:38:22 starway kernel: Read (10) 00 06 fe f5 2f 00 00 08 00
Mar 17 15:38:22 starway kernel: ieee1394: sbp2: aborting sbp2 command
Mar 17 15:38:22 starway kernel: Read (10) 00 06 fe f5 3f 00 00 08 00
Mar 17 15:38:22 starway kernel: ieee1394: sbp2: aborting sbp2 command
Mar 17 15:38:22 starway kernel: Read (10) 00 06 fe f5 4f 00 00 08 00
Mar 17 15:38:22 starway kernel: ieee1394: sbp2: aborting sbp2 command
Mar 17 15:38:22 starway kernel: Read (10) 00 06 fe f5 5f 00 00 08 00
Mar 17 15:38:22 starway kernel: ieee1394: sbp2: aborting sbp2 command

-- Edd



