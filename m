Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270796AbRIAPDQ>; Sat, 1 Sep 2001 11:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270773AbRIAPDH>; Sat, 1 Sep 2001 11:03:07 -0400
Received: from imo-r06.mx.aol.com ([152.163.225.102]:17645 "EHLO
	imo-r06.mx.aol.com") by vger.kernel.org with ESMTP
	id <S270774AbRIAPC6>; Sat, 1 Sep 2001 11:02:58 -0400
From: Floydsmith@aol.com
Message-ID: <93.f9abf44.28c252b0@aol.com>
Date: Sat, 1 Sep 2001 11:03:12 EDT
Subject: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works in 2.4.4
To: linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now, I can get everything (my ide ls-120 and ide HP 8Gig tape) to work in 
2.2.18. I can also get both to work in 2.4.4 (and earlier 2.4.x) but only 
with what I believe is an unnecessay "workarround" - namely by configuring 
IDESCSI into the kernel (SCSI emulation) and then using boot param 
hdc=ide-scsi. However, I feel, that I should not have to do that with any 
kernel (that is, SCSI emulation should be optional for this device) because 
this was the case for 2.2.18.

If I try not to use SCSI emulation for all 2.4.x kernels (including:
Kernel 2.4.9-ac5 on  i686
then
ide-tape: ht0: I/O error, pc =  8, key =  5, asc = 2c, ascq =  0
tar: /dev/ht0: Cannot read: Input/output error
(writes work OK though)

As mentioned above, scsi emulation works for 2.4.4 (reads and writes). But if 
turned on in 2.4.9-ac5, then I get
/dev/st0: No such device
So, with kernels above 2.4.4, I can't use the drive at all (or at least can't 
"read" with it which makes it useless).

The ideal situtation (at least for me) would be to have 2.4.x  kernels behave 
like the 2.2.x ones, that is, scsi emulation would not need to be turned on 
for these ide drives (that is, it would be optional) and I would go back to 
using /dev/ht0.

Floyd,
