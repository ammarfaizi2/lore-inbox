Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136042AbRD0OZP>; Fri, 27 Apr 2001 10:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136044AbRD0OZG>; Fri, 27 Apr 2001 10:25:06 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:2570 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S136042AbRD0OYu>; Fri, 27 Apr 2001 10:24:50 -0400
Date: Fri, 27 Apr 2001 10:24:10 -0400
From: Chris Mason <mason@suse.com>
To: jason <jason@lacan.dabney.caltech.edu>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic with 2.4.x and reiserfs
Message-ID: <217780000.988381450@tiny>
In-Reply-To: <Pine.LNX.4.10.10104270104010.7570-100000@lacan.dabney.caltech.edu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, April 27, 2001 02:40:50 AM -0700 jason
<jason@lacan.dabney.caltech.edu> wrote:

[ ouch ]

> 
> reiserfs_read_super: can't find reiserfs filesystem on dev 03:01
> Invalid session # or type of track
> Kernel panic: VFS: Unable to mount root fs on 03:01
> 
>   In case it's any help, I'm running Debian "sid" under kernel 2.4.3. hda
> is a Western Digital WD400 (UDMA 100) while hdc is a Maxtor 36.5 GB. I
> have a 900 Mhz Athlon on an Abit KT7A, the latter containing the South
> Bridge VIA VT82C686B and a North Bridge VIA VT8363A.
>   Any info on how I could possibly retrieve data from my disk (hda) would
> be greatly appreciated...
> 

Looks like you've hit the pot-luck of VIA problems, and elevator bugs
(2.4.1).  When the last crash hit, did you recycle with the power button or
the reset button?

Step one, if you can, get a backup of the raw device.  This will make
everything easier if there are problems in step 3.  

Step two, grab the latest reiserfsprogs from
ftp.reiserfs.org/pub/reiserfsprogs.

Step three, reiserfsck --rebuild-sb ; reiserfsck --rebuild-tree

Drop me a line if there are any questions.

-chris

