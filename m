Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRA0BY4>; Fri, 26 Jan 2001 20:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbRA0BYh>; Fri, 26 Jan 2001 20:24:37 -0500
Received: from mail.wave.co.nz ([203.96.216.11]:8256 "EHLO mail.wave.co.nz")
	by vger.kernel.org with ESMTP id <S129393AbRA0BYf>;
	Fri, 26 Jan 2001 20:24:35 -0500
Date: Sat, 27 Jan 2001 14:24:32 +1300
From: Mark van Walraven <markv@wave.co.nz>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
Message-ID: <20010127142432.B29823@mail.wave.co.nz>
Mail-Followup-To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.32.0101261611300.791-100000@asdf.capslock.lan> <000d01c087ed$82ffb950$0201010a@runestig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <000d01c087ed$82ffb950$0201010a@runestig.com>; from Peter 'Luna' Runestig on Sat, Jan 27, 2001 at 12:12:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 12:12:53AM +0100, Peter 'Luna' Runestig wrote:
> In what situation would NT4 default to "fry the whole disk"? I've mixed
> Linux/DOS/Win98/NT4/Win2000 several ways on various hardware (>8 GB disks),
> with no problems at all actually.

I've had Windows suddenly using the 'begin' and 'end' (CHS) fields in
the partition table entry for a FAT32 partition when it should have been
using 'start' and 'length' (LBA) fields.  The result was that everything
on the FAT32 partition disappeared (according to Windows) and a couple
of block groups in an ext2 partition were clobbered.

Another time, I found what looked like bits of the page file in the
middle of a wrong partition when swapping onto the second disk.

Two associates have had ext2 partitions partially overwritten by
re-installing Win98.

>                                   Maybe "one single person having a problem
> does not mean in any way that this is the way it occurs for 100% of the
> userbase" ?

All the problems in the thread smell like geometry problems to me.  I
never experienced one myself until I got an evil combination of disk,
BIOS and filesystem.  Then, ZAP!

Regards,

Mark.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
