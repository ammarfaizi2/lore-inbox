Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTEIL5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTEIL5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:57:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55050 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262465AbTEIL5m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:57:42 -0400
Date: Fri, 9 May 2003 14:06:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030509120659.GA15754@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509120648.1e0af0c8.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 12:06:48PM +0200, Stephan von Krawczynski wrote:
 
> Justin, just to complete the picture: as I wrote some days ago concerning your
> hint to "use the latest from ..." your latest driver does not complete booting
> on (at least) my system but freezes - which I wrote to LKML. I have not yet
> heard
> anything about this issue. You cannot expect to include a newer driver which
> performs obviously worse in some cases.
> "Worse" here means "fails" and not "performs bad". Marcelos' decision on the
> topic looks pretty reasonable to me...

What's your setup ? Are you in SMP ? I was hit by a lock bug introduced near
6.2.30, which Justin fixed recently and included in his latest driver
(20030502). Justin suggested to me to try the NMI watchdog to find what was
wrong and it pointed us to a spinlock problem. Have you tried to debug
something ? I must say that this driver seems really robust now on my setup
(dual athlon), but perhaps your problem is of the same order and could be fixed
easily with some help, which would be good for you and everyone else.

Regards,
Willy

