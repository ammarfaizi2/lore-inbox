Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUBTTop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUBTTle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:41:34 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:272 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261366AbUBTTVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:21:51 -0500
Date: Fri, 20 Feb 2004 19:21:45 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Jonathan Brown <jbrown@emergence.uk.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Double fb_console_init call during do_initcalls
In-Reply-To: <20040220103851.3d27f5ab.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0402201907130.6798-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ugh.  fb_console_init() can be called by
> drivers/char/vt.c (one initcall) or drivers/video/fbmem.c or
> drivers/video/console/fbcon.c (<-- module_init/initcall).
> 
> It definitely wants to be cleaned up, but changing initcall
> order can be "fragile".  Have you tried/tested it?
> 
> Or maybe James Simmons has some updates for this.

I seen the report and begain to create a patch. The module_init fix is 
easy. Just place module_init and module_exit under #ifdef MODULE. I 
realize alot of fbdev drivers do this wrong. I will make patches by the 
end of the day. As for the fbmem.c call on fb_console_init. Well that is 
tricker to deal with. I will have to figure out a way.


