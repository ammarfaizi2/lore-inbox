Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132490AbRAVQdn>; Mon, 22 Jan 2001 11:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132559AbRAVQde>; Mon, 22 Jan 2001 11:33:34 -0500
Received: from [64.64.109.142] ([64.64.109.142]:63759 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S132408AbRAVQdU>; Mon, 22 Jan 2001 11:33:20 -0500
Message-ID: <3A6C609F.F135DB0@didntduck.org>
Date: Mon, 22 Jan 2001 11:32:31 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Clausen <clausen@conectiva.com.br>
CC: linux-fsdevel@vger.kernel.org, bug-parted@gnu.org,
        linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <3A6C5D12.99704689@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen wrote:
> 
> Hi all,
> 
> We have roughly 10 different types of partition tables.  We hate
> them, but it looks like they won't be going away for a long time.
> 
> Partition IDs seem to create a lot of confusion.  For example,
> most people use 0x83 for both ext2 and reiserfs, on msdos
> partition tables.  People use "Apple_UNIX_SVR2" for ext2 on
> Mac, etc.
> 
> Linux doesn't really use partition IDs.  Well, not entirely
> true... it's used on Mac's as a heuristic, for finding swap
> devices, etc. - but I think this unnecessary.
> 
> LVM also uses it, but I also think it's unnecessary.
> 
> So, can anyone remember why we have partition IDs?  (as opposed
> to just probing for signatures on the fs)  If new partition table
> types come out (which is happening, believe it or not...), how
> should Linux/fdisk/parted handle IDs?  Should we have one Linux
> type, that we use for everything?  Should we have one type for each
> TYPE of data (file system, swap, logical volume physical device, etc.)?

For compatability with dual booting other operating systems.  Would you
want Windows walking over your ext2 filesystems?  Linux didn't invent
the partition table schemes, it just borrows from those that are most
common for a given architecture (ie. msdos on PC compatable systems,
etc.)

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
