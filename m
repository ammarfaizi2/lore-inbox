Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269524AbUHZTxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269524AbUHZTxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269479AbUHZTno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:43:44 -0400
Received: from mail.shareable.org ([81.29.64.88]:60358 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269482AbUHZTky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:40:54 -0400
Date: Thu, 26 Aug 2004 20:40:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826194046.GX5733@mail.shareable.org>
References: <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org> <20040826155744.GA4250@lst.de> <20040826160638.GJ5733@mail.shareable.org> <20040826161303.GA4716@lst.de> <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org> <20040826172029.GP5733@mail.shareable.org> <Pine.LNX.4.58.0408261021250.2304@ppc970.osdl.org> <20040826181620.GT5733@mail.shareable.org> <Pine.LNX.4.58.0408261119480.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261119480.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > It is not the kernel which decides.  The filesystem containing
> > /dev/hda/part1 opens "the directory branch".
> 
> But that filesystem cannot know what the _other_ filesystem configurations 
> are. And that's what you'd have to have to mount.

At which point, userspace comes in.  Who knows what userspace chooses.

> > The obvious implementation has the userspace helper just mounting it,
> > end of story.  If the mount command fails, it fails.  Much like autofs.
> 
> Yes, that would work, but it's of questionable use. If you want autofs, 
> then just _use_ autofs.

I don't mean to imply it's useful behaviour: only that it seems to
happen by default if you don't do anything special to prevent it, if
you see what I mean.

It does seem useful to have _files_ mounted automagically (using
loopback devices): for example, cd into a .iso file and it would be
nice to see the contents.  At this point, deciding on the preferred
-EBUSY or not behaviour becomes relevant, as does deciding whether the
.iso in this example is viewed using the kernel's isofs code, or using
a userspace helper in the same way as we'd use one to browse a .zip file.

-- Jamie
