Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUBJRrX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUBJRrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:47:05 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:59276 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S266118AbUBJRpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:45:36 -0500
Date: Tue, 10 Feb 2004 09:46:04 -0800
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210174603.GL4421@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210172552.GB27779@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 09:25:52AM -0800, Greg KH wrote:
> No that is not what sysfs is about at all.  sysfs exports the internal
> device tree that the kernel knows so that userspace can use this
> information for all sorts of different things (proper power management,
> etc.)  Please go read all of the sysfs and driver model documentation
> (and OLS and linux.conf.au papers) for more details about what sysfs and
> the driver core is all about.

I think you still misunderstand what I'm saying. All I'm saying is that
with either way, kernel is exporting three pieces of information (b/c,
major, minor) to userspace through file(s) on an artificial filesystem.
That's it. I know what sysfs is for, I like sysfs the way it is, I'm not
saying sysfs should be changed in any way. I'm saying that to create a
device with a given name, udev uses magic files exported by the kernel,
and devfsd uses magic file(s) exported by the kernel, and in both cases
they contain the same information. And hence in that sense devfs and
udev are the same. That's it.

What I'm trying to explain by that point is that udev is no more "naming
policy in the kernel" free than devfsd. devfsd relies on devfs, which
has naming policy in the kernel. udev relies on sysfs, which has naming
policy in the kernel. While devfs and sysfs are radically different,
they serve the same purpose for devfsd/udev.

> And claiming udev as "a sort of ugly-hack devfsd" is pretty harsh.
> Given that udev uses a documented, open interface, and easily allows
> _any_ program to run from it, no matter what the language.  Try reading
> the devfsd code some time, or getting it to run your perl script to name
> a single type of device :)

That's something udev does pretty well, and not quite what I meant. I
like devfs, defined for the time being as a working tree of device files
exported by the kernel as a virtual filesystem. For managing
permissions, user-space-dictated device names, and whatever else, I
don't care if you call it devfsd or udev or whatever else. I don't like
udev primarily because it tries to do the job without the help of a
devfs, and I think trying to do that makes it ugly.

> If you like devfs, fine, use it.  If you don't, take a look at udev.

Which was the point of my email. "Hey, I like devfs over udev. Am I
alone in this, or are there others?" As I stated at the start.
