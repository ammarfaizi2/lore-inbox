Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWGHOaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWGHOaz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWGHOaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:30:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59092 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964857AbWGHOay
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:30:54 -0400
Subject: Re: Opinions on removing /proc/tty?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607080712y248f61b9q7444b754516c4d6a@mail.gmail.com>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
	 <1152344452.7922.11.camel@Homer.TheSimpsons.net>
	 <9e4733910607080712y248f61b9q7444b754516c4d6a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 08 Jul 2006 15:48:22 +0100
Message-Id: <1152370102.27368.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-08 am 10:12 -0400, ysgrifennodd Jon Smirl:
> > ps uses /proc/tty/drivers, so some coordination would be needed.
> 
> Greg, I just looked at the source for ps and it has a bunch of fixed
> code for turning major/minor into /dev/name.  Isn't that something
> udevinfo should be doing? But looking at the help for udevinfo I don't
> see any way to turn a major/minor into /dev/name. The altermative
> seems to be search /dev looking for the right device node.

ps has some historical baggage in this area that probably ought to go,
but /proc/tty is used by various installers and management type apps so
shouldn't be going anywhere in a hurry.

Some of the stuff in there would be better in sysfs had sysfs been
around at the time. Other stuff like firmware loading in the serial
drivers would really benefit from a move to sysfs and hotplug events too

