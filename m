Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUIFXcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUIFXcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 19:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUIFXcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 19:32:41 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:48718 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267475AbUIFXcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 19:32:07 -0400
Message-ID: <413CF375.6020402@blueyonder.co.uk>
Date: Tue, 07 Sep 2004 00:32:05 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc1-mm3 IDE cdrom bug 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Sep 2004 23:32:30.0402 (UTC) FILETIME=[C6FAD220:01C49469]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems all 2.6.9-rc1 kernels give this error ending up with the mount 
in D state, up to -bk13. Everything works fine on 2.6.8-rc4-mm1 on the 
Asus A7N8X-E, so I need to go back and find out exactly where it broke, 
I hadn't used the CDROM/DVD's in quite a while.
On the Acer 1501LCe x86_64 I get Drive Seek Incomplete errors, hdparm 
says Using DMA=1, but the mount gives a D process now, whereas it worked 
flawlessly before, suspect I may have a bad drive.
Sep  7 00:26:32 Boycie kernel: hdc: cdrom_decode_status: status=0x51 { 
DriveReady SeekComplete Error }
Sep  7 00:26:32 Boycie kernel: hdc: cdrom_decode_status: 
error=0x40LastFailedSense 0x04
Sep  7 00:26:32 Boycie kernel: hdc: command error: status=0x51 { 
DriveReady SeekComplete Error }
Sep  7 00:26:32 Boycie kernel: hdc: command error: error=0x52
Sep  7 00:26:32 Boycie kernel: ide: failed opcode was 100
Sep  7 00:26:32 Boycie kernel: end_request: I/O error, dev hdc, sector 64
Sep  7 00:26:32 Boycie kernel: Buffer I/O error on device hdc, logical 
block 8
Sep  7 00:26:32 Boycie automount[8536]: >> /dev/dvd: Input/output error
Sep  7 00:26:32 Boycie kernel: hdc: request sense failure: status=0x51 { 
DriveReady SeekComplete Error }
Sep  7 00:26:32 Boycie kernel: hdc: request sense failure: 
error=0xb0LastFailedSense 0x0b
Sep  7 00:26:32 Boycie kernel: hdc: packet command error: status=0x51 { 
DriveReady SeekComplete Error }
Sep  7 00:26:32 Boycie kernel: hdc: packet command error: error=0x40
Sep  7 00:26:32 Boycie kernel: ide: failed opcode was 100
Sep  7 00:26:32 Boycie kernel: hdc: request sense failure: status=0x51 { 
DriveReady SeekComplete Error }
Sep  7 00:26:32 Boycie kernel: hdc: request sense failure: 
error=0xb0LastFailedSense 0x0b

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

