Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSKJTbs>; Sun, 10 Nov 2002 14:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSKJTbs>; Sun, 10 Nov 2002 14:31:48 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:33288 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265130AbSKJTbr>;
	Sun, 10 Nov 2002 14:31:47 -0500
Date: Sun, 10 Nov 2002 20:37:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BOGUS: megaraid changes
Message-ID: <20021110193717.GA2243@mars.ravnborg.org>
Mail-Followup-To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <torvalds@transmeta.com> <Pine.LNX.4.44.0211101039100.9581-100000@home.transmeta.com> <200211101904.gAAJ4RX12573@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211101904.gAAJ4RX12573@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 02:04:27PM -0500, J.E.J. Bottomley wrote:
> I don't necessarily agree.  It's easy to miss in all the build noise (most 
> average users don't do make -s).  And the warning isn't that fierce (it 
> complains about a prototype mismatch), so even if it's noticed, it might get 
> ignored.

I take this opportunity to advertise for the quiet facility of kbuild:

Sample run:
$> make KBUILD_VERBOSE=0
  CC      kernel/rcupdate.o
  CC      kernel/dma.o
kernel/dma.c:102: warning: `proc_dma_show' defined but not used
  CC      kernel/uid16.o
  LD      kernel/built-in.o

Warnings really hurts the eye when using this.
And the filename supplied should be good enough for emacs and the like.
I have seen only a few persons actually using this and I wonder if people
feel they loose some information when presented with this condensed format?

Compared to "make -s" you are able to follow the progress.

	Sam
