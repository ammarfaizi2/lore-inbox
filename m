Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277911AbRJRSbB>; Thu, 18 Oct 2001 14:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277924AbRJRSav>; Thu, 18 Oct 2001 14:30:51 -0400
Received: from www.transvirtual.com ([206.14.214.140]:34061 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S277911AbRJRSak>; Thu, 18 Oct 2001 14:30:40 -0400
Date: Thu, 18 Oct 2001 11:31:04 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Chip Salzenberg <chip@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxconsole-dev@lists.sourceforge.net
Subject: Re: [PATCH] input-ps2: Put serio and serport in drivers/input
In-Reply-To: <20011017203146.A5503@perlsupport.com>
Message-ID: <Pine.LNX.4.10.10110181126230.32143-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The recently posted input-ps2 patch breaks if the serio and serport
> object files in drivers/char/joystick are required only for PS/2
> (i.e. they weren't enabled already for joysticks).  And that brings
> up the question: What the heck are those files doing in the joystick
> driver dir in the first place?!

Well originally the only serial input devices where joysticks. As time
goes on this is not true any longer. We have several non joystick serio
based devices in CVS. Plus we use the serio setup for non serial but PIO 
type input devices. PS/2 is a good example of such hardware. So yes I
agree serio.c and serport.c should be moved into drivers/input. I had this
problem when developing the h3600 touchscreen driver for the iPAQ using
the input api.

> It seems to me that serio.c and serport.c belong in drivers/input more
> than anywhere else.  I'm enclosing a patch that handles just such a
> relocation.  The patch doesn't actually move the files ... that would
> just inflate the patch, and it's a lot easier to just "mv" them.

Actually I like to see all input devices in drivers/input but last time I
suggested that it was shot down. In time they will be moved there. Either
that or drivers/char will be 95% input drivers.

