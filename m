Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137174AbREKQyw>; Fri, 11 May 2001 12:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137176AbREKQyd>; Fri, 11 May 2001 12:54:33 -0400
Received: from defiant.provalue.net ([208.204.44.6]:64780 "EHLO
	warpcore.provalue.net") by vger.kernel.org with ESMTP
	id <S137174AbREKQyS>; Fri, 11 May 2001 12:54:18 -0400
Date: Fri, 11 May 2001 10:09:34 -0500 (CDT)
From: Collectively Unconscious <swarm@warpcore.provalue.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 Crash Help, please
In-Reply-To: <20010511184707.J27167@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.10.10105111005470.15179-100000@warpcore.provalue.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, the very tail end of an oops.

That explains it, I've never had one so long that everything else had     
scrolled off the screen. 2.2.x has been stable enough that I only have     
gotten a kernel oops from hardware errors, mainly when I get an nmi from
bad memory so I've never had to worry about decoding before this.

I like that in an OS, thanks! :)

For the curious, here it is decoded:

[<8010997c>]
Code: 8b 4a 04 85 c9 74 22 8b 5a 18 8b 02 89 01 8b 0a 85 c9 74 08

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    8b 4a 04
movl   0x4(%edx),%ecx <===
Code:  00000003 Before first symbol               3:    85 c9
testl  %ecx,%ecx
Code:  00000005 Before first symbol               5:    74 22
je      00000029 Before first symbol
Code:  00000007 Before first symbol               7:    8b 5a 18
movl   0x18(%edx),%ebx
Code:  0000000a Before first symbol               a:    8b 02
movl   (%edx),%eax
Code:  0000000c Before first symbol               c:    89 01
movl   %eax,(%ecx)
Code:  0000000e Before first symbol               e:    8b 0a
movl   (%edx),%ecx
Code:  00000010 Before first symbol              10:    85 c9
testl  %ecx,%ecx
Code:  00000012 Before first symbol              12:    74 08
je      0000001c Before first symbol


We're going to test that machine and see if we can reproduce it. If we
can, my first suspect is a hardware error since we have several
indentical machines which aren't getting this oops.

Jay

On Fri, 11 May 2001, Erik Mouw wrote:

> On Fri, May 11, 2001 at 07:32:41AM -0500, Collectively Unconscious wrote:
> > I had an NFS server crash in an unfamiliar way.
> > 
> > 2.2.19 smp 2xPIII 450 
> > 
> > The screen was filled with varitions of [<8010997c>] and at the bottom of
> > the screen was the following:
> > 
> > Code: 8b 4a 04 85 c9 74 22 8b 5a 18 8b 02 89 01 8b 0a 85 c9 74 08
> > 
> > Can anyone clue me in on this?
> 
> You have to decode the Oops to make it useful. See the files
> REPORTING-BUGS and Documentation/oops-tracing.txt in the kernel source
> tree.
> 
> 
> Erik
> 
> PS: Instead of *replying* to an existing thread, you'd better *start* a
>     new thread ("compose" instead of "reply"). If I killed the "write
>     to dvd ram" thread I wouldn't have seen your message at all.
> 
> -- 
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> 

