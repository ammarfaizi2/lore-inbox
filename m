Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVBOHQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVBOHQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 02:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVBOHQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 02:16:46 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:37429 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261643AbVBOHQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 02:16:42 -0500
Date: Mon, 14 Feb 2005 23:14:51 -0800
From: Greg KH <gregkh@suse.de>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050215071252.GA21616@suse.de>
References: <20050211004033.GA26624@suse.de> <420D1050.3080405@t-online.de> <20050211210114.GA21314@suse.de> <420DBEBE.1060008@t-online.de> <20050214223613.GB13110@suse.de> <42118B19.8000106@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42118B19.8000106@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 06:39:37AM +0100, Harald Dunkel wrote:
> Greg KH wrote:
> >On Sat, Feb 12, 2005 at 09:30:54AM +0100, Harald Dunkel wrote:
> >
> >>
> >>If it is not possible to use klibc together with a non-Linux
> >>system (e.g. FreeBSD or Mach), then I would suggest to make
> >>klibc an optional kernel patch and drop it from udev and
> >>hotplug.
> >
> >
> >But it is not possible to use udev or hotplug-ng on a non-Linux system,
> >right?
> >
> 
> Thats not the point. The point is to remove the copy of the
> klibc sources from packages like udev and hotplug-ng and
> to use the existing klibc sources or binaries on the target
> system instead. Just to keep it modular.

Again, my point is I'll take klibc out of the udev and hotplug-ng trees
when it is actually on people's systems because it is in the kernel
source tree.  Until that happens I'll continue to keep it in the udev
and hotplug-ng trees, ok?

> >As far as "optional kernel patch"?  What do you mean?  People are
> >working on adding klibc to the main kernel tree, nothing optional about
> >that.
> >
> 
> I do not know the internals of klibc that much. Is it possible
> to use klibc on non-Linux systems, e.g. on Mach or FreeBSD?
> Maybe by adding some #ifdefs to klibc's kernel interface?

I don't know, and I really don't care :)

> If yes, then making klibc an integrated part of the Linux
> kernel source tree and dropping the independent development
> tree would be a restriction to the use of klibc.

Huh?  You are free to take klibc and do whatever you want to with it
based on the license it has.  No one is restricting you from doing that,
right?

> AFAIK the plan for initramfs is to move as much functionality
> as possible from kernel to user space.

Yes.

> Why not do the same
> thing for the sources? Everything that is supposed to be run
> in user space could be removed from the kernel source tree
> and managed seperately, either in a set of userspace modules
> like klibc, hotplug, udev, initramfs, etc., or in a monolithic
> "userspace-tools" source tree.

Because we still want to actually be able to boot a kernel, right?  :)

Let's just get the early boot stuff building and working properly, and
then we'll worry about ripping the stuff out of the kernel tree then.

> Surely klibc belongs to the user space.

Hm, like the other things in the kernel source tree that are also only
in userspace?  :)

thanks,

greg k-h
