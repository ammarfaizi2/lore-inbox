Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUAGTYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUAGTYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:24:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:62850 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266177AbUAGTYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:24:40 -0500
Date: Wed, 7 Jan 2004 11:24:34 -0800
From: Greg KH <greg@kroah.com>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107192434.GA823@kroah.com>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107185656.GB31827@kroah.com> <3FFC5CBB.5050507@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FFC5CBB.5050507@kolumbus.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 09:23:39PM +0200, Mika Penttilä wrote:
> Greg KH wrote:
> >On Wed, Jan 07, 2004 at 10:38:31AM -0800, Linus Torvalds wrote:
> >>And it really has to create _all_ of them, exactly because there's no way
> >>to know ahead-of-time which of them will be available.
> >>
> >>Then, user space can just access "/dev/sda1" or whatever, and the act of 
> >>accessing it will force the re-scan.
> >>   
> >>
> >
> >Hm, that would work, but what about a user program that just polls on
> >the device, as the rest of this thread discusses?  As removable devices
> >are not the "norm" it would seem a bit of overkill to create 16
> >partitions for every block device, if they need them or not.
> >
> Accessing the partition would not cause the rescan (accessing the whole 
> disk causes.) I think devfs does/did this rescan on access.

It would rescan on access of a partition or the main block device?

If accessing the partition doesn't work, than having udev create all
partitions wouldn't help anything :(

thanks,

greg k-h
