Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289367AbSA3TI0>; Wed, 30 Jan 2002 14:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290488AbSA3TIQ>; Wed, 30 Jan 2002 14:08:16 -0500
Received: from mail.gmx.de ([213.165.64.20]:17915 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289367AbSA3TIG>;
	Wed, 30 Jan 2002 14:08:06 -0500
Date: Wed, 30 Jan 2002 20:10:54 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Cc: Oleg Drokin <green@namesys.com>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-Id: <20020130201054.6e150f78.sebastian.droege@gmx.de>
In-Reply-To: <20020130174011.L24012@suse.de>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de>
	<20020130173715.B2179@namesys.com>
	<20020130163951.13daca94.sebastian.droege@gmx.de>
	<20020130190905.A820@namesys.com>
	<20020130174011.L24012@suse.de>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 17:40:11 +0100
Dave Jones <davej@suse.de> wrote:

> On Wed, Jan 30, 2002 at 07:09:05PM +0300, Oleg Drokin wrote:
> 
>  > I can reproduce this problem on IDE only.
>  > Hm, may be this is IDE corruption thing, Andre Hendrick spoke about,
>  > or was it fixed already?
>  > I am looking into it anyway.
> 
>  There were no IDE changes in my tree recently, and its strange
>  that this only shows up in reiserfs since the new set of patches
>  went in. I've no reports from users of other filesystems with any
>  problems, so I'm suspecting a rogue change in your last update.
> 
>  Finding a common factor seems tricky, as it works flawlessly here
>  on IDE [*], but dies instantly for others.

OK here are some facts ;)
I run hdparm but only after syslogd... so hdparm isn't the bad boy
I have 3 partitions. Two reiserfs partitions, one mounted on /, one on /home
One ext2 /boot partition
The oops happens in 3 of 4 tests on syslogd. Only devfsd is loaded before it.
The other time it happens when loading proftpd. This is one of the last processes I started by the boot scripts

It happens with the IDE layer version as in the dj tree and with acb-io-2.5.3-p2.01212002 update (why haven't you included this in your tree, Dave?)
I have really no idea the oops comes from

Bye
