Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157445AbQHACUc>; Mon, 31 Jul 2000 22:20:32 -0400
Received: by vger.rutgers.edu id <S160064AbQHACUW>; Mon, 31 Jul 2000 22:20:22 -0400
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:4791 "HELO t1.ctrl-c.liu.se") by vger.rutgers.edu with SMTP id <S157631AbQHACSm>; Mon, 31 Jul 2000 22:18:42 -0400
Date: 1 Aug 2000 02:30:27 -0000
Message-ID: <20000801023027.23228.qmail@t1.ctrl-c.liu.se>
From: wingel@t1.ctrl-c.liu.se
To: dalgoda@ix.netcom.com
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Newsgroups: linux.kernel
In-Reply-To: <20000731211810.B28169@thune.mrc-home.org>
References: <7iw6kYsXw-B@khms.westfalen.de> <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com>
Organization: 
Sender: owner-linux-kernel@vger.rutgers.edu

In article <20000731211810.B28169@thune.mrc-home.org> dalgoda@ix.netcom.com wrote:
>On Mon, Jul 31, 2000 at 03:13:55PM -0700, H. Peter Anvin wrote:
>> Unfortunately that doesn't work very well.  For user-space daemons
>> which talk to Linux-specific kernel interfaces, such as automount, you
>> need both the glibc and the Linux kernel headers.
>
>Does this mean that automount has to be rebuilt for every kernel?  And that
>we should be running /lib/modules/`uname -r`/sbin/automount.
>
>It's sounds like it's an awful lot like a loadable module in how tightly
>it's tied to the kernel.  And how a kernel change can break things
>horribly.  How you have to be built against the one you're going to run
>against and not the one glibc was built against.

It only means that the application will be built agains the kernel 
_interface_ that was present in that version of the kernel.  And 
syscall/ioctl interfaces should never change, they can be added to,
and relly old depreciated interfaces can be removed, but they should
be stable for at least a few major kernel releases.

  /Christer
-- 
"Just how much can I get away with and still go to heaven?"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
