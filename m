Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTEZA6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 20:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTEZA6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 20:58:40 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:37507
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263834AbTEZA6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 20:58:38 -0400
Date: Sun, 25 May 2003 21:00:28 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] xirc2ps_cs irq return fix
In-Reply-To: <3ED16351.7060904@pobox.com>
Message-ID: <Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com>
References: <200305252318.h4PNIPX4026812@hera.kernel.org> <3ED16351.7060904@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003, Jeff Garzik wrote:

> As I mentioned in the thread, this piece of code is obviously wrong.
> 
> Think about how scalable this fix is??  Do you really want to crap up 
> all pcmcia drivers with this silly -- and wrong -- check?

My interpretation of it is the PCMCIA controller was triggering interrupts 
on exit and the link handler for the card was still installed even after 
the netdevice was down.

> IIRC the pcmcia layer or new irqreturn_t was blamed for the problem. 
> Come on.  Linux mantra is -against- papering over bugs.

I have to take responsibility for that little mess :(

	Zwane
-- 
function.linuxpower.ca
