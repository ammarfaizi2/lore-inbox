Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130120AbQLNDYE>; Wed, 13 Dec 2000 22:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130613AbQLNDXo>; Wed, 13 Dec 2000 22:23:44 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:65285 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S130120AbQLNDXe>;
	Wed, 13 Dec 2000 22:23:34 -0500
Date: Wed, 13 Dec 2000 20:53:37 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012132050140.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012132043350.24483-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Err... how about this:  Give me two or three kORBit syscalls and I can get
> > rid of all the other 100+ syscalls!  :) 

> Like it ioctl() does it? Number of entry points is _not_ an issue. Diversity
> of the API is. Technically, kernel has 1 (_o_n_e_) entry point as far as
> userland is concerned. int 0x80 on x86. Can't beat that, can you?

Err shame on you, don't forget about lcall and exceptions, and interrupts,
and... That is technically more than _o_n_e_ "entry point".  :)  Oh wait,
what about sysenter/exit too? :)

No I can't beat that.  But if you look at the hack job of a system call
table we have, you can see that there is no _really_ standard way of
passing parameters.  Oh sure, most of the time, stuff is passed in
registers.  Sometimes we get a pointer to an argument struct.  Because of
this wonderful design we get all kinds of stuff like sys_oldumount vs
sys_umount and others...

> Yes, standard RPC mechanism would be nice. No, CORBA is not a good candidate -
> too baroque and actually known to lead to extremely tasteless APIs being
> implemented over it. Yes, I mean GNOME. So sue me.

Hrm... because I'm stupid, please explain how CORBA is too baroque...  I
have no problem with you not liking GNOME... you're a kernel hacker, so
you're not supposed to like GUI's.  :)  [just kidding!!!] CORBA doesn't
preclude nasty APIs any more than C does.  It also doesn't preclude *nice*
APIs that are upgradable and extensible in the future (and that means
without breaking backwards compatibility).  Please don't tell me that OOP
is bad... or else we will have the eviscerate the VFS layer from the
kernel (amount other subsystems)... :)

> I would take 9P over that any day, thank you very much.

Like I mentioned in a previous email, CORBA does not preclude 9P.  What
it does buy you though, is compatibility with LOTS of preexisting CORBA
tools.  How much development infrastructure is there for 9P?  I thought
so.  :)

For one of our demos, we ran a file server on a remote linux box (that we 
just had a user account on), mounted it on a kORBit'ized box, and ran
programs on SPARC Solaris that accessed the kORBit'ized linux box's file
syscalls.  If nothing else, it's pretty nifty what you can do in little
code...

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
