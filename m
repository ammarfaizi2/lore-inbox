Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131297AbRAaUsD>; Wed, 31 Jan 2001 15:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbRAaUrx>; Wed, 31 Jan 2001 15:47:53 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:12017 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131297AbRAaUrl>; Wed, 31 Jan 2001 15:47:41 -0500
Date: Wed, 31 Jan 2001 18:46:42 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Gabor Lenart <lgb@lgb.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
In-Reply-To: <20010131182124.A1890@supervisor.hu>
Message-ID: <Pine.LNX.4.21.0101311846110.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Gabor Lenart wrote:
> On Wed, Jan 31, 2001 at 05:06:07PM +0000, Alan Cox wrote:
> > > Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
> > > 4/5 systems I have now overflow the buffer during boot before init is
> > > even launched.
> > 
> > Thats just an indication that 2.4.x is currently printking too much crap on
> > boot
> 
> Would it be possible to grow and shring that buffer on demand?
> Let's say we have a default size and let it grow to a maximum
> value. After some timeout, buffer size can be shrinked to
> default value if it's enough at that moment. Or something
> similar.

And when you can't allocate memory for expanding the
printk() ringbuffer?  Print a message? ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
