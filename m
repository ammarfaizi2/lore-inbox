Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVCFA0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVCFA0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVCFAYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:24:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24461 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261264AbVCEX6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:58:50 -0500
Date: Sat, 5 Mar 2005 23:58:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kai Germaschewski <kai.germaschewski@unh.edu>
Cc: Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050305235837.GB31261@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kai Germaschewski <kai.germaschewski@unh.edu>,
	Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	Vincent Vanackere <vincent.vanackere@gmail.com>,
	keenanpepper@gmail.com,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050305153638.GD6373@stusta.de> <Pine.LNX.4.44.0503051108300.20560-100000@chaos.sr.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0503051108300.20560-100000@chaos.sr.unh.edu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 11:36:23AM -0500, Kai Germaschewski wrote:
> However, I spoke too soon. There actually is a legitimate use for 
> EXPORT_SYMBOL() in a lib-y object, e.g. lib/dump_stack.c. This provides a 
> default implementation for dump_stack(). Most archs provide their own 
> implementation (and EXPORT_SYMBOL() it), and in this case we definitely 
> want the default version in lib to be thrown away, including its 
> EXPORT_SYMBOL. So the appended patch throws false positives and thus can 
> not be applied.

.. and should be replaced by CONFIG_GENERIC_DUMP_STACK or
__HAVE_ARCH_DUMP_STACK or something similar

