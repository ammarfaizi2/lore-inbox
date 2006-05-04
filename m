Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWEDHTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWEDHTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWEDHTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:19:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15562 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751420AbWEDHTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:19:15 -0400
Date: Thu, 4 May 2006 08:19:11 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] symlink nesting level change
Message-ID: <20060504071910.GI27946@ftp.linux.org.uk>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B309B@chicken.machinevisionproducts.com> <44580CF2.7070602@tlinx.org> <e3966u$dje$1@terminus.zytor.com> <20060503030849.GZ27946@ftp.linux.org.uk> <20060503183554.87f0218d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503183554.87f0218d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 06:35:54PM -0700, Andrew Morton wrote:
> It's a non-back-compatible change which means that people will install
> 2.6.18+, will set stuff up which uses more that five nested links and some
> will discover that they can no longer run their software on older kernels.
> 
> It'll only hurt a very small number of people, but for those people, it
> will hurt a lot.  And I can't really think of anything we can do to help
> them, apart from making the new behaviour runtime-controllable, defaulting
> to "off", but add a once-off printk when we hit MAX_NESTED_LINKS, pointing
> them at a document which tells them how to turn on the new behaviour and
> which explains the problems.  Which sucks.

Those people keep asking to lift that limit.  So no, I don't believe that
making it runtime-controllable is the right thing to do.  Document that
we'd lifted the limit to 8 and such setups become possible since <version>.
 
> But I guess as major distros are 2.6.16-based, this is a good time to make
> this change.

FWIW, RH kernels had that for more than a year by now...
