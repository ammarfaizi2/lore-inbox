Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbTHGR0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbTHGR0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:26:22 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:52235 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268737AbTHGR0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:26:21 -0400
Date: Thu, 7 Aug 2003 18:26:19 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@suse.cz>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
 notification mecanism & PM
In-Reply-To: <1060263168.593.77.camel@gaston>
Message-ID: <Pine.LNX.4.44.0308071824520.13973-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I believe solution to this is simple: always switch to kernel-owned
> > console during suspend. (swsusp does it, there's patch for S3 to do
> > the same). That way, Xfree (or qtopia or whoever) should clean up
> > after themselves and leave the console to the kernel. (See
> > kernel/power/console.c)
> 
> I admit I quite like this solution. It would also help displaying
> something sane (blank, pattern, whatever) on screen during driver
> teardown instead of the junk left by X...

There is the case of framebuffer without VT console. Of course X can't 
work except with specific patches. X shouldn't be touching the console.



