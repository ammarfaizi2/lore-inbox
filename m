Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUHIBzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUHIBzb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 21:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUHIBzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 21:55:31 -0400
Received: from [61.155.114.21] ([61.155.114.21]:1042 "EHLO
	mail.mobilesoft.com.cn") by vger.kernel.org with ESMTP
	id S265789AbUHIBza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 21:55:30 -0400
Date: Mon, 9 Aug 2004 09:59:51 +0800
From: Wu Jian Feng <jianfengw@mobilesoft.com.cn>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
Message-ID: <20040809015950.GA20408@mobilesoft.com.cn>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20040807150458.E2805@flint.arm.linux.org.uk> <20040808061206.GA5417@mobilesoft.com.cn> <1091962414.1438.977.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091962414.1438.977.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 11:53:34AM +0100, David Woodhouse wrote:
> On Sun, 2004-08-08 at 14:12 +0800, Wu Jian Feng wrote:
> > Can't figure out why but have a quick workaround for this:
> 
> Erases are permitted to be asynchronous -- if the erase was submitted
> sucessfully, you may not free the object until the callback is called.
> You _may_ free the object from the callback, and we do.
> 
> Can I infer from this that you've actually seen the same problem? Could
> you reproduce it? What arch, compiler, etc?
> 
> -- 
> dwmw2
> 
> 

I see the same thing as rmk, used both gcc-3.3.2 and 3.4.0,
on a OMAP730 (arm926ejs).
