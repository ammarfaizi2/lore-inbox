Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWADVs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWADVs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWADVs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:48:26 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:49610 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751729AbWADVsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:48:25 -0500
Subject: Re: 2.6.14.5 to 2.6.15 patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <9a8748490601041317q3711511ak22b95f985023e5b0@mail.gmail.com>
References: <200601041710.37648.nick@linicks.net>
	 <9a8748490601040950q2b2691f5l7577b52417b4c50b@mail.gmail.com>
	 <Pine.LNX.4.58.0601040950530.19134@shark.he.net>
	 <200601041756.52484.nick@linicks.net>
	 <1136399230.12468.70.camel@localhost.localdomain>
	 <9a8748490601041317q3711511ak22b95f985023e5b0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 16:48:05 -0500
Message-Id: <1136411285.12468.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 22:17 +0100, Jesper Juhl wrote:

> 
> 14 steps?

Sorry I wasn't clearer.  I was demonstrating how one can go from 2.6.14
to 2.6.14.1 to 2.6.14.5 then to 2.6.15. Not how to go from 2.6.14.5 to
2.6.15.  Those were 14 steps of going from 2.6.14 to 2.6.14.1 to
2.6.14.5 to 2.6.15 with showing that it worked. If all i wanted to do
was to go from 2.6.14.5 to 2.6.15, it's one step:  And it even downloads
and renames the directory for me :)

All patches are archived in ~/.ketchup so that it doesn't have to
download them each time.  I actually went into that directory and
manually removed the patch so that it would force ketchup to download it
again, for this example.

===
rostedt@gandalf:~$ cd linux-2.6.14.5/
rostedt@gandalf:~/linux-2.6.14.5$ ketchup -r -G 2.6.15
2.6.14.5 -> 2.6.15
Applying patch-2.6.14.5.bz2 -R
Downloading patch-2.6.15.bz2
--16:26:05--  http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.15.bz2
           => `/home/rostedt/.ketchup/patch-2.6.15.bz2.partial'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 6,254,721 (6.0M) [application/x-bzip2]

100%[====================================>] 6,254,721    475.16K/s    ETA 00:00

16:26:21 (413.28 KB/s) - `/home/rostedt/.ketchup/patch-2.6.15.bz2.partial' saved [6254721/6254721]

Applying patch-2.6.15.bz2
Current directory renamed to /home/rostedt/linux-2.6.15
rostedt@gandalf:~/linux-2.6.14.5$ cd .
===

So removing all the crap that is spit out by ketchup, I have three
steps.  Two to change directories, and one real ketchup step!

1) cd linux-2.6.14.5/
2) ketchup -r -G 2.6.15
3) cd .

Can it get any easier?


> Surely a simple 5 step procedure is easier :
> 
> $ cd ~/linux-2.6.14.5                   # change into the kernel source dir
> $ patch -p1 -R < ../patch-2.6.14.5      # revert the 2.6.14.5 patch
> $ patch -p1 < ../patch-2.6.15         # apply the new 2.6.15 patch
> $ cd ..
> $ mv linux-2.6.14.5 linux-2.6.15      # rename the kernel source dir
> 
> That's assuming you have already gunzip'ed the patch, but even if you
> have not it's still just as easy :
> 
> $ cd ~/linux-2.6.14.5                   # change into the kernel source dir
> $ zcat ../patch-2.6.14.5.gz | patch -p1 -R     # revert the 2.6.14.5 patch
> $ zcat ../patch-2.6.15.gz | patch -p1        # apply the new 2.6.15 patch
> $ cd ..
> $ mv linux-2.6.14.5 linux-2.6.15      # rename the kernel source dir

You never showed the step of downloading the patch.  That was done for
me too.  So if I would do it your way, and do what I did in those 14
steps...


====
rostedt@gandalf:~$ wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
--16:31:54--  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
           => `linux-2.6.14.tar.bz2'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 39,172,170 (37M) [application/x-bzip2]

100%[====================================>] 39,172,170   423.28K/s    ETA 00:00

16:33:19 (451.00 KB/s) - `linux-2.6.14.tar.bz2' saved [39172170/39172170]

