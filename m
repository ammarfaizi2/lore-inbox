Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281040AbRKOUfS>; Thu, 15 Nov 2001 15:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281044AbRKOUfI>; Thu, 15 Nov 2001 15:35:08 -0500
Received: from ppp01.ts1-1.NewportNews.visi.net ([209.8.196.1]:58619 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S281040AbRKOUe5>; Thu, 15 Nov 2001 15:34:57 -0500
Date: Thu, 15 Nov 2001 15:34:42 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115153442.A329@visi.net>
In-Reply-To: <20011115092452.Z329@visi.net> <3BF3F9ED.17D55B35@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF3F9ED.17D55B35@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 09:22:53AM -0800, Andrew Morton wrote:
> Ben Collins wrote:
> > 
> > I recently compiled support for ext3 into the kernel (2.4.15-pre4) and
> > booted that kernel onto a system that didn't have any ext3 partitions.
> > On boot I got these messages:
> > 
> > JBD: no valid journal superblock found
> > JBD: no valid journal superblock found
> > EXT3-fs: error loading journal.
> > 
> 
> It sounds like the superblock claims to be an ext3 fs, but something
> has scrogged the journal file.
> 
> e2fsck should have removed the journal in this situation, with
> the message "*** ext3 journal has been deleted - filesystem is
> now ext2 only ***".
> 
> Please send the output of dumpe2fs, and of `fsck -fy'.

No, it has always been an ext2 filesystem, and never was ext3. Fsck
shows no errors. The point being that I do _not_ want my root filesystem
to be ext3, but I do want ext3 built into the kernel. That case should
not cause a problem like I have seen.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
