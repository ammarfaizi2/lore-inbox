Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268111AbTAJCu4>; Thu, 9 Jan 2003 21:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268116AbTAJCuz>; Thu, 9 Jan 2003 21:50:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52111
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268111AbTAJCuz>; Thu, 9 Jan 2003 21:50:55 -0500
Subject: Re: [Linux-fbdev-devel] Re: rotation.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <avktge$22o$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0301091956140.5660-100000@phoenix.infradead.org>
	 <1042153388.28469.17.camel@irongate.swansea.linux.org.uk>
	 <avktge$22o$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042170338.28469.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 03:45:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 22:35, Linus Torvalds wrote:
> UTF8 delete behaviour should be pretty trivial to add.  It's liketly to
> be more involved than simply adding a
> 
> 	/* multi-char UTF8 thing? Continue until we hit the first one */
> 	if (tty->utf8 && (c & 0x80) && !(c & 0x40))
> 		continue;
> 
> to the loop in n_tty.c: eraser(), but it might not be _much_ more than
> that. 

That should do the delete case yes. The other cases are more interestingly horrible
and I hope don't need solving (suppose you want your intr character to be the 
chinese symbol for 'stop' ...)

Its on the todo list, and someone sent me a test patch for 3-4 byte utf8 input