rostedt@gandalf:~$ tar -xjf linux-2.6.14.tar.bz2
rostedt@gandalf:~$ cd linux-2.6.14
rostedt@gandalf:~/linux-2.6.14$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 14
EXTRAVERSION =
NAME=Affluent Albatross

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
rostedt@gandalf:~/linux-2.6.14$ wget http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.14.1.bz2
--16:35:55--  http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.14.1.bz2
           => `patch-2.6.14.1.bz2'
Resolving www.kernel.org... 204.152.191.37, 204.152.191.5
Connecting to www.kernel.org|204.152.191.37|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 2,808 (2.7K) [application/x-bzip2]

100%[====================================>] 2,808         --.--K/s

16:35:56 (79.00 KB/s) - `patch-2.6.14.1.bz2' saved [2808/2808]

rostedt@gandalf:~/linux-2.6.14$ bzcat patch-2.6.14.1.bz2 | patch -p1 -s
rostedt@gandalf:~/linux-2.6.14$ mv ../linux-2.6.14 ../linux-2.6.14.1
rostedt@gandalf:~/linux-2.6.14$ cd .
rostedt@gandalf:~/linux-2.6.14.1$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 14
EXTRAVERSION = .1
NAME=Affluent Albatross

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
rostedt@gandalf:~/linux-2.6.14.1$ bzcat patch-2.6.14.1.bz2 | patch -p1 -s -R
rostedt@gandalf:~/linux-2.6.14.1$ wget http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.14.5.bz2
--16:37:42--  http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.14.5.bz2
           => `patch-2.6.14.5.bz2'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 24,110 (24K) [application/x-bzip2]

100%[====================================>] 24,110        69.39K/s

16:37:43 (69.38 KB/s) - `patch-2.6.14.5.bz2' saved [24110/24110]

rostedt@gandalf:~/linux-2.6.14.1$ bzcat patch-2.6.14.5.bz2 | patch -p1 -s rostedt@gandalf:~/linux-2.6.14.1$ mv ../linux-2.6.14.1 ../linux-2.6.14.5
rostedt@gandalf:~/linux-2.6.14.1$ cd .
rostedt@gandalf:~/linux-2.6.14.5$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 14
EXTRAVERSION = .5
NAME=Affluent Albatross

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
rostedt@gandalf:~/linux-2.6.14.5$ bzcat patch-2.6.14.5.bz2 | patch -p1 -s -R
rostedt@gandalf:~/linux-2.6.14.5$ wget http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.15.bz2
--16:38:44--  http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.15.bz2
           => `patch-2.6.15.bz2'
Resolving www.kernel.org... 204.152.191.37, 204.152.191.5
Connecting to www.kernel.org|204.152.191.37|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 6,254,721 (6.0M) [application/x-bzip2]

100%[====================================>] 6,254,721    386.49K/s    ETA 00:00

16:39:02 (344.52 KB/s) - `patch-2.6.15.bz2' saved [6254721/6254721]

rostedt@gandalf:~/linux-2.6.14.5$ bzcat patch-2.6.15.bz2 | patch -p1 -s rostedt@gandalf:~/linux-2.6.14.5$ mv ../linux-2.6.14.5 ../linux-2.6.15
rostedt@gandalf:~/linux-2.6.14.5$ cd .
rostedt@gandalf:~/linux-2.6.15$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 15
EXTRAVERSION =
NAME=Sliding Snow Leopard

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
====

Here's the steps I did:

1) wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
2) tar -xjf linux-2.6.14.tar.bz2 
3) cd linux-2.6.14
4) head Makefile
5) wget http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.14.1.bz2
6) bzcat patch-2.6.14.1.bz2 | patch -p1 -s
7) mv ../linux-2.6.14 ../linux-2.6.14.1
8) cd .
9) head Makefile
10) bzcat patch-2.6.14.1.bz2 | patch -p1 -s -R
11) wget http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.14.5.bz2
12) bzcat patch-2.6.14.5.bz2 | patch -p1 -s
13) mv ../linux-2.6.14.1 ../linux-2.6.14.5
14) cd .
15) head Makefile
16) bzcat patch-2.6.14.5.bz2 | patch -p1 -s -R
17) wget http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.15.bz2
18) bzcat patch-2.6.15.bz2 | patch -p1 -s
19) mv ../linux-2.6.14.5 ../linux-2.6.15
20) cd .
21) head Makefile


22 steps is the equivalent of ketchup's 14, not to mention you need to
type a hell of a lot more, and remember where to download the patches
from.  Also, you need to manage the patches you download.

-- Steve

