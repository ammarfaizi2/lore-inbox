Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVH3PKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVH3PKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVH3PKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:10:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12350
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932180AbVH3PKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:10:39 -0400
Date: Tue, 30 Aug 2005 17:10:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Sven Ladegast <sven@linux4geeks.de>, linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830151035.GO8515@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830094058.GA29214@bitwizard.nl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 11:40:58AM +0200, Rogier Wolff wrote:
> packets also wouldn't. So if it is so unimportant as here, why bother
> with the more overhead of the TCP connection?

I agree TCP isn't needed, I also don't see SSL very useful here, I use
it extensively for other projects and it would have been even simpler to
use SSL over TCP than to use cleartext UDP with twisted, but it was
pointless to hide the contents of the packet on the network, when then I
show all of them on the website ;) So I'd rather save some packet on the
network and some cpu as well.

> A kernel option that is clearly documented what exact info is logged
> would IMHO work better. (A userspace program is technically a better

It's certainly much easier to tweak the kernel config before compiling
the kernel than to edit the mess in /etc/init.d/* with all the
gratuitous differences of the userland flavours.

Clearly it would be an option to keep disabled by default.

The object of the project is to know how much testing a rc/pre kernel
had before release, and most of the testers are supposed to tweak the
config option by themself, so having a config tweak would make it very
easy to setup. It'll be a bit lighter too, twisted currently takes 6m of
RSS on a x86.

However I'm quite neutral, the main advantage of the userland solution
is that it has been orders of magnitude simpler to develop.

I could perhaps write an auto-installer script, that fetches the tac
file with wget and adds a line to /etc/init.d/boot.local to make life
easier.
