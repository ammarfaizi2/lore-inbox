Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSFEUZe>; Wed, 5 Jun 2002 16:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSFEUZd>; Wed, 5 Jun 2002 16:25:33 -0400
Received: from unicorn.it.wsu.edu ([134.121.1.1]:32010 "EHLO
	unicorn.it.wsu.edu") by vger.kernel.org with ESMTP
	id <S316289AbSFEUZa>; Wed, 5 Jun 2002 16:25:30 -0400
Date: Wed, 5 Jun 2002 13:25:06 -0700 (PDT)
From: Eric Kristopher Sandall <sandalle@wsunix.wsu.edu>
To: Michael Zhu <mylinuxk@yahoo.ca>
cc: John Tyner <jtyner@cs.ucr.edu>, kernelnewbies@nl.linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
In-Reply-To: <20020605194148.43165.qmail@web14907.mail.yahoo.com>
Message-ID: <Pine.OSF.4.10.10206051320110.304-100000@unicorn.it.wsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Michael Zhu wrote:

> Hi, I couldn't find the /etc/modules file in my Linux
> machine. There is only a modules.conf file under /etc
> directory. My Linux is RedHat 7.2 with kernel version
> 2.4.7-10. What is wrong with this?
> 
> Michael

Just create the file, and then put in the text.

/etc/modules.conf is for module options and aliases.
example: My sound card is a sb16, with irq=7 io=0x220, dma1=0, dma2=5

in /etc/modules.conf (this is from memory, might not be exact)
alias  eth0   3c59x
alias  sound  sb
options  sb  irq=7, io=0x220, dma=0, dma16=5

Now, I can do "modprobe sound"[0] and it will load my sb module with those
paramaters.  I could also do "modprobe sb" and it will load my sb module
with those parameters.  I can also do "modprobe eth0" and it will load my
3c59x module.

You may also put the aliased names in /etc/modules.

example:

eth0
sound
vfat

[0] modprobe is the preferred way to load modules, instead of insmod.
modprobe will load any dependencies your module needs, and will unload all
of them if one fails to load.

-ES

--
Eric Sandall                  |   (P)e-mail: sandalle@mail.wsu.edu
Debian Linux Beowulf Cluster  |      (P)web: http://hellhound.homeip.net/
ICQ: 667348                   | User 196285: http://counter.li.org/
SysAdmin, Shock Physics, WSU  |      (W)web: http://www.shock.wsu.edu/

