Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbTD1KOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 06:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTD1KOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 06:14:34 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:40940 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263104AbTD1KOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 06:14:33 -0400
Date: Mon, 28 Apr 2003 12:26:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Swap Compression
Message-ID: <20030428102635.GB9094@wohnheim.fh-wedel.de>
References: <20030426091747.GD23757@wohnheim.fh-wedel.de> <200304261148590300.00CE9372@smtp.comcast.net> <20030426160920.GC21015@wohnheim.fh-wedel.de> <200304262224040410.031419FD@smtp.comcast.net> <20030427090418.GB6961@wohnheim.fh-wedel.de> <200304271324370750.01655617@smtp.comcast.net> <20030427175147.GA5174@wohnheim.fh-wedel.de> <200304271431250990.01A281C7@smtp.comcast.net> <20030427190444.GC5174@wohnheim.fh-wedel.de> <m13ck3gg1s.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m13ck3gg1s.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 April 2003 02:52:15 -0600, Eric W. Biederman wrote:
> JXrn Engel <joern@wohnheim.fh-wedel.de> writes:
> 
> > Yes, zlib eats up several 100k of memory. You really notice this when
> > you add it to a bootloader that was (once) supposed to be small. :)
> 
> I only measured about 32k for decompression.  But that was using
> the variant from gzip via the kernel.

What were you measuring? Code size or runtime memory consumption? It
looks a bit large for code size, but _very_ small for runtime.

> The really small algorithm I know about (at least for decompression)
> is upx.  The compression is comparable with gzip with a decompressor
> that can fit in a page or two of assembly code.

Sounds interesting as well. Maybe we should add a central compression
library to the kernel. zlib is already central, but at least jffs2 and
ppp also have some other algorithms that could be moved and possibly
reused for other subsystems/drivers.

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
