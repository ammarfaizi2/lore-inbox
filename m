Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTIJGSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 02:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTIJGSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 02:18:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:11999 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264899AbTIJGSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 02:18:51 -0400
Message-Id: <6.0.0.22.0.20030910074121.01c8a220@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Wed, 10 Sep 2003 08:22:51 +0200
To: Mike Fedyk <mfedyk@matchmail.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Priority Inversion in Scheduling
Cc: Nick Piggin <piggin@cyberone.com.au>,
       John Yau <jyau_kernel_dev@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030910053549.GE28279@matchmail.com>
References: <LAW10-OE63Zc1WPsAVe0000ab93@hotmail.com>
 <3F5E6F15.6040507@cyberone.com.au>
 <6.0.0.22.0.20030910062610.01cfacd8@pop.gmx.net>
 <20030910053549.GE28279@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:35 AM 9/10/2003, Mike Fedyk wrote:
>On Wed, Sep 10, 2003 at 06:42:10AM +0200, Mike Galbraith wrote:
> > At 02:23 AM 9/10/2003, Nick Piggin wrote:
> > >Hi John,
> > >Your mechanism is basically "backboost". Its how you get X to keep a
> > >high piroirity, but quite unpredictable. Giving a boost to a process
> > >holding a semaphore is an interesting idea, but it doesn't address the
> > >X problem.
> >
> > FWIW, I tried the hardware usage bonus thing, and it does cure the X
> > inversion problem (yeah,  it's a pretty cheezy way to do it).  It also
> > cures xmms skips if you can't get to the top without hw usage.  I also
> > tried a cpu limited backboost from/to tasks associated with hardware, and
> > it hasn't run amok... yet ;-)
>
>Against which scheduler, and when are you going to post the patch?

Against stock test-4, but I'm not going to post it.  It's just an 
experiment to verify that there is another simple way to defeat the X 
inversion problem (while retaining active list requeue).  Also, backboost 
is a tricky little bugger, and I thought I'd let Nick know that I had some 
success with this heavily restricted form.  (global backboost can be down 
right evil)

If anyone having inversion or concurrency troubles wants to give it a try 
for grins, they can drop me a line.  My tree tends to morph a lot though, 
depending on what aspect of scheduling I'm tinkering with at the time.  It 
currently does well at defeating known starvation issues, but I don't like 
it's priority distribution much (and it's not destined for inclusion, and 
it's pretty darn ugly, and I'll likely break it all to pieces again soon, 
and...;).

         -Mike 

