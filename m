Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129403AbRBHXA2>; Thu, 8 Feb 2001 18:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRBHXAT>; Thu, 8 Feb 2001 18:00:19 -0500
Received: from pool-209-128-156-95.jon.ipa.net ([209.128.156.95]:64130 "EHLO
	BrightStar") by vger.kernel.org with ESMTP id <S129213AbRBHXAL>;
	Thu, 8 Feb 2001 18:00:11 -0500
Date: Thu, 8 Feb 2001 17:09:31 -0600
From: Michael Hobgood <mhobgood@inet-direct.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Mem detection problem
Message-ID: <20010208170931.A6890@inet-direct.com>
In-Reply-To: <3A82CEE6.9060204@lycosmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3A82CEE6.9060204@lycosmail.com>; from ajschrotenboer@lycosmail.com on Thu, Feb 08, 2001 at 11:52:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 11:52:54AM -0500, Adam Schrotenboer wrote:
> This is actually a repost of a problem that received few serious replies 
> (IMNSHO).
> 
> Basically 2.4.0 detects 192 MB(maybe 191, but big whoop) of memory. This 
> is correct. However, 2.4.1-ac6 (as did Linus-blessed 2.4.1) detects 64. 
> The problem is simple. 2.4.1 and later for some reason uses bios-88, 
> instead of e820.
> 
> Attached are the dmesgs from 2.4.0 and 2.4.1-ac6.

[snip]

Perhaps on your machine, but not on all.  Small amount of dmesg from mine.


Linux version 2.4.2-pre1 (root@BrightStar) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Feb 6 05:34:32 CST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 000000000000e800 @ 00000000000f1800 (reserved)
 BIOS-e820: 0000000011f00000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000e800 @ 00000000ffff1800 (reserved)
      ^^^^

On node 0 totalpages: 73728
zone(0): 4096 pages.
zone(1): 69632 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=242 ro root=342 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 334.098 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 666.82 BogoMIPS
Memory: 287948k/294912k available (953k kernel code, 6576k reserved, 319k data, 172k init, 0k highmem)
                ^^^^^^ the 294912k is correct

Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)

Cordially,
Michael Hobgood

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
