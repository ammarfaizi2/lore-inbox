Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129758AbRBYAnB>; Sat, 24 Feb 2001 19:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129756AbRBYAmw>; Sat, 24 Feb 2001 19:42:52 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:8972 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129747AbRBYAmi>; Sat, 24 Feb 2001 19:42:38 -0500
Date: Sat, 24 Feb 2001 19:41:57 -0500
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@redhat.com>, Ken Moffat <ken@kenmoffat.uklinux.net>
cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <878610000.983061717@tiny>
In-Reply-To: <E14Wlgs-0000Sp-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, February 24, 2001 08:53:15 PM +0000 Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>> 32Mb. The test results vary depending on what else is on the partition,
>> but in each case the last file affected is 01017 and there are sequences
>> of previous_number+4, for up to 8 files (but next file after this might
>> be previous+7 or previous +15, or sporadic). From other problems I've
>> seen on the list, maybe I need more memory to run reiserfs ?
> 
> No. Reiserfs cannot go around corrupting files regardless of the amount of
> memory you have. What is however quite possible is that there is a race
> condition on reiserfs (or in the VFS) that is triggered when you are
> paging and programs are thus sleeping on buffer and memory allocations
> 
> 
Exactly.  The tail conversion code depends heavily on the page up to date
bit being set right.  It is more than possible that I've screwed up
something there, and the code thinks a page is valid when it really isn't.

-chris




