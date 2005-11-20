Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVKTWbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVKTWbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVKTWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:31:48 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:55079 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932098AbVKTWbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:31:47 -0500
Subject: Re: make kernelrelease ignoring LOCALVERSION_AUTO
From: Kasper Sandberg <lkml@metanurb.dk>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us>
References: <m3acfz88qj.fsf@lugabout.cloos.reno.nv.us>
Content-Type: text/plain
Date: Sun, 20 Nov 2005 23:31:38 +0100
Message-Id: <1132525898.15938.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-20 at 13:39 -0500, James Cloos wrote:
> I use $(make kernelrelease) in my kernel install script to get the
> version string for the filenames in /boot and the grub menu items.
> 
> The partial hash string CONFIG_LOCALVERSION_AUTO=y adds is no longer
> showing up in the version kernelrelease echos, although it does show
> up in the version string used by $(make modules_install).
> 
> I even added an @echo $MODLIB to the kernelrelease rule and got only:
> 
> ,----
> | :; make kernelrelease
> | 2.6.15-rc2-lug2
> | /lib/modules/2.6.15-rc2-lug2
> `----
<snip>
i dont know anything about this, but if it is a bug, it should be fixed,
however, in the meantime, this might help you: (its what i do in my
kernel install script)
eval $(head -n 4 Makefile | sed -e 's/ //g')

then in bash you can do this:
FULLVER=${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}

hope it might help
> 
> -JimC

