Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTKAVCb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 16:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTKAVCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 16:02:31 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:65069 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263444AbTKAVC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 16:02:29 -0500
Date: Sat, 1 Nov 2003 23:02:23 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks slightly during reboot]
Message-ID: <20031101210223.GM4640@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi> <20031101155604.GB530@alpha.home.local> <20031101182518.GL4640@niksula.cs.hut.fi> <20031101190114.GA936@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101190114.GA936@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 08:01:14PM +0100, you [Willy Tarreau] wrote:
> On Sat, Nov 01, 2003 at 08:25:18PM +0200, Ville Herva wrote:
>  
> > Is there anything special in booting to DOS instead of different linux
> > kernel, other than that it would rule out some strange kernel bug that is
> > present in 2.2 and 2.4?
> 
> No, it was just to quicky confirm or deny the fact that it's the kernel
> which causes the problem. It could have been a long standing bug in the IDE
> or partition code, and which is present in several kernels. 

I vaguely recall some ide write cache flushing code was fixed some time ago,
but I can't find it in the archives. Maybe I dreamed that up. But I still
wonder why an otherwise idle drive would hold the data in write cache for so
long (several minutes.)

> But as you say that it affects two different controllers, there's little
> chance that it's caused by anything except linux itself. 

Unless the drive is buggy wrt. flushing its write cache. But I think it's
a quite distant possibility.

> Then, the reboot on DOS will only tell you if the drives were corrupted at
> startup or at shutdown.

Yep. I'll try to find the moment to boot the beast into something else than
the current kernel / distro (it could in theory be something in userspace,
though I cannot think what). 

> > BTW: the corruption happens on warm reboots (running reboot command), not
> > just on power off / on.
> 
> OK, but the BIOS scans your disks even during warm reboots. 

True, I mainly made this note because I hadn't mentioned it before in the
thread, and I thought it might have some relevance wrt. possible ide write
caching problems. I didn't mean it as a response to the BIOS theory.


-- v --

v@iki.fi
