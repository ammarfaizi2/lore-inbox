Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbQLOSCz>; Fri, 15 Dec 2000 13:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129732AbQLOSCp>; Fri, 15 Dec 2000 13:02:45 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:53004 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130018AbQLOSCj>; Fri, 15 Dec 2000 13:02:39 -0500
Date: Fri, 15 Dec 2000 09:31:57 -0800 (PST)
From: ferret@phonewave.net
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Dana Lacoste <dana.lacoste@peregrine.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
In-Reply-To: <FBF96516CD5@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.3.96.1001215093002.16439B-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Petr Vandrovec wrote:

> On 15 Dec 00 at 10:23, Dana Lacoste wrote:
> > > On Fri, Dec 15, 2000 at 12:14:04AM +0000, Miquel van Smoorenburg wrote:
> > 
> > > It's the version that's in cvs, I just did an cvs update.  It's
> > > been in it for ages.  If it's wrong, someone *please* correct it.
> > 
> > I think this is the important part.
> > This subject has come up quite a few times in the past
> > couple of weeks on the scyld (eepro/tulip) mailing lists.
> > 
> > Essentially, whatever solution is implemented MUST ensure :
> > 
> > 1 - glibc will work properly (the headers in /usr/include/* don't
> >     change in an incompatible manner)
> > 
> > 2 - programs that need to compile against the current kernel MUST
> >     be able to do so in a quasi-predictable manner.
> 
> Maybe you did not notice, but for months we have
> /lib/modules/`uname -r`/build/include, which points to kernel headers,
> and which should be used for compiling out-of-tree kernel modules
> (i.e. latest vmware uses this).

This symlink really should be a copy instead, because the finished kernel
may be installed on a machine that does not have kernel source installed
on it. Dangling symlinks are BAD.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
