Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbTLHNoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265404AbTLHNoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:44:17 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:14340 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S265401AbTLHNoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:44:12 -0500
From: phillip@lougher.demon.co.uk
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: joern@wohnheim.fh-wedel.de, kbiswas@neoscale.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1070883425.31993.80.camel@hades.cambridge.redhat.com>
Subject: Re: partially encrypted filesystem
Date: Mon, 08 Dec 2003 13:44:07 +0000
User-Agent: Demon-WebMail/2.0
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <E1ATLgF-0003XX-0V@anchor-post-31.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dwmw2@infradead.org wrote:
> On Sat, 2003-12-06 at 00:50 +0000, Phillip Lougher wrote:
> > Of course, all this is at the logical file level, and ignores the 
> > physical blocks on disk.  All filesystems assume physical data blocks 
> > can be updated in place.  With compression it is possible a new physical 
> > block has to be found, especially if blocks are highly packed and not 
> > aligned to block boundaries.  I expect this is at least partially why 
> > JFFS2 is a log structured filesystem.
> 
> Not really. JFFS2 is a log structured file system because it's designed
> to work on _flash_, not on block devices. You have an eraseblock size of
> typically 64KiB, you can clear bits in that 'block' all you like till
> they're all gone or you're bored, then you have to erase it back to all
> 0xFF again and start over.

Curiously, I am aware of how flash and log structured filesystems work.

> 
> JFFS2 was designed to avoid that inefficient extra layer, and work
> directly on the flash. Since overwriting stuff in-place is so difficult,
> or requires a whole new translation layer to map 'logical' addresses to
> physical addresses, it was decided just to ditch the idea that physical
> locality actually means _anything_.

Maybe okay for a flash filesystem which is slow anyway, but many filesystem designers *are* concerned about physical locality of blocks, for example video filesystems.
> 
> Given that design, compression just dropped into place; it was trivial.
> 

Or maybe 'not in(to)-place' :-) I don't think I was saying compression is difficult, it is not difficult if you've designed the filesystem correctly.

Phillip


