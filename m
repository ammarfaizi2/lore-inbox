Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUGIDd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUGIDd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 23:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUGIDd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 23:33:58 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:20103 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263770AbUGIDdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 23:33:54 -0400
Date: Fri, 9 Jul 2004 05:33:54 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Leszek Koltunski <leszek@serwer.3miasto.net>, linux-kernel@vger.kernel.org
Subject: Re: the old 'Unknown HZ value' bug
Message-ID: <20040709033353.GB1351@MAIL.13thfloor.at>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Leszek Koltunski <leszek@serwer.3miasto.net>,
	linux-kernel@vger.kernel.org
References: <Pine.NEB.4.60.0407080250190.5702@serwer.3miasto.net> <20040708144506.GA6809@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708144506.GA6809@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 11:45:06AM -0300, Marcelo Tosatti wrote:
> On Thu, Jul 08, 2004 at 02:57:04AM +0200, Leszek Koltunski wrote:
> > 
> > I keep getting the bug at random times. My googling resulted in a bunch of 
> > posts claiming that the problem is related to SMP systems and possibly to 
> > uptime. But not in my case- I do not have a SMP system and I sometimes get 
> > the bug right after bootup. SMP support is turned off, as you can see in 
> > my config:
> > 
> > www.3miasto.net/~leszek/config.html
> > 
> > I was getting it with 2.4.17, 2.4.24, and every single 2.6.x .
> > ( I haven't tested other 2.4.x's )

sounds like broken tools trying to figure the
HZ value from /proc/interrupts and uptime ...

this tends to give exceptionally wrong values,
especially shortly after system start (small
number of timer interrupts so far)

best,
Herbert

> Leszek, 
> 
> Can you please your problem in more detail?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
