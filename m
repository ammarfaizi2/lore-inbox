Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129962AbRAWTUn>; Tue, 23 Jan 2001 14:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRAWTUd>; Tue, 23 Jan 2001 14:20:33 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:29706 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S129962AbRAWTUZ>; Tue, 23 Jan 2001 14:20:25 -0500
Message-ID: <3A6DDAD4.4889AC42@alacritech.com>
Date: Tue, 23 Jan 2001 11:26:12 -0800
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <200101230447.f0N4lpf23686@webber.adilger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> H. Peter Anvin writes:
> > We have:
> >
> >    0x82 - Linux swap
> >    0x83 - Linux filesystem
> >    0x85 - Linux extended partition (yes, this one does matter!)
> >
> > There seems to be some value in having a different value for swap.  It
> > lets an automatic program find a partition that does not contain data.
> 
> What would be wrong with changing the kernel to skip the first page of
> swap, and allowing us to put a signature there?  This would be really
> useful for systems that mount ext2 filesystems by LABEL or UUID.  With
> the exception of swap, you currently don't need to care about what disk
> a filesystem is on.  Of course, LVM also fixes this, but not everyone
> runs LVM.

LKCD starts writing a crash dump after the first page of the swap
partition (if that is used as the dump partition), so I'd hate to see
this implemented.

--Matt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
