Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132951AbRDEQNv>; Thu, 5 Apr 2001 12:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132953AbRDEQNl>; Thu, 5 Apr 2001 12:13:41 -0400
Received: from virtualro.ic.ro ([194.102.78.138]:7177 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S132951AbRDEQNc>;
	Thu, 5 Apr 2001 12:13:32 -0400
Date: Thu, 5 Apr 2001 19:13:08 +0300 (EEST)
From: Jani Monoses <jani@virtualro.ic.ro>
To: Bjorn Wesen <bjorn@sparta.lu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: ERESTARTSYS question.
In-Reply-To: <Pine.LNX.3.96.1010405161227.30281C-100000@medusa.sparta.lu.se>
Message-ID: <Pine.LNX.4.10.10104051908540.29169-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Apr 2001, Bjorn Wesen wrote:

> 
> ERESTARTSYS is a part of the api between the driver and the
> signal-handling code in the kernel. It does not reach user-space (provided
> of course that it's used appropriately in the drivers :) 

As an example sound/via82cxxx_audio.c returns ERESTARTSYS from
via_dsp_open() .I suppose this _does_ reach userland right? 

> When a driver needs to wait, and get awoken by a signal (as opposed to
> what it's really waiting for) the driver should in most cases abort the
> system call so the signal handler can be run (like, you push ctrl-c while
> running somethinig that's stuck in a wait for an interrupt). The kernel
> uses the ERESTARTSYS as a "magic" value saying it's ok to restart the
> system call automagically after the signal handling is done. The actual
> return-code is switched to EINTR if the system call could not be
> restarted.
> 
> -Bjorn
> 

Thanks, and by the way the comments in arch/cris regarding the issue are
useful too ;)

Jani.

