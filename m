Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWIAQWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWIAQWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWIAQWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:22:48 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:42189 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932391AbWIAQWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:22:47 -0400
Date: Fri, 1 Sep 2006 18:19:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Roman Zippel <zippel@linux-m68k.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060901161920.GB32440@wohnheim.fh-wedel.de>
References: <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home> <1157069717.2347.13.camel@shinybook.infradead.org> <20060831174852.18efec7e.rdunlap@xenotime.net> <1157074048.2347.24.camel@shinybook.infradead.org> <20060901134425.GA32440@wohnheim.fh-wedel.de> <44F85267.1000607@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44F85267.1000607@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 September 2006 17:31:51 +0200, Stefan Richter wrote:
> 
> Yes and no. In the latter case, they have to magically know that at
> least menuconfig and xconfig can be tricked to list depending options.

True.  Marginally better than horrible then. :)

> Could be a fun project [...]

Absolutely.  Assuming that select gets removed in the process, and
concentrating on oldconfig, would it be enough to have something like
this in the .config?

# CONFIG_USB_STORAGE has unmet dependencies: CONFIG_SCSI, CONFIG_BLOCK

Now people looking for usb mass storage can find the option without
grepping through Kconfig files, but also every single driver for every
single disabled subsystem shows up.  Might be a bit too much.

Jörn

-- 
Invincibility is in oneself, vulnerability is in the opponent.
-- Sun Tzu
