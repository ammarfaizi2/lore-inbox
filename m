Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbUK0CCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUK0CCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUKZTiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:38:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:55234 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262303AbUKZT0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:26:01 -0500
From: "Mario Gaucher" <zadiglist@zadig.ca>
To: adaplas@pol.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: Fix crash if fb_set_var() called before register_framebuffer()
Date: Thu, 25 Nov 2004 19:20:32 -0500
Message-Id: <20041125235955.M86030@zadig.ca>
In-Reply-To: <200411250115.50895.adaplas@hotpop.com>
References: <200411250115.50895.adaplas@hotpop.com>
X-Mailer: Open WebMail 2.41 20040926
X-OriginatingIP: 192.168.25.10 (zadig)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The field info->modelist is initialized during register_framebuffer.  This
> field is also referred to in fb_set_var().  Thus a call to fb_set_var()
> before register_framebuffer() will cause a crash.  A few drivers do this,
> notably controlfb.  (This might fix reports of controlfb crashing in
> powermacs).


this patch works well... I can now boot my PowerMac 7300 using
2.6.10-rc2-bk8 (that I got on kernel.org) with this patch...

but I still has some problem with my Matrox Millenium PCI card using
matroxfb driver... the kernel boot... but I get corrupted characters on
the console... X load ok and display ok...
It works really well with the onboard video (controlfb driver)

matroxfb driver works fine on 2.6.8

