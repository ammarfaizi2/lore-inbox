Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284866AbRLSJey>; Wed, 19 Dec 2001 04:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLSJep>; Wed, 19 Dec 2001 04:34:45 -0500
Received: from pcow024o.blueyonder.co.uk ([195.188.53.126]:11017 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S284866AbRLSJeb>;
	Wed, 19 Dec 2001 04:34:31 -0500
Message-ID: <T57eadc70a6ac1785e2316@pcow024o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Alexander Viro'" <viro@math.psu.edu>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Wed, 19 Dec 2001 09:34:49 +0000
X-Mailer: KMail [version 1.3.1]
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 December 2001 7:50 pm, Grover, Andrew wrote:
> > From: Alexander Viro [mailto:viro@math.psu.edu]
> >
> > On Tue, 18 Dec 2001, Grover, Andrew wrote:
> > > GRUB 0.90 does this today.
> >
> > ... and I'm quite sure that EMACS could do it easily.  Let's not talk
> > about GNU bloatware, OK?
>
> I don't think this is bloatware, especially considering there really isn't
> any cost for having a full-featured bootloader - all its footprint gets
> reclaimed, after all.

Not on disk it doesn't. When you're booting from a floppy (distro 
installation, recovery disk, whatever) you only have 1.something Mb to play 
with. Or a network. For that matter, you're complicating CD booting too.

> I respect lilo and its cousins, but they make things
> harder than they have to be. Why maintain a reduced level of functionality
> (software emaciation?) when better alternatives are available?

Not "better". More features/bloat - and when they are "features" most of us 
neither need nor want, why bother? Lilo does everything most of us need, and 
does it better than grub or others: same job with fewer resources.

> > Except that in this case it doesn't make anything simpler.
>
> Implicit in the use of initrd is that you have to *make a ramdisk image*,
> and then tell your bootloader to load it. If you have a bootloader that can
> load multiple images (i.e. the modules themselves) you can skip the first
> step.

Initramfs will do this, it seems. Alternatively, you might have to copy some 
files into a tarball - oh, the stress! Oh, wait - you just compiled 100+Mb of 
C source to make that kernel and the modules. Somehow, making a tarball out 
of the modules doesn't seem too stressful to me.

> > BTW, we don't need a special device to handle initrd after that.  Just
> > have your initrd image (gzipped, whatever) in the archive
> > under /initrd.
> > After that /init will have the contents in that file (regular file, at
> > that) and can do whatever it bloody wants.
>
> Again, even the new scheme will still involve the creation of an initrd.
> I'm saying, as a user, it would be easier for me to not do this, and just
> modify a .conf file to have the driver loaded early-on.

OK, make the conf file a shell script which copies the modules into a tarball 
or initrd image.

> I'm not arguing that the new initrd won't be better than the old initrd
> (because obviously you are right) I'm arguing that no matter how whizzy
> initrd is, it's still an unnecessary step, and it's one that other OSs
> (e.g. FreeBSD) omit in favor of the approach I'm advocating.

Feeping creaturism in the bootloader, you mean? Great... while we're at it, 
how about building gcc, make, tar and gzip into the bootloader, along with an 
FTP client, so it can download and compile the kernel to boot? Chuck in a 
copy of emacs, too, for any changes you want?

You're already compiling the modules from C into .o files; what's the big 
deal with copying them into a tarball?!

> > IOW, we are backwards compatible with old
> > loaders.
>
> No progress will ever be made if we cater to the lowest common denominator.

You're right. Let's drop x86 support, and require everyone to buy a nice new 
POWER4 box from IBM.


James.
