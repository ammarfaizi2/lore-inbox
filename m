Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289456AbSAJOIe>; Thu, 10 Jan 2002 09:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289457AbSAJOI2>; Thu, 10 Jan 2002 09:08:28 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:23565 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289455AbSAJOIN>; Thu, 10 Jan 2002 09:08:13 -0500
Date: Thu, 10 Jan 2002 15:08:10 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Simple local DOS
Message-ID: <20020110140810.GJ1698@emma1.emma.line.org>
Reply-To: matthias.andree@stud.uni-dortmund.de
Mail-Followup-To: matthias.andree@stud.uni-dortmund.de
In-Reply-To: <3C3D9B2B.2DDB72CB@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3C3D9B2B.2DDB72CB@uni-mb.si>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, David Balazic wrote:

> I didn't do it on purpose to lock up my system and risk FS corruption
> durin unclean reboot. I was interested in the server output and " 2>&1 | less"
> is the logical way to do that.
> 
> I could also "solve" this problem by not running linux. And I can "solve" all
> gcc bugs by not using gcc. Those are not solutions. Not to me at least.

It's not Linux-specific, but will ALWAYS happen when you use one program
that eats all your input and pipe its output into another program that
waits for your input. 

What and when do you think you will eat when you feed your dog the
sausage you want to eat yourself?

> > output into interactive programs. tail -f is a viable workaround -- and 
> 
> tail -f ? what is the difference between :
> $ X 2>&1 | tail -f
> and
> $ X 

That you're clueless.

You'd do:

X >/my/safe/tmp/dir/X.log 2>&1 & tail -f /my/safe/tmp/dir/X.log

> > all this is off-topic on linux-kernel,
> 
> non-root user locked up the console code. console code is part of kernel.
> it is a kernel topic.

Nope. Non-root user has used setuid application and thus become root.
Drop setuid privileges and use xdm/kdm/gdm if you're to avoid this.

> My own dumbness ? Did you also say that ping-of-death is not a problem ?

Ping-of-death is a kernel bug or correctness issue or whatever you call
it. This is not. root gave away the privilege to redirect console input
by installing a setuid-application, X, XFree86, Xwrapper, whatever it
may be called.

And now please take this off the list.
