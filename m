Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272854AbTG3MO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272855AbTG3MO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:14:59 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:60805
	"EHLO gaston") by vger.kernel.org with ESMTP id S272854AbTG3MO6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:14:58 -0400
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030729174919.GC2601@openzaurus.ucw.cz>
References: <1059484419.8537.19.camel@gaston>
	 <20030729174919.GC2601@openzaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059567270.8545.70.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Jul 2003 08:14:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Would not it be simpler to replace info->fbops with some dummy ones?

I did that for 2.4, that's indeed an option. I suppose we are completely
sure fbcon will never touch the framebuffer without going through those
fb_ops (fb_fillrect, fb_imageblit, etc...) ? That mean we would still
run a lot of useless code, but that's not too bad.

We still want the notification mecanism though, at least for proper
refresh on wakeup, and other "clients" (the DRI comes to mind) may
make good use of it as well.

Ben.

