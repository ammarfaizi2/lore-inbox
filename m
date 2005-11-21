Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVKUE1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVKUE1M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 23:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVKUE1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 23:27:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31717
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932177AbVKUE1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 23:27:11 -0500
Date: Sun, 20 Nov 2005 20:27:09 -0800 (PST)
Message-Id: <20051120.202709.20027544.davem@davemloft.net>
To: pavel@suse.cz
Cc: sam@ravnborg.org, akpm@osdl.org, davej@redhat.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
 i386
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051120232731.GG2556@spitz.ucw.cz>
References: <20051117200354.6acb3599.akpm@osdl.org>
	<20051119003435.GA29775@mars.ravnborg.org>
	<20051120232731.GG2556@spitz.ucw.cz>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@suse.cz>
Date: Sun, 20 Nov 2005 23:27:32 +0000

> Well, please don't do that. -Werror makes development very painful.

I've had all of arch/sparc64 in -Werror mode for more than a year,
and it's anything but painful.  It's prevented me from introducing
numerous bugs inadvertantly.

People miss warnings or flat out ignore them, if the build fails they
will have to fix it up instead before sending in their changes.

Yes, for a spot like kernel/ it's more difficult since it's
compilation is influenced by so many configuration and platform
specific stuff, but that's just too bad.  Getting it warning free is
still something we can and should do.

Saying it's too hard, so we shouldn't even try, is a self-fufilling
prophecy.  I definitely want to add -Werror to net/ very very soon.
