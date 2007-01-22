Return-Path: <linux-kernel-owner+w=401wt.eu-S1751867AbXAVO4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXAVO4K (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbXAVO4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:56:10 -0500
Received: from lucidpixels.com ([66.45.37.187]:57481 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbXAVO4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:56:08 -0500
Date: Mon, 22 Jan 2007 09:56:05 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: kyle <kylewong@southa.com>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: change strip_cache_size freeze the whole raid
In-Reply-To: <005501c73e33$7d9046d0$28df0f3d@kylecea1512a3f>
Message-ID: <Pine.LNX.4.64.0701220954540.1711@p34.internal.lan>
References: <001801c73e14$c3177170$28df0f3d@kylecea1512a3f>
 <Pine.LNX.4.64.0701220717200.30260@p34.internal.lan>
 <005501c73e33$7d9046d0$28df0f3d@kylecea1512a3f>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jan 2007, kyle wrote:

> >
> > On Mon, 22 Jan 2007, kyle wrote:
> >
> > > Hi,
> > >
> > > Yesterday I tried to increase the value of strip_cache_size to see if I
> > > can
> > > get better performance or not. I increase the value from 2048 to something
> > > like 16384. After I did that, the raid5 freeze. Any proccess read / write
> > > to
> > > it stucked at D state. I tried to change it back to 2048, read
> > > strip_cache_active, cat /proc/mdstat, mdadm stop, etc. All didn't return
> > > back.
> > > I even cannot shutdown the machine. Finally I need to press the reset
> > > button
> > > in order to get back my control.
> 
> > Yes, I noticed this bug too, if you change it too many times or change it
> > at the 'wrong' time, it hangs up when you echo numbr >
> > /proc/stripe_cache_size.
> >
> > Basically don't run it more than once and don't run it at the 'wrong' time
> > and it works.  Not sure where the bug lies, but yeah I've seen that on 3
> > different machines!
> >
> > Justin.
> >
> >
> 
> I just change it once, then it freeze. It's hard to get the 'right time'
> 
> Actually I tried it several times before. As I remember there was once it
> freezed for around 1 or 2 minutes , then back to normal operation. This is the
> first time it completely freezed and I waited after around 10 minutes it still
> didn't wake up.
> 
> Kyle
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

What kernel version are you using?  It normally works the first time for 
me, I put it in my startup scripts, as one of the last items.  However, if 
I change it a few times, it will hang and there is no way to reboot except 
via SYSRQ or pressing the reboot button on the machine.

This seems to be true of 2.6.19.1 and 2.6.19.2, I did not try under 
2.6.20-rc5 because I am tired of hanging my machine :)

Justin.
