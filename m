Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277018AbRJIMdR>; Tue, 9 Oct 2001 08:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277102AbRJIMdH>; Tue, 9 Oct 2001 08:33:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22792 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277018AbRJIMcu>; Tue, 9 Oct 2001 08:32:50 -0400
Subject: Re: [PATCH] Re: ENOATTR and other error enums
To: nathans@sgi.com (Nathan Scott)
Date: Tue, 9 Oct 2001 13:37:55 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        ag@bestbits.at (Andreas Gruenbacher), linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011009150113.A497835@wobbly.melbourne.sgi.com> from "Nathan Scott" at Oct 09, 2001 03:01:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qw8x-00041l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> XFS needs both values.  ENOATTR is also required by the ext2
> extended attributes project (and any other filesystem intending
> to implement extended attributes in the future).  Both values
> need to be visible in both kernel and user space, so this patch
> would be an initial step toward libc support also, hopefully.
> 
> In the absence of any cleaner way to do this (?), could we have
> this patch applied please?  Any/all feedback much appreciated

Such an update needs to be synchronized with glibc to avoid people
getting all sorts of odd "unknown" error messages. In general I dn't
see why its needed.

> > EFSCORRUPTED = Filesystem is corrupted

EIO is normally used for this

As to the string names for errors. They can't sanely go into the kernel
or kernel headers. Remember there are a lot of languages out there
