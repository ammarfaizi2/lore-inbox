Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVF0GCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVF0GCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVF0F7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:59:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:14560 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261844AbVF0FxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:53:12 -0400
Message-Id: <200506270538.j5R5cww2005785@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Sun, 26 Jun 2005 22:24:23 EST." <42BF7167.80201@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 27 Jun 2005 01:38:53 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Kyle Moffett wrote:
> > On Jun 26, 2005, at 22:37:48, David Masover wrote:

[...]

> That just means the zip plugin has to be more carefully written than I
> thought.  It would have to be sandboxed and limited to prevent buffer
> overruns and zip bombs.

[...]

> Remember that zip, at least, would not be in the kernel.  I think what
> is going in the kernel is gzip and lzo, and it's being done so
> transparently that you never actually see the compressed version.

Doesn't matter if it is zip of some other compression, the problem is
exactly the same.

> > Can you illustrate for me with precise, clear, and unambiguous arguments

> That will take some time.  And some thinking.

See? Exactly what has been demanded by all the "unfair", "ReiserFS-racist",
"shove-any-junk-but-do-not-accept-perfect-filesystems-into-the-kernel" etc
people here on LKML from the very start.

> > how this can avoid all possible pitfalls,

> Especially if you want perfection.

Perfection would be nice, but (IMHO) not required.

[...]

> Now, the cryptocompress as it currently stands does not involve ... and
> does not introduce any new security holes in the way that you are
> describing.  There might be some issues with key management (someone
> hinted vaguely at that), but nothing insurmountable.

OK, I see a week of flamefest going by until you admit it has the same
problemas as compression (Hint: Most encryption compresses first, in order
to give would-be cryptoanalysts less of a toehold via non-uniform
distributions, and having less work to do), and then a whole lot of its
/own/ problems (that somebody can peek at a cached uncompressed copy of my
files is not so bad, if they can peek at my decrypted files I'd be rather
less pleased... and here you have to include a malicious root (Yes, I'm
paranoid. Doesn't mean root is not out to get me.).). Perhaps this can't be
all solved, but the exact boundaries of what /is/ provided, and what
/isn't/ must be made clear.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

