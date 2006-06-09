Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWFICo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWFICo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWFICo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:44:58 -0400
Received: from smtp.enter.net ([216.193.128.24]:47118 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965099AbWFICo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:44:58 -0400
From: Daniel Hazelton <dhazelton@enter.net>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Thu, 8 Jun 2006 22:44:49 -0400
User-Agent: KMail/1.7.2
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Ondrej Zajicek <santiago@mail.cz>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200606080341.00382.dhazelton@enter.net> <4487E034.8010808@gmail.com>
In-Reply-To: <4487E034.8010808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606082244.50484.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 04:30 am, Antonino A. Daplas wrote:
> Daniel Hazelton wrote:
> > On Thursday 08 June 2006 03:02 am, Helge Hafting wrote:
> >> Jon Smirl wrote:
> >>> On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
> >
> > Okay. I'll stick this on my list. Shouldn't be too hard to get to,
> > provided I can finish up my work on drmcon. (Tony, I'm still waiting on
> > that unloadable fbcon/fbdev bit and the userspace fbdev driver you
> > mentioned)
>
> I already have a preliminary patch that allows the binding and unbinding
> of fbcon which I sent to lkml and fbdev-devel.  Jon and Andrew are against
> having the control in fbcon, so I'm  currently working on another patch
> that will transfer the control to the console layer.  It was a bit more
> complicated that what I thought, but I'm almost done. I'm just in 
> debugging mode, and so far I haven't encountered any major problems.

Gotcha. Not having control in fbcon? Understandable. I don't think vgacon has 
that control in it, and see no reason for it to be in fbcon either.

> The nice thing about this change is that it's not restricted to fbcon.
> Other console drivers can explicitly bind or unbind, ie, your future
> drmcon.

Now this is a good reason to put the binding/unbinding control in another 
place. I had already thought that re-initializing vgacon on an error 
condition would be the best way to get the message to the screen. Having the 
console binding/unbinding code in a generic layer will make this very easy.

> I may send out the patch within a day or 2. After this, I'll start work on
> the userland driver.
>
> Tony

Thanks Tony. I'll get my nose back into drmcon and see if I can't get it into 
shape soon myself.

DRH
