Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUJOW21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUJOW21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 18:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUJOW20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 18:28:26 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:56753 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S266891AbUJOW1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 18:27:50 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 15 Oct 2004 15:27:31 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <416FEC63.2911.2A62355@localhost>
In-reply-to: <1097865570.10133.187.camel@localhost.localdomain>
References: <416FB29A.11731.1C46848@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Gwe, 2004-10-15 at 19:20, Kendall Bennett wrote:
> > That works great on x86, but this solution was developed for PowerPC and 
> > MIPS embedded systems development not x86 desktop systems. For those 
> > platforms you either need a boot loader that can bring up the system into 
> > graphics mode (possible with U-Boot) or to init the video right when the 
> > framebuffer console driver is brought up.
> 
> Right there are certainly cases where you need to do stuff very
> early. Even then you may benefit because you can keep the kernel
> side init pretty basic and also marked "__init" so it is freed post
> boot. 

Right. I haven't yet figured out how to mark the code as __init so it can 
get tossed out, although if we use the VESA driver after the fact you 
would want to keep it around in that case. But to just boot the card and 
use say the Radeon FB driver it would be nice to toss out the code.

I should probably look into that.

> > >From the sound of it that might be too early to spawn a user mode 
> > process?
> 
> Do the embedded folks want the kernel boot messages via the
> display or are they happy with that via debug port/serial anyway.
> If so is it an issue ? You can bring up the video at the point user
> space begins. 

Well in most cases I think what they really want is for the video to come 
on as soon as possible (instantly would be best) after the power is 
applied, but they probably want their own boot logo on the screen at that 
point and not Linux kernel boot messages.

Also is it possible to run X on a machine that is running from a serial 
console and have it start up on the graphics card at that point? I 
thought about that option since then everything would be in user space, 
but wasn't sure how that would work (plus there would be a long delay 
between when the machine is powered on and something shows up on the 
screen, which is generally not a good thing for consumer products).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


