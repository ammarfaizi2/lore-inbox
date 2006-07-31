Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWGaJjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWGaJjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWGaJjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:39:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27807 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964836AbWGaJjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:39:41 -0400
Date: Mon, 31 Jul 2006 11:39:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: Building external modules against objdirs
In-Reply-To: <20060730191700.GA30700@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0607311135350.6762@scrub.home>
References: <200607301846.07797.ak@suse.de> <200607301949.41165.ak@suse.de>
 <20060730183159.GA30278@mars.ravnborg.org> <200607302037.02559.ak@suse.de>
 <20060730191700.GA30700@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 30 Jul 2006, Sam Ravnborg wrote:

> On Sun, Jul 30, 2006 at 08:37:02PM +0200, Andi Kleen wrote:
>  
> > 
> > The echo didn't output for some reason, but adding it to the error gives
> > 
> > /home/lsrc/quilt/linux/Makefile:456: *** triggered by /home/lsrc/quilt/linux/drivers/net/wireless/Kconfig /home/lsrc/quilt/linux/drivers/message/fusion/Kconfig /home/lsrc/quilt/linux/net/ieee80211/Kconfig /home/lsrc/quilt/linux/net/netfilter/Kconfig kernel configuration not valid - run 'make prepare' in /home/lsrc/quilt/linux to update it.  Stop.
> 
> What happens is that a few Kconfig files in your quilt tree are updated
> after last time you reran 'make'.
> And then kbuild say that config is invalid since it has not been updated
> since last edit of Kconfig files.
> 
> Hmm...

What we could do is to call silentoldconfig and set 
KCONFIG_NOSILENTUPDATE, if the .config is uptodate it will only update 
autoconf and abort otherwise.

bye, Roman
