Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284868AbRLRTwq>; Tue, 18 Dec 2001 14:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284944AbRLRTvZ>; Tue, 18 Dec 2001 14:51:25 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:63211 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S284916AbRLRTuw>; Tue, 18 Dec 2001 14:50:52 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alexander Viro'" <viro@math.psu.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: RE: Booting a modular kernel through a multiple streams file
Date: Tue, 18 Dec 2001 11:50:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alexander Viro [mailto:viro@math.psu.edu]
> On Tue, 18 Dec 2001, Grover, Andrew wrote:
> > GRUB 0.90 does this today.
> ... and I'm quite sure that EMACS could do it easily.  Let's not talk
> about GNU bloatware, OK?

I don't think this is bloatware, especially considering there really isn't
any cost for having a full-featured bootloader - all its footprint gets
reclaimed, after all. I respect lilo and its cousins, but they make things
harder than they have to be. Why maintain a reduced level of functionality
(software emaciation?) when better alternatives are available?

> Except that in this case it doesn't make anything simpler.

Implicit in the use of initrd is that you have to *make a ramdisk image*,
and then tell your bootloader to load it. If you have a bootloader that can
load multiple images (i.e. the modules themselves) you can skip the first
step.

> BTW, we don't need a special device to handle initrd after that.  Just
> have your initrd image (gzipped, whatever) in the archive 
> under /initrd.
> After that /init will have the contents in that file (regular file, at
> that) and can do whatever it bloody wants.

Again, even the new scheme will still involve the creation of an initrd. I'm
saying, as a user, it would be easier for me to not do this, and just modify
a .conf file to have the driver loaded early-on.

I'm not arguing that the new initrd won't be better than the old initrd
(because obviously you are right) I'm arguing that no matter how whizzy
initrd is, it's still an unnecessary step, and it's one that other OSs (e.g.
FreeBSD) omit in favor of the approach I'm advocating.

> IOW, we are backwards compatible with old
> loaders.

No progress will ever be made if we cater to the lowest common denominator.

Regards -- Andy
