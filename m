Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130172AbRCCAE0>; Fri, 2 Mar 2001 19:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130173AbRCCAEQ>; Fri, 2 Mar 2001 19:04:16 -0500
Received: from gatekeeper.corp.netcom.net.uk ([194.42.224.25]:30426 "EHLO
	gatekeeper") by vger.kernel.org with ESMTP id <S130172AbRCCAEB>;
	Fri, 2 Mar 2001 19:04:01 -0500
Message-ID: <3AA034DA.1C3ADA41@ops.netcom.net.uk>
Date: Sat, 03 Mar 2001 00:03:38 +0000
From: Bill Crawford <bill@ops.netcom.net.uk>
Reply-To: billc@netcomuk.co.uk
Organization: Netcom Internet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk> <20000101020213.D28@(none)>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Hi!

> >  I was hoping to point out that in real life, most systems that
> > need to access large numbers of files are already designed to do
> > some kind of hashing, or at least to divide-and-conquer by using
> > multi-level directory structures.

> Yes -- because their workaround kernel slowness.

 Not just kernel ... because we use NFS a lot, directory searching is
a fair bit quicker with smaller directories (especially when looking
manually at things).

> I had to do this kind of hashing because kernel disliked 70000 html
> files (copy of train time tables).

> BTW try rm * with 70000 files in directory -- command line will overflow.

 Sort of my point, again.  There are limits to what is sane.

 Another example I have cited -- our ticketing system -- is a good one.
If there is subdivision, it can be easier to search subsets of the data.
Can you imagine a source tree with 10k files, all in one directory?  I
think *people* need subdivision more than the machines do, a lot of the
time.  Another example would be mailboxes ... I have started to build a
hierarchy of mail folders because I have more than a screenful.

> Yes? Easier to type cat timetab1/2345 that can timetab12345? With bigger
> command line size, putting i into *one& directory is definitely easier.

 IMO (strictly my own) it is often easier to have things subdivided.
I have had to split up my archive of linux tarballs and patches because
it was getting too big to vgrep.

> >  A couple of practical examples from work here at Netcom UK (now
> > Ebone :), would be say DNS zone files or user authentication data.
> > We use Solaris and NFS a lot, too, so large directories are a bad
> > thing in general for us, so we tend to subdivide things using a
> > very simple scheme: taking the first letter and then sometimes
> > the second letter or a pair of letters from the filename.  This
> > actually works extremely well in practice, and as mentioned above
> > provides some positive side-effects.

> Positive? Try listing all names that contain "linux" with such case. I'll
> do ls *linux*. You'll need ls */*linux* ?l/inux* li/nux*. Seems ugly to
> me.

 It's not that bad, as we tend to be fairly consistent in a scheme.  I
only have to remember one of those combinations at a time :)

 Anyway, again I apologise for starting or continuing (I forget which)
this thread.  I really do understand (and agree with) the arguments for
better directory performance.  I have moved to ReiserFS, mainly for the
avoidance of long fsck (power failure, children pushing buttons, alpha
and beta testing of 3D graphics drivers).  I *love* being able to type
"rm -rf linux-x.y.z-acNN" and have the command prompt reappear in less
than a second.  I intended merely to highlight the danger inherent in
saying to people "oh look you can put a million entries in a directory
now" :)

 *whack* bad thread *die* *die*

>                                                                 Pavel

-- 
/* Bill Crawford, Unix Systems Developer, Ebone (formerly GTS Netcom) */
#include <stddiscl>
const char *addresses[] = {
    "bill@syseng.netcom.net.uk", "Bill.Crawford@ebone.com",     // work
    "billc@netcomuk.co.uk", "bill@eb0ne.net"                    // home
};
