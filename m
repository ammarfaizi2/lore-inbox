Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWHXR5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWHXR5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWHXR5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:57:53 -0400
Received: from xenotime.net ([66.160.160.81]:470 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751618AbWHXR5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:57:52 -0400
Date: Thu, 24 Aug 2006 11:01:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-Id: <20060824110102.d47a8659.rdunlap@xenotime.net>
In-Reply-To: <1156441724.3012.183.camel@pmac.infradead.org>
References: <32640.1156424442@warthog.cambridge.redhat.com>
	<20060824152937.GK19810@stusta.de>
	<1156434274.3012.128.camel@pmac.infradead.org>
	<20060824155814.GL19810@stusta.de>
	<1156435216.3012.130.camel@pmac.infradead.org>
	<20060824160926.GM19810@stusta.de>
	<20060824164752.GC5205@martell.zuzino.mipt.ru>
	<20060824170709.GO19810@stusta.de>
	<1156439763.3012.155.camel@pmac.infradead.org>
	<20060824103459.77e5569c.rdunlap@xenotime.net>
	<1156441724.3012.183.camel@pmac.infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 18:48:44 +0100 David Woodhouse wrote:

> On Thu, 2006-08-24 at 10:34 -0700, Randy.Dunlap wrote:
> > How do you do that if you have all of ISDN disabled and want/need
> > to enable one ISDN driver?  or same problem for V4L(2)/dvb?
> > or several other subsystems?  (e.g. sound)
> 
> If you _ever_ catch me getting confused because I'm trying to build an
> ISDN driver and I can't work out that in order to do this, I might need
> to first enable CONFIG_ISDN, then I promise you I will change my name by
> deed poll to 'Aunt Tillie'.

I'd rather use menuconfig or xconfig for that instead of editing
.config and reading multiple Kconfig files.

But I'd still prefer to have an "Enable all of this subsystem options first"
switch like I suggested a few months ago.  Makes it easier to view
and disable options.

> It isn't hard to find dependencies by looking in the Kconfig files, even
> if they are slightly less blindingly obvious than that example. I think
> 'make xconfig' will even show you the dependencies these days. I
> remember even in about 1996 the Nemesis folks had hacked the old tcl
> xconfig script to show dependencies.

menuconfig or xconfig will show dependencies now.

> Finding the brain-damaged 'select' which is preventing me from turning a
> given option _off_, however, is something I tend to find far more
> difficult. The CONFIG_EMBEDDED crap took up a painful amount of my time
> last week when it bit me too.

Ack.

---
~Randy
