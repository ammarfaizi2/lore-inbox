Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWIUWlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWIUWlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWIUWlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:41:09 -0400
Received: from smtp.ono.com ([62.42.230.12]:31177 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S932088AbWIUWlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:41:06 -0400
Date: Fri, 22 Sep 2006 00:40:02 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: jhf@columbus.rr.com (Joseph Fannin)
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: 2.6.18-rc7-mm1: no /dev/tty0
Message-ID: <20060922004002.663a6fe8@werewolf.auna.net>
In-Reply-To: <20060921224049.GA2501@nineveh.rivenstone.net>
References: <20060921234151.2dd12d32@werewolf.auna.net>
	<45130CF9.4060806@free.fr>
	<20060921224049.GA2501@nineveh.rivenstone.net>
X-Mailer: Sylpheed-Claws 2.4.0cvs208 (GTK+ 2.10.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 18:40:50 -0400, jhf@columbus.rr.com (Joseph Fannin) wrote:

> On Fri, Sep 22, 2006 at 12:06:49AM +0200, Laurent Riffard wrote:
> > Le 21.09.2006 23:41, J.A. Magallón a écrit :
> 
>     Trimming CC's is generally frowned upon on LKML.
> 
> > >When booting 2.6.18-rc7-mm1, the initscripts complain about /dev/tty0 not
> > >being present. Then the boot sequence blocks...:
> > >
> > >Sep 21 23:23:57 werewolf init: open(/dev/console): No such file or
> > >directory
> > >Sep 21 23:24:07 werewolf last message repeated 17 times
> > >Sep 21 23:24:12 werewolf init: Id "3" respawning too fast: disabled for 5
> > >minutes
> > >
> > >(from syslog)
> > >
> > >The same userspace boots fine with -rc6-mm2.
> > >
> > >Any ideas ?
> >
> > Well, I have similar issues: when booting 2.6.18-rc7-mm1, some /dev
> > files are missing:
> > - /dev/kmem
> > - /dev/kmsg
> > - /dev/mem
> > - /dev/port
> > - /dev/ptmx
> > - /dev/tty
> >
> > Setting CONFIG_SYSFS_DEPRECATED=y didn't help. My .config is attached.
> > ~~
> > laurent
> 
>     There were some problems with older versions of udev not creating
> some device nodes with -mm kernels.  I don't know if this has been
> fixed, or if it's the same as this:
> 
> "- The kernel doesn't work properly on RH FC3 or pretty much anything
>   which uses old udev, due to improvements in the driver tree."
> 
>     I know that, several -mm's back, Ubuntu Dapper's udev 079 didn't
> create /dev/alsa or /dev/psaux.
> 

Not my case, at least:

werewolf:~> rpm -q udev
udev-098-6mdv2007.0

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam10 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
