Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbUKUS4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUKUS4I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUKUS4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:56:07 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:6496 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261783AbUKUS4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:56:06 -0500
Date: Sun, 21 Nov 2004 19:56:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andreas Steinmetz <ast@domdv.de>, Sam Ravnborg <sam@ravnborg.org>,
       Blaisorblade <blaisorblade_spam@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why INSTALL_PATH is not /boot by default?
Message-ID: <20041121185646.GA7811@mars.ravnborg.org>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Andreas Steinmetz <ast@domdv.de>, Sam Ravnborg <sam@ravnborg.org>,
	Blaisorblade <blaisorblade_spam@yahoo.it>,
	LKML <linux-kernel@vger.kernel.org>
References: <200411160127.15471.blaisorblade_spam@yahoo.it> <20041121094308.GA7911@mars.ravnborg.org> <41A06FF0.7090808@domdv.de> <Pine.LNX.4.61.0411211400530.3418@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411211400530.3418@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 02:03:24PM +0100, Jesper Juhl wrote:
 > Please note that there are cases where you build a kernel for machine x on
> > machine y. Which means: don't unconditionally uncomment this line.
> > 
> Huh, in that case wouldn't you just copy the kernel image from the source 
> dir on machine y to whereever it needs to liveon machine x by hand? At 
> least that's what I do, the Makefile and its INSTALL_PATH never comes into 
> play then.

In scripting it's much easier to have:
make INSTALL_MOD_PATH=/nfs/frodo/ modules_install
make INSTALL_PATH=/nfs/frodo/ install

And everything 'just works'.

	Sam
