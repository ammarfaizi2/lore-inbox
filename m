Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPExp>; Fri, 15 Dec 2000 23:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLPExf>; Fri, 15 Dec 2000 23:53:35 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:5380 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129183AbQLPExZ>; Fri, 15 Dec 2000 23:53:25 -0500
Date: Fri, 15 Dec 2000 20:22:50 -0800 (PST)
From: ferret@phonewave.net
To: richard offer <offer@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: What about 'kernel package'? was: Re: Linus's include file strategy redux
In-Reply-To: <10012151850.ZM22906@sgi.com>
Message-ID: <Pine.LNX.3.96.1001215201402.19208F-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, richard offer wrote:

> In article <91e0vj$b6alr$1@fido.engr.sgi.com> you write:
> >In article <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com>,
> >LA Walsh <law@sgi.com> wrote:
> >>It was at that
> >>point, the externally compiled module "barfed", because like many modules,
> >>it expected, like many externally compiled modules, that it could simply
> >>access all of it's needed files through /usr/include/linux which it gets
> >>by putting /usr/include in it's path.  I've seen commercial modules like
> >>vmware's kernel modules use a similar system where they expect
> >>/usr/include/linux to contain or point to headers for the currently running
> >>kernel.
> >
> >vmware asks you nicely
> >
> >where are the running kernels include files [/usr/src/linux/include" >
> >
> >And then compiles the modules with -I/path/to/include/files
> >
> >In fact, the 2.2.18 kernel already puts a 'build' symlink in
> >/lib/modules/`uname -r` that points to the kernel source,
> >which should be sufficient to solve this problem.. almost.
> 
> Don't get me started on that... The link points back to where the code
> was when it was built, not where it is installed. This makes a difference
> if you're building RPMs... in which case the link points back to (for
> example) /usr/src/sgi/BUILD/linux-<version> and not
> /usr/src/linux-<version>/.
> 
> And, top it all... once the build is completed the BUILD directory
> is deleted.
> 
> 
> Good Idea, but poorly thought out.
[snip]

Once again, I'd like to suggest Debian's kernel package system as a good
working example of this sort of administrative-level kernel management. I
brought this up on the list once before, maybe eight months ago, but I
recall not even one reply worth of discussion about it. I have a fairly
basic idea of what could be done to merge part of 'make-kpkg' into the
kernel-side management, but I'd like to see some other trained eyeballs
taking a look.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
