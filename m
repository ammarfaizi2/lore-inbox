Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270859AbTHFTH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbTHFTH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:07:26 -0400
Received: from tribal.metalab.unc.edu ([152.2.210.122]:54180 "EHLO
	tribal.metalab.unc.edu") by vger.kernel.org with ESMTP
	id S270859AbTHFTHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:07:25 -0400
Date: Wed, 6 Aug 2003 15:07:21 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] ToPIC specific init for yenta_socket
In-Reply-To: <20030806194430.D16116@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Russell King wrote:

> On Wed, Aug 06, 2003 at 08:25:08PM +0200, Daniel Ritz wrote:
> > this patch adds override functions for the ToPIC family of controllers.
> > also adds the device id for ToPIC100 and (untested) support for zoom
> > video for ToPIC97/100.
> >
> > tested with start/stop and suspend/resume.
>
> We currently have some fairly serious IRQ problems with yenta at the
> moment.  I'm holding all patches until we get this problem resolved -
> it seems to be caused by several bad changes over the past couple of
> years accumulating throughout the 2.5 series.

I read the PCMCIA list, but not LKML, and I have no idea what problems you
are talking about.  Could you please explain of give a pointer to a
previous post?  I could cross-check the problem against plx9052 driver.

I'm sorry for asking you to spend some time and possibly repeat something
that was said before, but sometimes talking about the problem makes it
easier to understand it and find the best solution.

> Also, assigning to socket->socket.ops->init modifies the global
> yenta_socket_operations structure, which I'm far from happy about.

The same is done for TI and Ricoh bridges.  Just search the sources for
"socket->socket.ops->init".  You may have a good reason to be unhappy, but
coherent code is normally easier to fix than a bunch of different hacks.

-- 
Regards,
Pavel Roskin
