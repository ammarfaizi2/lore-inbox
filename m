Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWGFDwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWGFDwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWGFDwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:52:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1219
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965162AbWGFDwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:52:08 -0400
Date: Wed, 05 Jul 2006 20:52:33 -0700 (PDT)
Message-Id: <20060705.205233.39177061.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607060144.k661iH8d010317@harpo.it.uu.se>
References: <200607060144.k661iH8d010317@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 6 Jul 2006 03:44:17 +0200 (MEST)

> That could work. But it's a much larger patch than mine,
> and I don't want to go around hacking random other stuff
> just to repair atyfb. It's up the the Powers That Be to
> decide whether a local fix or a global one is most appropriate.
 ...
> That would require sbuslib.h to be completely benign on
> non-SPARC machines. If it is, great, but I can't currently
> guarantee that it is.

I've been aware of these warnings for a long time, but I've
done nothing about it because the fix is much worse than the
cure.

The is no reason the mach64 driver should be aware in any way
of these SBUS framebuffer ioctls.

Either we can find a way to make X stop issuing these ioctls
or simply ignore the kernel message, which frankly is harmless.
