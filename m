Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316844AbSFDWER>; Tue, 4 Jun 2002 18:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSFDWEQ>; Tue, 4 Jun 2002 18:04:16 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:42488 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316844AbSFDWEP>; Tue, 4 Jun 2002 18:04:15 -0400
Date: Tue, 4 Jun 2002 18:04:16 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
Message-ID: <20020604180416.E9111@redhat.com>
In-Reply-To: <3CFD25A2.FCC7F66A@zip.com.au> <Pine.LNX.4.44.0206041428080.983-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 02:37:26PM -0700, Linus Torvalds wrote:
> That's a good start, but before even egtting that far there is some need
> for a way to get a picture of the FS layout in a reasonably fs-independent
> way.

Al Viro actually came up with a beautiful mechanism for it: present 
the filesystem's metadata as a filesystem itself.  Blocks within a 
particular inode can then be viewed with cat, and suggested replacements 
can be made via echo.  Such a best could be called ext2metafs and work 
cooperatively with the existing filesystem code.  It's quite an elegant 
design that has utility beyond the simple case of defragmenting.

> Add a nice graphical front-end, and you can make it a useful screen-saver.

Heh, that would be excellent.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
