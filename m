Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261280AbREOTXz>; Tue, 15 May 2001 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbREOTXp>; Tue, 15 May 2001 15:23:45 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33285 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261280AbREOTXk>; Tue, 15 May 2001 15:23:40 -0400
Message-ID: <3B018231.7D2D503A@transmeta.com>
Date: Tue, 15 May 2001 12:23:29 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Johannes Erdfelt <johannes@erdfelt.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> But no, I don't actually like sockets all that much myself. They are hard
> to use from scripts, and many more people are familiar with open/close and
> read/write.
> 

I always thought it was really strange that I couldn't open() a AF_UNIX
socket in order to write() to it (as a stream socket, of course.)  It
really makes a lot of things harder to do than it needs to be, and I
would still like to see this generalization done.

That being said, if USB exported a filesystem I don't see any good reason
why you shouldn't be able to advertise "socket" (S_ISSOCK()) objects and
simply have them accept open("/dev/usb/blah/blah") instead of
connect(AF_USB, ...) -- and still use send() and recv() where it is more
appropriate to do so than using read() and write().

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
