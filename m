Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVGaGlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVGaGlw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 02:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGaGjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 02:39:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:61352 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261752AbVGaGik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 02:38:40 -0400
Date: Sat, 30 Jul 2005 23:38:19 -0700
From: Greg KH <greg@kroah.com>
To: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
Message-ID: <20050731063819.GA28899@kroah.com>
References: <42E59E0E.5030306@yahoo.com.br> <20050726003322.1bfe17ee.akpm@osdl.org> <42E7A153.6060307@yahoo.com.br> <20050727105005.30768fe3.akpm@osdl.org> <42E85E6E.2020105@yahoo.com.br> <42EC5451.7010907@yahoo.com.br> <20050730222624.73337021.akpm@osdl.org> <42EC6BAB.5020106@yahoo.com.br> <20050730224437.4088ba70.akpm@osdl.org> <42EC73B2.8020400@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EC73B2.8020400@yahoo.com.br>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 03:46:10AM -0300, Francisco Figueiredo Jr. wrote:
> Andrew Morton wrote:
> > "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
> > 
> >>-----BEGIN PGP SIGNED MESSAGE-----
> >>Hash: SHA1
> >>
> >>Andrew Morton wrote:
> >>
> >>>"Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
> >>>
> >>>
> >>>>udev          S 00000002     0  1312      1                1224 (NOTLB)
> >>>>c1653f4c 00000082 c1653f3c 00000002 00000001 00000040 c1653f64 c1653f0c
> >>>>       c016611b bfec96a8 c1653f0c 00000040 00000000 00000361 000241ed
> >>>>c13fb520
> >>>>       00000001 00001a7e 98f9769f 00000002 c146e520 df5da020 df5da148
> >>>>c13fbf60
> >>>>Call Trace:
> >>>> [<c016611b>] cp_new_stat+0x15f/0x17a
> >>>> [<c0352a74>] schedule_timeout+0x54/0xa2
> >>>> [<c01274ce>] process_timeout+0x0/0x9
> >>>> [<c01275c4>] sys_nanosleep+0xdd/0x18e
> >>>> [<c0102e85>] syscall_call+0x7/0xb
> >>>
> >>>
> >>>Well there's your delay: you've started running userspace and udev is
> >>>running.  Yes, it takes a long time.
> >>>
> >>>What makes you think this isn't normal behaviour?  Do other kernels behave
> >>>differently with the same userspace setup?
> >>>
> >>
> >>
> >>That's the point. On kernel 2.6.11 on same box I have no delay. It is
> >>instantaneous. On 2.6.12-rc1 it was instantaneous but I didn't use it
> >>much because I had drm problems. Later I tried 2.6.12 final and it was
> >>hanging. I saw the "seeing a minute plugs hangs" on 2.6.13-rc1 release
> >>notes and thought this could be the problem, but I compiled it and tried
> >>with no luck :(
> >>
> >>Now, I'm thinking it could be something like the udev hang which
> >>disapeared with udev update to 058.
> >>
> >>I don't know what can be happening. I think it is because of some type
> >>of timeout.
> >>
> >>If you think there is something else I can do, please let me know.
> >>
> > 
> > 
> > Greg said in another thread: "older versions of udev (< 058) can work
> > _really slow_ with 2.6.12.  Please upgrade your version of udev and see if
> > that solves the issue or not.".
> > 
> > What version are you running?   Looks like 058, yes?
> 
> 
> Yeap. It is 058.

Hm, odd.  Well, as this is a udev issue, care to try 064?  We've fixed a
lot of little bugs since 058 that might have caused this.

thanks,

greg k-h
