Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUHHKxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUHHKxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 06:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUHHKxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 06:53:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:58331 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265247AbUHHKxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 06:53:37 -0400
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
From: David Woodhouse <dwmw2@infradead.org>
To: Wu Jian Feng <jianfengw@mobilesoft.com.cn>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org, Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20040808061206.GA5417@mobilesoft.com.cn>
References: <20040807150458.E2805@flint.arm.linux.org.uk>
	 <20040808061206.GA5417@mobilesoft.com.cn>
Content-Type: text/plain
Message-Id: <1091962414.1438.977.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sun, 08 Aug 2004 11:53:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 14:12 +0800, Wu Jian Feng wrote:
> Can't figure out why but have a quick workaround for this:

Erases are permitted to be asynchronous -- if the erase was submitted
sucessfully, you may not free the object until the callback is called.
You _may_ free the object from the callback, and we do.

Can I infer from this that you've actually seen the same problem? Could
you reproduce it? What arch, compiler, etc?

-- 
dwmw2


