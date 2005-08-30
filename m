Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVH3QQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVH3QQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVH3QQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:16:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44391
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932200AbVH3QQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:16:41 -0400
Date: Tue, 30 Aug 2005 18:16:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Sven Ladegast <sven@linux4geeks.de>,
       linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830161634.GR8515@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl> <20050830151035.GO8515@g5.random> <1125419618.8276.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125419618.8276.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 05:33:38PM +0100, Alan Cox wrote:
> Just follow the LSB specification and about the only thing thats totally
> out of field is Slackware.

Fair enough, though one line like '(sleep 60; twistd ...) & in
/etc/init.d/boot.local would have been a bit simpler for a quick and
dirty autoinstall .sh script (that's the simplest way I install it in my system).

> Right thats my first reaction, 6Mbytes of unauditable weirdness versus a

;)

> tiny C program or a shell script using netcat.
> 
> echo "Reporting boot: "
> (echo "BOOT:"$(cat /etc/lum-serial)":"$(uname -a)"::") | nc -u -w 10
> testhost.example.com 7658

Client completely stateless couldn't get right suspend to disk as far as
I can tell.

Tiny C program will be less tiny than the current tac file and the
package would immediately become arch dependent. Plus if you want to run
it as user nobody the twistd -u/g --pidfile --logfile and all the rest
in twisted make life so much easier. On my systems I've other services
running in background with twistd so perhaps I'm biased because I share
almost all of it ;).

> For one distro perhaps. Using a proper init service script makes it work
> for pretty much everyone. 

I'm not very optimistic about the depdency chain to be distro
indipendent, but I will look into that shortly and I guess here I'm
running a bit offtopic.

Thanks!
