Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132402AbRDFUPW>; Fri, 6 Apr 2001 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbRDFUPM>; Fri, 6 Apr 2001 16:15:12 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:8176 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132389AbRDFUPA>; Fri, 6 Apr 2001 16:15:00 -0400
Date: Fri, 6 Apr 2001 21:31:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <20010406203440.O28118@athlon.random>
Message-ID: <Pine.GSO.3.96.1010406211322.15958J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Andrea Arcangeli wrote:

> ev6 works the way you described AFIK (to flush the write buffer you can use

 Thanks for the clarification -- you made me calm down.

> wmb(), note that wmb() semantics doesn't require the cpu to really "flush" but
> just to keep writes oredered across other mb or wmb, but it's basically the
> same from a software point of you and flushing the write buffer synchronously
> obviously provides that semantics).  I didn't followed very closely the

 Of course -- you only want to do mb (and not wmb) if you need to meet
hw's specific timing or you want to perform a read from a volatile
register of a peripheral device. 

> previous part of the thread so I'm not sure what is the issue.

 Someone complained of Alpha not having Intel-style MTRRs to set write
combining for fb memory...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

