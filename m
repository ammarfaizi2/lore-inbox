Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270730AbTHJWeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270739AbTHJWeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:34:37 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:2030 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S270730AbTHJWe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:34:28 -0400
Date: Mon, 11 Aug 2003 00:34:21 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre10-ac1
Message-ID: <20030810223421.GA14873@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <200308021229.h72CT5128965@devserv.devel.redhat.com> <1059831754.22190.102.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059831754.22190.102.camel@pegasus>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 03:42:27PM +0200, Marcel Holtmann wrote:
> Hi Alan,
> 
> > > not quite true. If hotplug is not enabled it tells the driver that the
> > > firmware can't be loaded. It is the same if hotplug_path is zero, or you
> > 
> > The ifdef should be there, or firmware should depend on hotplug, and
> > probably the firmware users should also depend on hotplug
> 
> I definitively prefer the #ifdef, because the firmware loader should 
> automaticly selected and compiled if a driver needs it. But let a driver
> depend on hotplug can not be the solution, because some drivers maybe
> also work if the firmware loading fails.

 I don't find it necessary, but if you have so much interest, you have my
 blessing.

 Though I would instead put the #ifdef's in "linux/firmware.h" providing
 dummy inlines. Having to load a useless firmware_class.o seams a little
 overkill, and that way you also make it possible to compile
 request_firmware dependent code without CONFIG_FW_LOADER.

 Oh, and feel free to do the same for the 2.6 series :-)

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
