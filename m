Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbULKPjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbULKPjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbULKPjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:39:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:12782 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261943AbULKPjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:39:40 -0500
Date: Sat, 11 Dec 2004 07:39:22 -0800
From: Greg KH <greg@kroah.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [Announce] Squashfs 2.1 released (compressed filesystem)
Message-ID: <20041211153922.GA29523@kroah.com>
References: <41BA0245.4050502@lougher.demon.co.uk> <20041211013323.GA12796@kroah.com> <41BA825F.9040509@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BA825F.9040509@lougher.demon.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 05:15:11AM +0000, Phillip Lougher wrote:
> Greg KH wrote:
> >On Fri, Dec 10, 2004 at 08:08:37PM +0000, Phillip Lougher wrote:
> >
> >>I'm pleased to announce the release of Squashfs 2.1.
> >
> >
> >Are you going to submit this fs for inclusion in the main kernel tree?
> >I'm getting tired of maintaining it as part of the Gentoo kernel patch
> >set :)
> 
> Good question...  When I originally released Squashfs (Oct 2002) the 2.5 
> kernel had just gone into the feature freeze and I was waiting for the 
> unfreeze that would happen when 2.7 arrived.  As the official stance on 
> additions to 2.6 has been relaxed I have thought about submitting it.
> 
> I need to tidy up the code a bit before I submit it to the merciless 
> scrutiny of LKML :-)  Nothing bad (I hope) but there's lots of long 
> lines and I do know LKML'mers like 80 columns.
> 
> I'm planning on adding ea/acl support (people have been asking for 
> them), I can't decide whether to submit it now or wait until I've 
> finished them.  Suggestions and advice would be welcome.

Submit it now, it's self contained (doesn't patch anything outside it's
own directory), and is useful in it's current state for a lot of people.

> Slightly off topic, I've noticed you're the kernel maintainer for 
> Gentoo.  You mentioned somewhere you're down to 4 kernel patches, 
> including Squashfs? :)

Yes, squashfs is one of the four non-bugfix patches in the Gentoo kernel
2.6 kernel package.  

For those who are interested, the other three are:
	- fbsplash, the "next-gen" version of bootsplash.  No more image
	  decoders in kernelspace (compared to bootsplash), and a few
	  more features.
	- speakup, a driver package for visually-impaired users.
	- vesafb-tng, a "next-gen" version of vesafb-tng.
	- inotify.

Ok, there are now 5 patches, I forgot we addeed inotify recently to make
the Gnome developers happy.

> A lot of people/projects are now using Squashfs and it would help a
> lot of people (and me) if it did get into the kernel.  Plus it would
> be a nice thing for me anyway to have finally got it included.

I agree, it would also reduce your workload of keeping an
out-of-the-kernel fs patchset.

thanks,

greg k-h
