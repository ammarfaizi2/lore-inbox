Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131011AbRCFQeI>; Tue, 6 Mar 2001 11:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131010AbRCFQd7>; Tue, 6 Mar 2001 11:33:59 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:16349 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S131009AbRCFQdq>;
	Tue, 6 Mar 2001 11:33:46 -0500
Date: Tue, 6 Mar 2001 17:33:37 +0100
From: David Weinehall <tao@acc.umu.se>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: mshiju@in.ibm.com, linux-kernel@vger.kernel.org, linux-mca@vger.kernel.org
Subject: Re: Linux installation problem
Message-ID: <20010306173337.C21941@khan.acc.umu.se>
In-Reply-To: <CA256A07.00341167.00@d73mta05.au.ibm.com> <3AA50CE8.2EA86CD@coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3AA50CE8.2EA86CD@coplanar.net>; from jerj@coplanar.net on Tue, Mar 06, 2001 at 11:14:32AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 11:14:32AM -0500, Jeremy Jackson wrote:
> mshiju@in.ibm.com wrote:
> 
> > Hi all,
> > I am trying to install Linux (redhat-7) on a ps/2
> > server-9595 machine (mca ). I am booting from a floppy
> > disk and using a custom build 2.4.1 kernel image since
> > there are problems  booting  the machine using the
> > installation image on  redhat CD and also it is not CD
> > bootable. The problem is that after booting it asks for
> > redhat CDROM and when I insert the redhat CDROM it gives
> > a message "I could not find a redhat linux CDROM in any
> > of your CDROM drives ". The CD drive is a SCSI device and
> > I have enabled SCSI cdrom in kernel compilation . Can any
> > one help me .
> >
> > Thanks & Regards
> > Shiju
> 
> Hi,
> 
> I have a type 8560 PS/2... not the same as yours but I did install
> slackware on it once.

8560? Isn't that a 286?! Is it processor-upgraded?

> I would suggest installing from a standard PC.  Boot disks are very
> inflexible, since you don't have any utilities to poke around and
> figure out what's going on.

> Once you have a complete root filesystem, once you've got a kernel to
> recognise your scsi adapter, (and disk), you're off to the races, and
> can use all kinds of tools to look into the CDROM problem...BUT
> 
> it's probably not going to recognise the disk either...
> 
> check different virtual consoles with alt-f1, f2, etc: under a normal
> redhat boot disk, the different vc's will have diagnostic messages, ie
> kernel messages, list of modules being loaded, etc.
> 
> maybe the best way is to be sure to compile kernel with support for
> scsi subsystem *in kernel* - not module, along with scsi-disk,
> scsi-cdrom, and your scsi host adapter.  the last one may be the
> tricky one.  you will have to figure out if it is supported.  (the one
> in my PS/2 is at least for 2.0 kernel)

The 8595 either has an IBM FAST SCSI/2 (uses ibmmca) or an FD
MCS-600/700 (uses fd_mcs).

> if you can make the kernel on the boot disk use a smaller font,
> you will be able to see more of the messages at once.
> 
> also, shift-PgUp should let you scroll back some of the messages.
> look for the kernel messages from your scsi host adapter driver...
> if you don't see any there's a problem!
> 
> take a look inside your box and see what kind of scsi adapter it has.
> or use your reference disk to see what it is.  post that here
> so someone (maybe me) can check for kernel support.

I've never ever installed any of my MCA-machines from CD, only using the
a couple of boot-disks and installing the rest via net.

Oh, and for that matter, I've never installed Red Hat either, but that
shouldn't matter.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
