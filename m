Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbUL0WrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUL0WrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUL0WrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:47:22 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:26129 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261557AbUL0WrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:47:17 -0500
Date: Mon, 27 Dec 2004 23:48:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Georg Prenner <georg.prenner@aon.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make errors (make clean, make menuconfig) make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
Message-ID: <20041227224833.GA8206@mars.ravnborg.org>
Mail-Followup-To: Georg Prenner <georg.prenner@aon.at>,
	linux-kernel@vger.kernel.org
References: <41D08472.6010404@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D08472.6010404@aon.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 10:53:54PM +0100, Georg Prenner wrote:
> Hi
> 
> I am having a problem when executing "make menuconfig" on my fresh 
> extracted 2.6.10 kernel.
> 
> The error message is like this:
> 
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
> make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
> .
> .
> .
> .
> .
> .
> .
> I can only stop this neverending message with Strg+C and then it goes on 
> like this:
> make[85]: *** [menuconfig] Interrupt
> make[84]: *** wait: No child processes.  Stop.
> make[84]: *** Waiting for unfinished jobs....
> make[84]: *** wait: No child processes.  Stop.
> make[83]: *** [menuconfig] Error 2
> make[82]: *** [menuconfig] Interrupt
> make[81]: *** [menuconfig] Interrupt
> ..
> .
> .
> 
> All other Versions of Kernels work perfectly, I use Make 3.80, and my 
> distro is slackware 10.0.
> 
> Please help me i can't find anything usefull on the WEB.

Try executing make in the directory where you extract the source -
and not in the symlinked directory.

You need to untar the source first because kbuild has overwritten
your Makefile.

	Sam
