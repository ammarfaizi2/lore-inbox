Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265627AbSJSPcd>; Sat, 19 Oct 2002 11:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSJSPcd>; Sat, 19 Oct 2002 11:32:33 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:21735 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S265627AbSJSPcb> convert rfc822-to-8bit; Sat, 19 Oct 2002 11:32:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan Dittmer <jan@jandittmer.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sat, 19 Oct 2002 17:39:36 +0200
User-Agent: KMail/1.4.3
References: <200210190241.49618.jan@jandittmer.de> <200210191124.34977.jan@jandittmer.de> <20021019092406.GI871@suse.de>
In-Reply-To: <20021019092406.GI871@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210191739.36187.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still when enabling tcq via 'echo using_tcq:8 > /proc/ide/hda/settings'  doing 
a simple 'bk clone' of the 2.5 repository will frag the newly created files 
uttlery. Lots of unconnected inodes and illegal directory entries on reboot. 
Filesystem is ext2. Enabling tcq and doing light work, watching movies, using 
mozilla, ... seems to work fine - but my home directory is on nfs, so it's no 
real test for my system disk.
When disabling tcq after boot, nothing of this happens.
Increasing the queue size to 32 seems to speed things up (no reliable numbers 
here). Complete system info at http://lx.sfhq.hn.org/. 
Can I somehow debug tcq?

jan


On Saturday 19 October 2002 11:24, you wrote:
> On Sat, Oct 19 2002, Jan Dittmer wrote:
> > > But I'm curious about TCQ on your system, since another VIA user
> > > reported problems. Does it appear to work for you?
> >
> > Actually that was me, I think. It now seems to work without any
> > corruption on
>
> Oh :)
>
> > 2.5.44bk. I don't know what caused it last time. Perhaps it was really my
> > harddisk dying - but I never experienced such problems with 2.4.x .
> > So I guess it's okay now. I'll try re-enable tcq now...
>
> Thanks for testing!
