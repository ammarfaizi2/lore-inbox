Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTFVIZr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 04:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbTFVIZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 04:25:46 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:21168 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264023AbTFVIZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 04:25:45 -0400
Date: Sun, 22 Jun 2003 10:39:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
Message-ID: <20030622083901.GA25120@wohnheim.fh-wedel.de>
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com> <20030622001101.GB10801@conectiva.com.br> <20030622014102.GB29661@dingdong.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030622014102.GB29661@dingdong.cryptoapps.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 June 2003 20:41:02 -0500, Chris Wedgwood wrote:
> On Sat, Jun 21, 2003 at 09:11:01PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> > Humm, I'd love to do that, i.e. to make gcc 3 required, lots of good
> > stuff like this one, anonymous structs, etc, etc, lots of stuff
> > could be done in an easier way, but are we ready to abandon gcc
> > 2.95.*? Can anyone confirm if gcc 2.96 accepts this?
> 
> What *requires* 2.96 still?  Is it a large number of people or obscure
> architecture?

Try these two litter things in Assembler code:

#define LONG_MACRO	\
asm			\
#ifdef something	\
asm			\
#else			\
asm			\
asm			\
#endif			\
asm

Compiles just fine with all 3.x I've tried.

	jump	92f
	...
81:	...
	...
92	...

Again, compiles just fine.

Both are clearly wrong and should not be in the source code.  But
Assembler bugs are subtle, nasty and Code Checkers for Assembler are
rare.  My vote is to keep 2.95+ support.

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
