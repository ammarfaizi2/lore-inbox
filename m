Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWEPBFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWEPBFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWEPBFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:05:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34196 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750916AbWEPBFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:05:16 -0400
Subject: Re: Linux porting issue/question...
From: David Woodhouse <dwmw2@infradead.org>
To: jzb@aexorsyst.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605151518.53533.jzb@aexorsyst.com>
References: <200605151518.53533.jzb@aexorsyst.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 02:05:14 +0100
Message-Id: <1147741515.24328.3.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 15:18 -0700, John Z. Bohach wrote:
> However, running 'ls {somedir}' on a directory, any directory, always
> returns the error code for "EFAULT" (Bad address), at the user level.

Hack your copy_to_user() to printk and/or backtrace when it faults.
If that doesn't catch it, find any _other_ place where that call path
can return -EFAULT.

-- 
dwmw2

