Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVLaXWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVLaXWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 18:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVLaXWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 18:22:49 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:32913 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750746AbVLaXWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 18:22:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=isWoIAAjmuZRSePmqFoIGexl9odbWYnQ1bp2IGqt9or9ZjNWwWp2S/CoRh6EII5QBKn7XVqKXlM5cPOKJ7XECv+cj19F7LaT6cRIbkXdB/+9u8vvyPS0kSPTwNhWSmZ12BoNvc8gSOHAH7iQhCBkK215NBu/3jaeuWnmelE9WT4=
Date: Sun, 1 Jan 2006 01:22:43 +0200
From: Bradley Reed <bradreed1@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: RTC broken under 2.6.15-rc7-rt1 (was: Re: MPlayer broken under
 2.6.15-rc7-rt1?)
Message-ID: <20060101012243.4208efb3@galactus.example.org>
In-Reply-To: <1136069215.6039.142.camel@localhost.localdomain>
References: <20051231202933.4f48acab@galactus.example.org>
	<1136058696.6039.133.camel@localhost.localdomain>
	<Pine.LNX.4.61.0512312153480.27366@yvahk01.tjqt.qr>
	<1136069215.6039.142.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.100cvs108 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 17:46:55 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 2005-12-31 at 21:58 +0100, Jan Engelhardt wrote:
> > >Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
> > 
> > I seriously demand that this be changed into "RTC broekn
> > under..."! :)
> 
> Done ;)
> 
> [...]
> 
> > >
> > >Index: linux-2.6.15-rc7-rt1/drivers/char/rtc.c
> > 
> > This patch fixes the rtc BUG for me.
> 

And me too. I had inadvertently cut off a bit at the very top of your
patch, when I re-cut and pasted, it applied fine. 

Shouldn't patch kernels this close to new years. (Which was an hour and
a half ago here...)

> Yeah, attached is a program that does what mplayer does.  I run it
> from the command line like this:
> 
> # for i in `seq 10000`; do ./rtc_ioctl ; done
> 
> And with the patch it runs perfectly fine.  Without it, it segfaults
> several times.

Without it, it segfaults 100% here:

root@galactus:~[1002]# for i in `seq 10`; do ./rtc_ioctl; done
Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault
Segmentation fault

Brad
