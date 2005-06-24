Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263342AbVFXWEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263342AbVFXWEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbVFXWEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:04:34 -0400
Received: from smtp04.auna.com ([62.81.186.14]:39136 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S263266AbVFXVzY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:55:24 -0400
Date: Fri, 24 Jun 2005 21:55:22 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
To: linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com>
	<20050624190513.GA1046@mikebell.org>
In-Reply-To: <20050624190513.GA1046@mikebell.org> (from mike@mikebell.org on
	Fri Jun 24 21:05:15 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119650122l.7970l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Fri, 24 Jun 2005 23:55:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.24, Mike Bell wrote:
> On Fri, Jun 24, 2005 at 01:18:08AM -0700, Greg KH wrote:
> > Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
> > tiny:
> ...
> > replacement for devfs for those embedded users who just can't live
> > without the damm thing.  It doesn't allow subdirectories, and only uses
> > LSB compliant names.  But it works, and should be enough for people to
> > use, if they just can't wean themselves off of the idea of an in-kernel
> > fs to provide device nodes.
> 
> As far as ideas go, this is pretty much all I asked for. A simple kernel
> filesystem to export device nodes with names, rather than just the
> numbers as sysfs does. The "detecting non-existant device names" thing
> never meant anything to me personally, and if anyone does care this
> gives them a simple place to add such a hook - unlike device names I
> don't see why such a thing would be difficult to maintain as a patch.
> 

I had always asked for the simpler and minimal /dev to let a system boot
and reach udev start, and I think this is even better !!

> 
> What's the method for bootstrapping this filesystem onto a system? Is
> a mount from early userspace the only way you'd accept, or would a
> kernel parameter to automount over /dev as devfs does be tolerable?
> 

I got sad when I read I did not support directories and so on, because
that meant I could not run udev on it, but I have thought
on an alernative for early userspace:
- mount ndevfs on /mnt
- cp -a /mnt /dev
- umount /mnt
- let init run /etc/rc.d/rc till it gets to mount /dev and start udev

Just a question (kinda newbie's question):

Does ndevfs to be mounted when a device is detected ? Or will it show
all the registered devices when mounted ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam2 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


