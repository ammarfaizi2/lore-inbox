Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUAGLBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUAGLBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:01:36 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:2320 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266185AbUAGLB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:01:28 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Jens Axboe <axboe@suse.de>, Olaf Hering <olh@suse.de>
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Date: Wed, 7 Jan 2004 14:00:46 +0300
User-Agent: KMail/1.5.3
Cc: Andries Brouwer <aebr@win.tue.nl>, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200401012333.04930.arvidjaar@mail.ru> <20040107094321.GC21059@suse.de> <20040107095029.GX3483@suse.de>
In-Reply-To: <20040107095029.GX3483@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401071400.46286.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 January 2004 12:50, Jens Axboe wrote:
> > > So yeah, poll...
> >
> > Poll how? "kmediachangethread"? Or polling in userland? The latter would
> > (probably) lead to endless IO errors. Not very good.
>
> No need to put it in the kernel, user space fits the bil nicely.

unfortunately opening device in userland effectively locks tray making media 
change impossible. at least given current ->open semantic.

even periodic access is quite annoying for users (tray closing while user 
attempts to insert CD)

we may agree that O_NDELAY does not affect locked state; currently this is not 
consistent across drivers (e.g. cdrom does not lock tray while sd does)


