Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVDDXGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVDDXGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDDXFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:05:12 -0400
Received: from main.gmane.org ([80.91.229.2]:52716 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261476AbVDDXDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:03:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@debian.org>
Subject: Re: [PATCH] create a kstrdup library function
Date: Mon, 04 Apr 2005 17:49:13 -0400
Message-ID: <pan.2005.04.04.21.49.11.94781@debian.org>
References: <42519911.508@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-24-194-62-26.nycap.res.rr.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Apr 2005 20:44:17 +0100, Paulo Marques wrote:

> 
> Hi,
> 
> This patch creates a new kstrdup library function and changes the 
> "local" implementations in several places to use this function.
> 
> This is just a cleanup to allow reusing the strdup code, and to prevent 
> bugs in future duplications of strdup.
> 

Just a minor nit; I would use a size_t in kstrdup(),
instead of an int, for the len.  All other functions dealing w/ the len
(strlen, kmalloc, memcpy) expect a size_t.




