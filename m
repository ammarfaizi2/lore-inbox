Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWENAnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWENAnx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWENAnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:43:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27361 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751203AbWENAnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:43:52 -0400
Subject: Re: [PATCH] mtd: fix memory leak in block2mtd_setup()
From: David Woodhouse <dwmw2@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Simon Evans <spse@secret.org.uk>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
In-Reply-To: <200605140142.25486.jesper.juhl@gmail.com>
References: <200605140142.25486.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Sun, 14 May 2006 01:43:37 +0100
Message-Id: <1147567417.16761.3.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 01:42 +0200, Jesper Juhl wrote:
> There's a mem leak in drivers/mtd/devices/block2mtd.c::block2mtd_setup()
> 
> We can leak 'name' allocated with kmalloc in 'parse_name' if leave via
> the 'parse_err' macro since it contains a return but doesn't do any 
> freeing.
> 
> Spotted by coverity checker as bug 615.

Applied; thanks.

-- 
dwmw2

