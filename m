Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277008AbRJHRe7>; Mon, 8 Oct 2001 13:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277013AbRJHReu>; Mon, 8 Oct 2001 13:34:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:32526 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277008AbRJHRel> convert rfc822-to-8bit; Mon, 8 Oct 2001 13:34:41 -0400
Date: Mon, 8 Oct 2001 14:12:39 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: OOM-Killer in 2.4.11pre4
In-Reply-To: <20011006162617.A724@athlon.random>
Message-ID: <Pine.LNX.4.21.0110081411220.4718-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Oct 2001, Andrea Arcangeli wrote:

> On Sat, Oct 06, 2001 at 08:53:30AM +0200, Christian Bornträger wrote:
> > I reported __alloc_pages: 0-order allocation failed errors in 2.4.10 with a 
> > memory eating program. 
> > 
> > These errors are gone with 2.4.11pre4. The OOM-Killer works __correct__.  it 
> > seems that Marcelos Patch works correct for me.
> 
> to test the oom killer you should try to run out of memory sometime.
> It's not the oom killer that cured the oom faliures, it is the deadlock
> prone infinite loop in the allocator that did.
> 
> Now I identified various issues that can explain the oom faliures on the
> highmem boxes (I don't have any highmem box so it wasn't possible to
> trigger them here, the higher memory ia32 machine that I own is my
> UP desktop with 512mbyte of ram), and I will be able to verify my fixes
> as soon as I can get a login on a 4/8G box. I created this project for
> this purpose:
> 
> 	http://www.osdlab.org/cgi-bin/eidetic.cgi?command=display&modulename=projects&on=60
> 
> After I get the login and after verifying my fixes I'll release a new
> -aa that will be meant primarly to fix the allocation faliures.

Andrea, 

I already have access to a 16GB box on OSDLabs exactly to test highmem
related issues -- there is no need to create another similar project IMO.

I can give you access to the machine if you want. 

