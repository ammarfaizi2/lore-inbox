Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUBNXC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 18:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbUBNXC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 18:02:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:42908 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263537AbUBNXC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 18:02:26 -0500
Subject: Re: [PATCH] back out fbdev sysfs support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040214172839.GA2065@redhat.com>
References: <20040214165037.GA15985@lst.de>
	 <Pine.LNX.4.58.0402140857520.13436@home.osdl.org>
	 <20040214170600.GA16147@lst.de>  <20040214172839.GA2065@redhat.com>
Content-Type: text/plain
Message-Id: <1076799722.868.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 10:02:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-15 at 04:28, Dave Jones wrote:
> On Sat, Feb 14, 2004 at 06:06:00PM +0100, Christoph Hellwig wrote:
> 
>  > What I meant is that the FB maintainer should try to get the existing
>  > fixes merged before adding dubious features.
> 
> Whilst on the subject, why does the fb code need sysfs support
> anyway ?

We want a class device so the drivers can expose some informations like
the monitor probing data (EDID), allowed modes list etc... to userland.

I now have access to these infos in some drivers like radeonfb that do
full monitor probing, and the fbdev "API" provides no way to get that
down to userland (for use by xserver or MOL for example). I could just
add some cases to the existing ioctl API, but I don't like that ;)

Ben.


