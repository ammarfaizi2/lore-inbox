Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUJJWA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUJJWA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUJJWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 18:00:59 -0400
Received: from goliath.sylaba.poznan.pl ([193.151.36.3]:51216 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S268529AbUJJWA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 18:00:57 -0400
Subject: Re: How to umount a busy filesystem?
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041010211208.GA6986@citd.de>
References: <1097441558.2235.9.camel@venus>  <20041010211208.GA6986@citd.de>
Content-Type: text/plain
Message-Id: <1097445655.2235.18.camel@venus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Oct 2004 00:00:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 23:12, Matthias Schniedermeyer wrote:
> On 10.10.2004 22:52, Olaf Fr?czyk wrote:
> > Hi,
> > 
> > Why I cannot umount filesystem if it is being accessed?
> > I tried MNT_FORCE option but it doesn't work.
> > 
> > Killing all processes that access a filesystem is not an option. They
> > should just get an error when accessing filesystem that is umounted.
> > 
> > Any idea how to do it?
> 
> umount -l
> 
> removes the mount in "lazy"-mode, this way the mount-point "vanishes"
> for all programs whose working-dirs aren't "within" that mount-point.
> After all files are closed the filesystem is unmounted totally.
> You can "reuse" the mount-point immediatly.
> 
Thank you.
But this:
1. Does not let the user to remove the media (eg. cdrom).
2. Does not flush buffers etc. so the media cannot be safely removed
even if it were physically possible (eg. cdrom with unlocked tray or
USB-key).

I have read that the MNT_FORCE is currently limited to NFS mounts.
Does somebody have any idea why it is limited? 
Or is the functionality planned for other filesystems too?

Regards,

Olaf

