Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286253AbRLTNxr>; Thu, 20 Dec 2001 08:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286259AbRLTNxi>; Thu, 20 Dec 2001 08:53:38 -0500
Received: from unthought.net ([212.97.129.24]:19106 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S286253AbRLTNxa>;
	Thu, 20 Dec 2001 08:53:30 -0500
Date: Thu, 20 Dec 2001 14:53:28 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: svein.ove@aas.no
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Message-ID: <20011220145328.C16650@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	svein.ove@aas.no,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <E16GnIg-0000V5-00@starship.berlin> <20011220110936.A18142@atrey.karlin.mff.cuni.cz> <200112201338.OAA23947@mail48.fg.online.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <200112201338.OAA23947@mail48.fg.online.no>; from svein@crfh.dyndns.org on Thu, Dec 20, 2001 at 02:38:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:38:50PM +0100, Svein Ove Aas wrote:
> On Thursday 20. December 2001 11:09, Pavel Machek wrote:
> >
> > They need to get a clue. No need to work around their bugs in kernel.
> >
> > Anyway copyfile syscall would be nice for other reasons. (cp -a kernel
> > tree then apply patch without waiting for physical copy to be done
> > would be handy).
> > 								Pavel
> 
> Never mind that it might save a great deal of space...
> I often operate with three/more different kernel trees, but the differences 
> are often trivial.
> If the VFS created a COW node when I use cp -a I would, obviously, save a 
> great deal of space; this goes for numerous other source trees too.
> 
> Now there's a real world example for you.

No graphical file manager would use it - how would you show progress
information to the user when coping a single huge file ?

So, someone might hack up a 'cp' that used it, and in a few years when
everyone is at 2.4.x (where x >= version with copyfile()) maybe some
distribution would ship it.

Take a look at Win32, then have it. Then, look further, and you'll see
that they have system calls for just about everything else.  It's
a slippery slope, leading to horrors like CreateProcess() which takes
TEN arguments, where about half of them are pointers to STRUCTURES.

I'm not saying that adding copyfile() would take us there immediately,
but we'd be taking the direction, when you can get about all the speedup
with mmap()+write() or the likes anyway.

Just my 0.02 Euro

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
