Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281051AbRKOUt2>; Thu, 15 Nov 2001 15:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKOUtT>; Thu, 15 Nov 2001 15:49:19 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:53254 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281051AbRKOUtB>; Thu, 15 Nov 2001 15:49:01 -0500
Message-ID: <3BF42A1A.5AE96A78@zip.com.au>
Date: Thu, 15 Nov 2001 12:48:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>,
		<3BF3F9ED.17D55B35@zip.com.au> <20011115153442.A329@visi.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> 
> > Please send the output of dumpe2fs, and of `fsck -fy'.
> 
> No, it has always been an ext2 filesystem, and never was ext3. Fsck
> shows no errors. The point being that I do _not_ want my root filesystem
> to be ext3, but I do want ext3 built into the kernel. That case should
> not cause a problem like I have seen.
> 

ext3 thinks that the filesystem's superblock has the
EXT3_FEATURE_COMPAT_HAS_JOURNAL bit set in the s_feature_compat
field of the on-disk superblock.

It's probable that that bit _is_ set.  ext2 will never notice it.

Please: the dumpe2fs output?

-
