Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbRAWGYQ>; Tue, 23 Jan 2001 01:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132173AbRAWGYH>; Tue, 23 Jan 2001 01:24:07 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6923 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129996AbRAWGXv>; Tue, 23 Jan 2001 01:23:51 -0500
Message-ID: <3A6D2365.EB7F2F31@transmeta.com>
Date: Mon, 22 Jan 2001 22:23:33 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
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
> 

It already does that, you know.  Nothing inherently wrong, *EXCEPT* that
it breaks a bunch of programs already out there.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
