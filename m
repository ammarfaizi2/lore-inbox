Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVCFACZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVCFACZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVCFACQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:02:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22157 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261235AbVCEX5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:57:38 -0500
Date: Sat, 5 Mar 2005 23:57:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kai Germaschewski <kai.germaschewski@unh.edu>
Cc: Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050305235713.GA31261@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kai Germaschewski <kai.germaschewski@unh.edu>,
	Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	Vincent Vanackere <vincent.vanackere@gmail.com>,
	keenanpepper@gmail.com,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050305130416.GA6373@stusta.de> <Pine.LNX.4.44.0503051012530.20560-100000@chaos.sr.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0503051012530.20560-100000@chaos.sr.unh.edu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 10:19:23AM -0500, Kai Germaschewski wrote:
> On Sat, 5 Mar 2005, Adrian Bunk wrote:
> 
> > And this can break as soon as the "unused" object files contains 
> > EXPORT_SYMBOL's.
> > 
> > Is it really worth it doing it in this non-intuitive way?
> 
> I don't think it non-intuitive, it's how libraries work. However, as you 
> say, it is broken for files containing EXPORT_SYMBOL.
> 
> The obvious fix for this case is the one that akpm mentioned way earlier 
> in this thread, move parser.o into $(obj-y).
> 
> It should be rather easy to have the kernel build system warn you when you 
> compile library objects exporting symbols.

Or rather get rid of librarz objects completely.  We manage to have explicit
depencies for 99% of our needs, do we really need a special cases that breaks
for most of it's current users?

