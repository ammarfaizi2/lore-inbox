Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbTLRGZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 01:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTLRGZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 01:25:46 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:6272 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265137AbTLRGZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 01:25:45 -0500
Subject: Re: 2.4.23aa1 ext3 oops
From: David Woodhouse <dwmw2@infradead.org>
To: Jamie Clark <jclark@metaparadigm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3FE14706.3070003@metaparadigm.com>
References: <3FA713B9.3040405@metaparadigm.com>
	 <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com>
	 <20031206010505.GB14904@dualathlon.random>
	 <3FD7D78A.4080409@metaparadigm.com>
	 <1071661358.13152.26.camel@imladris.demon.co.uk>
	 <3FE14706.3070003@metaparadigm.com>
Content-Type: text/plain
Message-Id: <1071728709.5316.2.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7.dwmw2.1) 
Date: Thu, 18 Dec 2003 06:25:09 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-18 at 14:19 +0800, Jamie Clark wrote:
> The first oops ocurred after 4 or 5 days. My second run crashed in the 
> first night, this time in filemap.c: precheck_file_write().
> This oops seemed to be at or near the first dereference of inode, before 
> the f_flags test.
> 
>         /* FIXME: this is for backwards compatibility with 2.4 */
>         if (!S_ISBLK(inode->i_mode) && (file->f_flags & O_APPEND))
>                 *ppos = pos = inode->i_size;

Odd. And what's 'inode' then? What compiler are you using?

> Is CONFIG_DEBUG_SLAB all that I need?

Yes, I believe so.

-- 
dwmw2


