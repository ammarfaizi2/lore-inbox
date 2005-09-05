Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVIENdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVIENdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVIENdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:33:24 -0400
Received: from smtp2.belwue.de ([129.143.2.15]:43653 "EHLO smtp2.BelWue.DE")
	by vger.kernel.org with ESMTP id S932138AbVIENdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:33:23 -0400
From: Oliver Tennert <O.Tennert@science-computing.de>
To: linux-kernel@vger.kernel.org
Subject: DVD+-R[W] regression in 2.6.12/13
Date: Mon, 5 Sep 2005 15:33:01 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051533.01465.tennert@science-computing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello together,

with my machine, an

"hdparm -I /dev/dvdrecorder" leads to the output:

/dev/dvdrecorder:
 HDIO_DRIVE_CMD(identify) failed: Input/output error

The kernel tells me:

[4296893.262000] hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[4296893.262000] hdd: drive_cmd: error=0x04 { AbortedCommand }
[4296893.262000] ide: failed opcode was: 0xec

This happens with 2.6.12 and 2.6.13. DMA works fine, though. And burning 
CDs/DVDs seems to work fine, too.

The same hdparm command to a "normal" CD or DVD ROM drive (no writer) does not 
produces any error messages, though.

So what does this strange opcode do, and why does it fail in the latest 
kernels?

/dev/dvdrecorder is a Plextor 708A, the error also occurs with a Plextor 716A.

Best regards

Oliver

-- 
The problem with engineers is that they tend to cheat in order to get
results.

The problem with mathematicians is that they tend to work on toy
problems in order to get results.

The problem with program verifiers is that they tend to cheat at toy
problems in order to get results.
--
__
________________________________________creating IT solutions

Dr. Oliver Tennert
Senior Solutions Engineer
CAx Professional Services
                                        science + computing ag
phone   +49(0)7071 9457-598             Hagellocher Weg 71-75	
fax     +49(0)7071 9457-411             D-72070 Tuebingen, Germany
O.Tennert@science-computing.de          www.science-computing.de


