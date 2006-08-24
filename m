Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWHXRtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWHXRtS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWHXRtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:49:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15594 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030438AbWHXRtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:49:17 -0400
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Adrian Bunk <bunk@stusta.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060824103459.77e5569c.rdunlap@xenotime.net>
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
Content-Type: text/plain
Date: Thu, 24 Aug 2006 18:48:44 +0100
Message-Id: <1156441724.3012.183.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 10:34 -0700, Randy.Dunlap wrote:
> How do you do that if you have all of ISDN disabled and want/need
> to enable one ISDN driver?  or same problem for V4L(2)/dvb?
> or several other subsystems?  (e.g. sound)

If you _ever_ catch me getting confused because I'm trying to build an
ISDN driver and I can't work out that in order to do this, I might need
to first enable CONFIG_ISDN, then I promise you I will change my name by
deed poll to 'Aunt Tillie'.

It isn't hard to find dependencies by looking in the Kconfig files, even
if they are slightly less blindingly obvious than that example. I think
'make xconfig' will even show you the dependencies these days. I
remember even in about 1996 the Nemesis folks had hacked the old tcl
xconfig script to show dependencies.

Finding the brain-damaged 'select' which is preventing me from turning a
given option _off_, however, is something I tend to find far more
difficult. The CONFIG_EMBEDDED crap took up a painful amount of my time
last week when it bit me too.

-- 
dwmw2

