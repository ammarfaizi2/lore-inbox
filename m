Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVJCE2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVJCE2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVJCE2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:28:09 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:57606 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932147AbVJCE2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:28:08 -0400
Date: Mon, 3 Oct 2005 06:20:56 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Grant Coady <grant_lkml@dodo.com.au>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051003042056.GC22601@alpha.home.local>
References: <20050927111038.GA22172@ime.usp.br> <1127863912.4802.52.camel@localhost> <20051001213655.GE6397@ime.usp.br> <oh8uj15lvipg3bshv7j82j27j11l67ds49@4ax.com> <20051003041719.GA5576@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051003041719.GA5576@ime.usp.br>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rogerio,

On Mon, Oct 03, 2005 at 01:17:19AM -0300, Rogério Brito wrote:
(...)
> The thing is that any stick alone doesn't seem to generate a problem.
> Only when they are used simultaneously
> 
> I will test it more to see what may be wrong with my setup. :-( I still
> have not isolated and understood the problem completely. :-(

This is a common problem caused by flaky motherboards and/or poor
power supplies. You should first take a look at your motherboard's
manual to see if it *really* supports your configuration. Often,
they won't support several dual-side sticks simply because there
are too many chips connected to each signal pin. For instance, my
mobo (A7M266-D) has a lot of trouble if I use more than 2 sticks,
and it is documented that I need registered RAM to do this.

Also, sometimes your mobo will not have been carefully tested by
the maker with every combination of memory sticks. It might be
your case. Sometimes it helps to increase the RAM voltage (you
might have a jumper for this on the mobo or may be able to do
this in the BIOS). In my case, it helped to set the RAM to 2.7V,
but that was not enough to get a stable setup.

Last possible trouble may come from the power supply. If it's
not strong enough to maintain a perfect voltage output during
slightly higher intensity peaks, it can cause what you observe.

Hoping this helps,
Willy

