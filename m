Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTKURWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 12:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTKURWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 12:22:14 -0500
Received: from palrel12.hp.com ([156.153.255.237]:48782 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264370AbTKURWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 12:22:13 -0500
Date: Fri, 21 Nov 2003 09:22:11 -0800
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Bill Nottingham <notting@redhat.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] All my Pcmcia cards are 'eth0'
Message-ID: <20031121172211.GA25453@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20031121031359.GA19405@bougret.hpl.hp.com> <20031121032819.GA2120@devserv.devel.redhat.com> <20031120194058.4961ea1b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120194058.4961ea1b.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 07:40:58PM -0800, Randy.Dunlap wrote:
> On Thu, 20 Nov 2003 22:28:19 -0500 Bill Nottingham <notting@redhat.com> wrote:
> 
> | Jean Tourrilhes (jt@bougret.hpl.hp.com) said: 
> | > 	One of the main problem is that they are all assigned 'eth0',
> | > and therefore all configured with the same IP address. This is really
> | > pathetic.
> | > 
> | > 	The usual answer is : you should use 'nameif' :
> | > http://www.xenotime.net/linux/doc/network-interface-names.txt
> | > 	Well, of course, nobody ever bothered to try it, so it doesn't
> | > work. No comments.
> | 
> | Well, no offense, but I'd think comments are necessary about no
> | one bothering to try it and it not working. I've had an orinoco_cs
> | device 'bob' using nameif for a while.
> 
> Jean, have you given me any feedback on that small howto and it
> not working?  If so, I've missed it and I apologize for that.

	I may be real dense, but your Howto only describe using nameif
at boot time, which is mostly useless for Pcmcia cards (unless you
want to solder Pcmcia cards in their slots).

> I use that method both at home and at work all the time,
> with no problems, but I haven't tried it with PCMCIA cards, so
> that's something that might need some work, as you have discovered.

	That's the point. If you want it to work with Pcmcia cards
(and other dynamic devices such as USB), 'nameif" *must* be called
from the hotplug scripts (pretty obvious, isn't it ?). And currently
you can't do that properly, which is the reason of my changes.
	Note that once you add nameif in the hotplug scripts, you no
longer need to call it at boot time, so with one bird you kill two
stones.

> ~Randy

	Thanks for looking into that.

	Jean
