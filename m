Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317729AbSFLP4n>; Wed, 12 Jun 2002 11:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317730AbSFLP4m>; Wed, 12 Jun 2002 11:56:42 -0400
Received: from gold.he.net ([216.218.149.2]:3603 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S317729AbSFLP4l>;
	Wed, 12 Jun 2002 11:56:41 -0400
Message-Id: <200206121556.IAA32247@gold.he.net>
Content-Type: text/plain; charset=US-ASCII
From: "J.S.Souza" <jssouza@pacbell.net>
Reply-To: jssouza@pacbell.net
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs
Date: Wed, 12 Jun 2002 08:55:45 -0700
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0206121629310.17198-100000@netfinity.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, the CPU was correct.
However, now I am uncertain as to WHAT was wrong with my configuration since 
the CPU was correct.  Like I stated before, eventually I just hacked a stock 
RedHat kernel and in the CPU section of the configuration, I just left their 
selections alone.  Well, if what you say is true, then I don't know WHAT the 
fixed actually was, but I haven't had a bad reboot on any of my kernel 
compiles since then (well, I did have 1 - but that's out of about 20 
compile's and reboot's i've done since then).  If you find out the problem, 
please put it on the LKML so i'll know what fixed it.

		Cheer,
		J.S.Souza

On Wednesday 12 June 2002 07:33 am, you wrote:
> On Wed, 12 Jun 2002, J.S.Souza wrote:
> > I had the exact same problem and few were able to help.  However, here's
> > what I found was _my_ problem.  I wasn't enabling the x86 options in the
> > kernel (duh!).  Make sure that when you compile, you enable "Intel IA32
> > CPU Microcode Support" and "Model Specific Register Support".  What I
> > ended up doing was taking a stock RedHat .config file for i386 and
> > looking at what they did for their options and started to delete things
> > from there that I don't use or need.  Eventually, I just learned what was
> > necessary for a basic i386 kernel.  Although I was compiling for 2.4.17
> > kernel.  Good luck, hope this was of some help.
>
> Interesting, but i can't see how that could have fixed your problem. MSR
> support is allowing MSR frobbing in user space and microcode stuff is
> update from userland too. Which also happens much later in boot.
>
> Incorrect CPU perhaps?
>
> Regards,
> 	Zwane
