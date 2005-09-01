Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVIAPUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVIAPUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVIAPUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:20:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23624
	"EHLO g5.random") by vger.kernel.org with ESMTP id S1030197AbVIAPUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:20:05 -0400
Date: Thu, 1 Sep 2005 17:19:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Sven Ladegast <sven@linux4geeks.de>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050901151958.GG1614@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl> <20050830151035.GO8515@g5.random> <1125419618.8276.30.camel@localhost.localdomain> <20050830161634.GR8515@g5.random> <20050831183159.GD703@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831183159.GD703@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 08:32:00PM +0200, Pavel Machek wrote:
> I'd say "ignore suspend". Machines using it are probably not connected
> to network, anyway, and it stresses system quite a lot.

Currently even if you're not connected to the network it's fine. As long
as you connect sometime. If a packet manages to get sent to the sever in
a window when you're connected your stats will be fine and the seconds
of uptime will be checked against the time it passed on the server.

> I'm afraid that if you compared completely idle system and system running
> one hour a day, suspended for the rest, the first system would likely reach better
> uptime.

That shouldn't be the case. Anyway I can trivially detect the suspended
systems, so if you want I can add a tag like "suspended" on the right of
the table (in the future we can add filters in the main page so you can
filter out the archs you don't want, smp etc..).
