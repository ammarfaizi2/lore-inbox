Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273805AbRIXJZN>; Mon, 24 Sep 2001 05:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273827AbRIXJZE>; Mon, 24 Sep 2001 05:25:04 -0400
Received: from [132.68.115.2] ([132.68.115.2]:22923 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S273805AbRIXJYu>; Mon, 24 Sep 2001 05:24:50 -0400
Date: Mon, 24 Sep 2001 11:22:46 +0200
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: zefram@fysh.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
Message-ID: <20010924112246.A5022@leeor.math.technion.ac.il>
In-Reply-To: <20010923234111.A16873@leeor.math.technion.ac.il> <E15lH8i-0000W3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E15lH8i-0000W3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Sep 23, 2001 at 10:50:16PM +0100
Hebrew-Date: 7 Tishri 5762
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001, Alan Cox wrote about "Re: [PATCH] tty canonical mode: nicer erase behaviour":
> Thats in many ways a design flaw in the protocols. Original telnet has
> IAC sequences to send a "delete" regardless of keymapping policies that
> are not known at end points. X also does it right with the keysyms.
> Ssh seems to lack this

Consider the letter "a". There is no such problem of "keymapping policies"
or how to send it on telnet or ssh, because ASCII, in 1965, (or even before
that), standardized it. The last two characters in that acronym stand for
"Information Interchange", of course.
Anyway, ASCII's character 010 (^H) is called "BS", i.e., backspace. What's
so wrong with using that as the standard way to send a backspace? Is it
because someone decided that it would be cool to have help be summoned in
Emacs with a ^H? Next thing we know there'll be someone annoyed by the fact
that the Escape key sends ^[ and ruins his ability to map Control-[ to
something in Emacs (running on a tty), and we'll need to change the way Escape
is coded too?

Of course there are opposite arguments, with people calling their backspace
key a "rubout" and then claiming it is justified to use the ASCII rubout
character (0177, DEL) for it. Which makes this whole situation even uglier :(


-- 
Nadav Har'El                        |       Monday, Sep 24 2001, 7 Tishri 5762
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |Hardware, n.: The parts of a computer
http://nadav.harel.org.il           |system that can be kicked.
