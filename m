Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSDEK7i>; Fri, 5 Apr 2002 05:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293076AbSDEK72>; Fri, 5 Apr 2002 05:59:28 -0500
Received: from albireo.ucw.cz ([194.213.206.36]:5381 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S292588AbSDEK7N>;
	Fri, 5 Apr 2002 05:59:13 -0500
Date: Fri, 5 Apr 2002 12:59:11 +0200
From: Martin Mares <mj@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
Message-ID: <20020405105911.GA3116@ucw.cz>
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org> <20020405080115.GA409@ucw.cz> <m1k7rmpmyq.fsf@frodo.biederman.org> <20020405084733.GG609@ucw.cz> <m1g02aplmm.fsf@frodo.biederman.org> <20020405090846.GL609@ucw.cz> <m1bscypjiu.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Given that I want a relative offset, and I have explicitly coded a
> relative offset, I don't see how that is a hack.  I see assembly
> for is telling the machine explicitly what to do and that does.

No, this is not a relative offset (it would be appropriate if the
program tries to relocate itself), but a genuine address in a program
which always runs from address 0 (relative to some segment, but it
doesn't matter).

> One of the other reasons I want to do it this way is in case is to
> make copying code easier.  If you use idioms that work equally well
> everywhere and for every case it is easier to switch between projects
> using the same tool.  And the assume 0 hack isn't useful when
> switching from real to protected mode while using the code segment
> you got from the reset vector.  Although it is kind of fun running
> real mode code with a code segment base of 0xffff0000.

Agreed, but in this case it's perfectly clear that the code will run
from address 0, so it should be written as such.

For such purposes, it would be wonderful if somebody could teach gas
how to assemble absolute code and make real location of code and base
for calculation of symbols independent. It probably could be done with
sections and a cleverly written ldscript (modulo ld bugs), but it's
nowhere near elegant.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A student who changes the course of history is probably taking an exam.
