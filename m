Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUHDEPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUHDEPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 00:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUHDEPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 00:15:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:34723 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264815AbUHDEPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 00:15:12 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@linuxmail.org
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091587929.3303.38.camel@laptop.cunninghams>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <1091587985.5226.74.camel@gaston>
	 <1091587929.3303.38.camel@laptop.cunninghams>
Content-Type: text/plain
Message-Id: <1091592870.5226.80.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 14:14:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, I don't call suspend for it because I can be sure the drivers are
> idle (before beginning to write the image, freeze all process, flush all
> dirty buffers and suspend all other drivers, I then wait on my own I/O
> until it is flushed too). I know it's broken to do so, but it was a good
> work around for wearing out the thing by spinning it down and then
> immediately spinning it back up, and I wasn't sure what the right state
> to try to put it in is (sound familiar?!). If you want to tell me how I
> could tell it to quiesce without spin down, I'll happily do that.

Very easy... with the current code, just use state 4 for the round
of suspend callbacks, ide-disk will then avoid spinning down.

> The sooner these issues get sorted, the better.
> 
> Regards,
> 
> Nigel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

