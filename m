Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932945AbWFZTai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbWFZTai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWFZTai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:30:38 -0400
Received: from mail.gmx.de ([213.165.64.21]:51587 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932945AbWFZTah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:30:37 -0400
X-Authenticated: #704063
Date: Mon, 26 Jun 2006 21:30:34 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Off by one in drivers/usb/serial/usb-serial.c
Message-ID: <20060626193034.GA13701@alice>
References: <200606221331.k5MDVua9010794@harpo.it.uu.se> <20060625225920.GA16834@alice> <20060626191007.GA21925@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626191007.GA21925@suse.de>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.17-mm2 (i686)
X-Uptime: 21:23:37 up 10:20,  3 users,  load average: 0.53, 0.40, 0.36
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, what does this mean?  That coverity is broken, yet again?

right, it means that this was a false report.

> I'm getting very tired of these false positives from them, it is getting
> so that I can't trust the output of the tool at all :(

you shouldnt trust it anyways. At the moment ~11% of the
stuff we checked is marked as bug, ~24% as false or ignore,
5% pending, 4% resolved and 54% uninspected. If we count
pending and resolved to the bugs, that would mean a 50/50
split between bugs and false positives. So we should not trust
it blind and i try my best to avoid such mistakes.
But I wouldnt say coverity is that bad, and it already helped
us fixing several bugs.

Greetings, Eric
