Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVA3Wii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVA3Wii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVA3Wih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:38:37 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:21607 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261813AbVA3Whk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:37:40 -0500
Date: Sun, 30 Jan 2005 23:39:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: shorthand ym2y, ym2m etc
Message-ID: <20050130223926.GG14816@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050130193733.GA8984@mars.ravnborg.org> <20050130195230.GA871@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130195230.GA871@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 07:52:30PM +0000, Christoph Hellwig wrote:
> 
> obj-$(CONFIG_FB)$(CONFIG_PPC)		+= macmodes.o
> 
> would be a lot more obvious, but I'm not sure how to handle
> it for the case where one of them evaluates to m

The real problem is when say CONFIG_FB are empty. Then kbuild will see:
obj-$(CONFIG_PPC) which I doubt was what you wanted.

This can be fixed by changing Kconfig to evaluate all known symbols to
either y,m,n - in contradiction to today where symbols that evaluate
to n is left empty.

	Sam
