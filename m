Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbREOWgs>; Tue, 15 May 2001 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261670AbREOWgl>; Tue, 15 May 2001 18:36:41 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:59405 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261668AbREOWg3>; Tue, 15 May 2001 18:36:29 -0400
Message-ID: <3B01AF49.A66DB880@transmeta.com>
Date: Tue, 15 May 2001 15:35:53 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <200105152231.f4FMVSC246046@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> H. Peter Anvin writes:
> 
> > This would leave no way (without introducing new interfaces) to write,
> > for example, the boot block on an ext2 filesystem.  Note that the
> > bootblock (defined as the first 1024 bytes) is not actually used by
> > the filesystem, although depending on the block size it may share a
> > block with the superblock (if blocksize > 1024).
> 
> The lack of coherency would screw this up anyway, doesn't it?
> You have a block device, soon to be in the page cache, and
> a superblock, also soon to be in the page cache. LILO writes to
> the block device, while the ext2 driver updates the superblock.
> Whatever gets written out last wins, and the other is lost.
> 

Albert, I *did* say "this better work or we have a problem."

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
