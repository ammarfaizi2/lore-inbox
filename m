Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129350AbQKGKzR>; Tue, 7 Nov 2000 05:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129950AbQKGKzH>; Tue, 7 Nov 2000 05:55:07 -0500
Received: from ns2.Deuroconsult.ro ([193.226.167.164]:51214 "EHLO
	marte.Deuroconsult.ro") by vger.kernel.org with ESMTP
	id <S129350AbQKGKyu>; Tue, 7 Nov 2000 05:54:50 -0500
Date: Tue, 7 Nov 2000 12:53:16 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Michael Vines <mjvines@undergrad.math.uwaterloo.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel hook for open
In-Reply-To: <20001106182059.G12348@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.20.0011071251570.6730-100000@marte.Deuroconsult.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Erik Mouw wrote:

> On Mon, Nov 06, 2000 at 10:11:11AM -0500, Michael Vines wrote:
> > On Mon, 6 Nov 2000, Erik Mouw wrote:
> > > Use LD_PRELOAD instead.
> > 
> > You could also write a simple kernel module that replaces the open system
> > call.  See the Linux Kernel Module Programming Guide for details. 
> > http://www.linuxdoc.org/guides.html
> > 
> > specifically http://www.linuxdoc.org/LDP/lkmpg/node20.html
> 
> Why difficult when it can be done easy? To test the Y2K readiness of
> some programs (yeah, Y2K, remember?), I wrote a small library that
> overloaded the time() and gettimeofday() syscalls in about 100 lines of
> code. No kernel modules needed, no root privileges needed, just set the
> environment variable LD_PRELOAD and off you go.

I did this but it doesn't catch the getpwent (that use open)!
On strace it apears but my function is not called (I think it's called the
one from the library).

> 
> 
> Erik
> 
> -- 
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> 

---
Catalin(ux) BOIE
catab@deuroconsult.ro
A new Linux distribution: http://l13plus.deuroconsult.ro
http://www2.deuroconsult.ro/~catab

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
