Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbTA1UD1>; Tue, 28 Jan 2003 15:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbTA1UD1>; Tue, 28 Jan 2003 15:03:27 -0500
Received: from smtp.terra.es ([213.4.129.129]:40664 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id <S267672AbTA1UDZ>;
	Tue, 28 Jan 2003 15:03:25 -0500
Date: Tue, 28 Jan 2003 21:11:45 +0100
From: Arador <diegocg@teleline.es>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: alan@lxorguk.ukuu.org.uk, stepan@suse.de, raphael@arrivingarrow.net,
       linux-kernel@vger.kernel.org
Subject: Re: Bootscreen
Message-Id: <20030128211145.16535d60.diegocg@teleline.es>
In-Reply-To: <20030128174138.GB2233@arthur.ubicom.tudelft.nl>
References: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
	<20030128121048.GB32488@suse.de>
	<1043765442.8675.2.camel@dhcp22.swansea.linux.org.uk>
	<20030128174138.GB2233@arthur.ubicom.tudelft.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2003 18:41:39 +0100
Erik Mouw <J.A.K.Mouw@its.tudelft.nl> wrote:

> On Tue, Jan 28, 2003 at 02:50:42PM +0000, Alan Cox wrote:
> > Lots of systems cannot do 800x600 or 1024x768. Some of them cannot
> > do 640x480 very well but 640x480 is safe except for weird kit because
> > of the VGA mode support.
> 
> Hey, we have aalib for that :)

yeah, why to do it inside the kernel?

Just run a userspace logo for the first thing in the
system in the init screens. I don't see a real reason why 
that thing should be put in kernel. Where would you put the
800x600 image (since you have nothing mounted)?


Just run the first task with something that puts
a fb logo; and send nothing to the screen until you run
xdm. That would be nice for the users that doesn't
want to see those horrible "debug" things.

If i remember correctly, xp doesn't shows the logo
since the start neither. It does a bit of job before.

A linux kernel doesn't take too much time to boot
(the ide detection is the slower part i remember)

And the kernel messages always were, always will be,
useful. To get a clean screen perhaps we could have
something like a boot parm called silentdmesg, and then
do the previous thing.




> 
> 
> Erik
> 
> -- 
> J.A.K. (Erik) Mouw
> Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org
> WWW: http://www-ict.its.tudelft.nl/~erik/
> 
