Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272817AbRIWUmL>; Sun, 23 Sep 2001 16:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272859AbRIWUmB>; Sun, 23 Sep 2001 16:42:01 -0400
Received: from [132.68.115.2] ([132.68.115.2]:49280 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S272817AbRIWUlr>; Sun, 23 Sep 2001 16:41:47 -0400
Date: Sun, 23 Sep 2001 23:41:11 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: zefram@fysh.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
Message-ID: <20010923234111.A16873@leeor.math.technion.ac.il>
In-Reply-To: <E15kyyG-0000mq-00@dext.rous.org> <E15lFVk-0000Ex-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E15lFVk-0000Ex-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Sep 23, 2001 at 09:05:56PM +0100
Hebrew-Date: 7 Tishri 5762
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001, Alan Cox wrote about "Re: [PATCH] tty canonical mode: nicer erase behaviour":
> Erase character policy is precisely defined by posix. Fix problem apps. 
> Debian set a policy on this a long time back and have done wonders since

Just too bad Debian's policy is to make ^? the erase character - pretty
much the opposite of what most Unix users used before that. Pretending
ASCII BS (^H) doesn't exist any more is an interesting exercise, but
it isn't easy to change habits and standards that existed for a couple of
decades... The same problem exists for the ASCII DEL (^?) which was also used
in many Unix systems, but usually as a intr key, not a "delete-forward" type
of thing...
[see http://www.debian.org/doc/debian-policy/ch-opersys.html#s10.8
for the mentioned Debian policy]

Debian's solution isn't a silver bullet, in my opinion... It just means the
^H/^? confusion stops being a problem in a stand-alone system (if all your
applications and configuration files come as defaults from Debian, they are
consistent) but it just increased the mess when you log in from one system
type to another (one of them being none-Linux Unix)...

P.S.
The only relation any of this has to the kernel is the behavior of the
"cooked" line discipline, as Zefram already said. I think I like his
erase2 idea better than his forget-the-difference-between-^H-and-^? idea.
However, this former idea will work well only if applications like ssh,
for example, will know how to propegate erase2, and they currently don't.
But this is again not really a kernel issue...

-- 
Nadav Har'El                        |       Sunday, Sep 23 2001, 7 Tishri 5762
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |Experience is what causes a person to
http://nadav.harel.org.il           |make new mistakes instead of old ones.
