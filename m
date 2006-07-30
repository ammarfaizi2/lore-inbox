Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWG3TRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWG3TRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWG3TRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:17:03 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:64716 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932438AbWG3TRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:17:01 -0400
Date: Sun, 30 Jul 2006 21:17:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: Building external modules against objdirs
Message-ID: <20060730191700.GA30700@mars.ravnborg.org>
References: <200607301846.07797.ak@suse.de> <200607301949.41165.ak@suse.de> <20060730183159.GA30278@mars.ravnborg.org> <200607302037.02559.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607302037.02559.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 08:37:02PM +0200, Andi Kleen wrote:
 
> 
> The echo didn't output for some reason, but adding it to the error gives
> 
> /home/lsrc/quilt/linux/Makefile:456: *** triggered by /home/lsrc/quilt/linux/drivers/net/wireless/Kconfig /home/lsrc/quilt/linux/drivers/message/fusion/Kconfig /home/lsrc/quilt/linux/net/ieee80211/Kconfig /home/lsrc/quilt/linux/net/netfilter/Kconfig kernel configuration not valid - run 'make prepare' in /home/lsrc/quilt/linux to update it.  Stop.

What happens is that a few Kconfig files in your quilt tree are updated
after last time you reran 'make'.
And then kbuild say that config is invalid since it has not been updated
since last edit of Kconfig files.

Hmm...

	Sam
