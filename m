Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267134AbTGTN1n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 09:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267140AbTGTN1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 09:27:43 -0400
Received: from [64.202.100.31] ([64.202.100.31]:64775 "EHLO
	r3y.servercentral.net") by vger.kernel.org with ESMTP
	id S267134AbTGTN1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 09:27:37 -0400
Subject: Enabling SCSI emulation in 2.6 kernel causes lockups.
From: Andrew Thompson <vagabond@raven-games.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1058708549.13241.11.camel@vagabond>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Jul 2003 14:42:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing around with the latest dev kernels and I've had a
strange problem where linux locks up after about 10 minutes of use in
Xfree. I first noticed this problem in 2.5.75 and I've also experienced
it with 2.6 test1 and 2.6 test1-mm1 with and without the O7int patch.

Basically what happens is the audio in playing starts looping, the LED
that indicates disk activity stays on constantly and the computer stops
responding. 

By removing all superfluous kernel options and gradually adding them
again I've narrowed down the cause to SCSI emulation for ATAPI CD
burners. I can enable basic SCSI support without a problem but if I
enable the SCSI emulation, the SCSI Cd-Rom support and the generic SCSI
support the kernel locks up as reported above. I haven't tried each of
those options separately (crashing linux repeatedly and having to
recompile the kernel the whole time is a PITA) but I'm willing to do
that if anyone thinks it would be useful.

My current system is an ASUS A7M266-D with 1024 megs of ram, a SB-Live
card running with the OSS drivers and a Geforce 2 Ti 500 using the
nvidia kernel module.

If any more information is required please ask me.

TIA,

Andrew Thompson.

