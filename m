Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUABST2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 13:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbUABST2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 13:19:28 -0500
Received: from CPE-24-163-213-29.mn.rr.com ([24.163.213.29]:47810 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S265548AbUABST1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 13:19:27 -0500
Subject: Re: udev and devfs - The final word
From: Shawn <core@enodev.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <pan.2004.01.02.17.52.48.455285@dungeon.inka.de>
References: <20031231002942.GB2875@kroah.com>
	 <pan.2004.01.02.17.52.48.455285@dungeon.inka.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073067563.1073.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 12:19:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me begin by pointing out that I was a proponent of devfs from when
it first got written.

On Fri, 2004-01-02 at 11:54, Andreas Jellinghaus wrote:
> On Wed, 31 Dec 2003 00:32:58 +0000, Greg KH wrote:
> > The Problems:
> >  1) A static /dev is unwieldy and big.  It would be nice to only show
> >     the /dev entries for the devices we actually have running in the
> >     system.
> neither devfs nor udev handle the virtual part. only devpts does, 
> and only for one special class of virtual devices. and usb devices
> are neither handled by devfs nor udev, but by usbfs.
I'm thinking maybe this is just fine.

> Actually udev is a regression:
>  - devfs was a first efford at a sane /dev naming policy, udev returns to
>    the old and cryptic lsb device naming.
Every way of doing things is just another say of doing it. Location
based naming has it's major issues. It's solved by UUID or LABEL, so
device naming is just a matter of preference anyway. You can change it
with udev, IIRC. You could not with devfs. Chances are you use devfsd
anyway, right?

>  - devfs made makedev obsolete, udev doesn't work without it / can
>    currently not create all devices because of missing sysfs support.
No one is saying it is currently perfect for everyone, however, it suits
many people just fine. devfs went through the same thing and this is an
invalid argument when debating the technical merit of either.

> Ignore this mail if you want, but people might be unhappy with udev
> because of these regressions and not caring about it will not improve
> the situation.
By the time devfs goes away enough testing will have happened. Don't
look for it to go away within 2.6.
