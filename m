Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133101AbRDWNz4>; Mon, 23 Apr 2001 09:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133120AbRDWNzq>; Mon, 23 Apr 2001 09:55:46 -0400
Received: from penguin.roanoke.edu ([199.111.154.8]:44042 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S133101AbRDWNzh>; Mon, 23 Apr 2001 09:55:37 -0400
Message-ID: <3AE4374D.F3A60F95@linuxjedi.org>
Date: Mon, 23 Apr 2001 10:08:13 -0400
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: linux-kernel@vger.kernel.org, ingo.oeser@informatik.tu-chemnitz.de,
        viro@math.psu.edu
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <3AE307AD.821AB47C@linuxjedi.org> <m3r8yjrgdc.fsf@linux.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:
> 
> Hi David,
> 
> On Sun, 22 Apr 2001, David L. Parsley wrote:
> > I'm still working on a packaging system for diskless
> > (quasi-embedded) devices.  The root filesystem is all tmpfs, and I
> > attach packages inside it.  Since symlinks in a tmpfs filesystem
> > cost 4k each (ouch!), I'm considering using mount --bind for
> > everything.
> 
> What about fixing tmpfs instead?

That would be great - are you volunteering? ;-)  Seriously - I might be
able to look at what ramfs does and port that to tmpfs for my needs, but
that's about the extent of my kernel hacking skills.  For now, mount
--bind looks like it'll work just fine.  If somebody wants to fix tmpfs,
I'll be happy to test patches; it'll just change a couple of lines in my
package loading logic (mount --bind x y -> ln -s x y).

What I'm not sure of is which solution is actually 'better' - I'm
guessing that performance-wise, neither will make a noticable
difference, so I guess memory usage would be the deciding factor.  If I
can get a lot closer to the size of a symlink (10-20 bytes) that would
be best.  The issue with /proc/mounts really shouldn't hurt anything - I
could almost get by without mounting /proc anyway, it's mainly a
convenience.

regards,
	David

-- 
David L. Parsley
Network Administrator
Roanoke College
