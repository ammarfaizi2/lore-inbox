Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVAWFIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVAWFIm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 00:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVAWFIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 00:08:42 -0500
Received: from ns.suse.de ([195.135.220.2]:51137 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261227AbVAWFIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 00:08:38 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 1/13] Qsort
Date: Sun, 23 Jan 2005 06:08:36 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <20050122232814.GG3867@waste.org>
In-Reply-To: <20050122232814.GG3867@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501230608.36501.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 January 2005 00:28, Matt Mackall wrote:
> So the stack is going to be either 256 or 1024 bytes. Seems like we
> ought to kmalloc it.

This will do. I didn't check if the +1 is strictly needed.

-      stack_node stack[STACK_SIZE];
+      stack_node stack[fls(size) - fls(MAX_THRESH) + 1];

-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
