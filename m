Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRDFSR0>; Fri, 6 Apr 2001 14:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbRDFSRG>; Fri, 6 Apr 2001 14:17:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34682 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131724AbRDFSRD>; Fri, 6 Apr 2001 14:17:03 -0400
Date: Fri, 6 Apr 2001 20:34:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010406203440.O28118@athlon.random>
In-Reply-To: <m13dbmw4he.fsf@frodo.biederman.org> <Pine.GSO.3.96.1010406191454.15958I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1010406191454.15958I-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Apr 06, 2001 at 07:27:24PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 07:27:24PM +0200, Maciej W. Rozycki wrote:
> [..] You normally have
> non-cached locations buffered (since you don't always need peripheral
> device accesses to be posted immediately) and can force a writeback with a
> memory barrier. [..]

ev6 works the way you described AFIK (to flush the write buffer you can use
wmb(), note that wmb() semantics doesn't require the cpu to really "flush" but
just to keep writes oredered across other mb or wmb, but it's basically the
same from a software point of you and flushing the write buffer synchronously
obviously provides that semantics).  I didn't followed very closely the
previous part of the thread so I'm not sure what is the issue.

Andrea
