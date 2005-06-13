Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVFMEZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFMEZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 00:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVFMEZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 00:25:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:46092 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261346AbVFMEZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 00:25:47 -0400
Date: Mon, 13 Jun 2005 06:25:38 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/2] lzma support: lzma compressed kernel image
Message-ID: <20050613042538.GE8907@alpha.home.local>
References: <20050607214128.GB2645@core.home> <20050612223150.GA26370@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612223150.GA26370@core.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 12:31:50AM +0200, Christian Leber wrote:
> On Tue, Jun 07, 2005 at 11:41:28PM +0200, Christian Leber wrote:
> 
> Also refined.
> And btw. it is together with PATCH 1/2 allready used by a rescue
> distribution :-)
(...)

> +$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
> +	lzma e $(obj)/vmlinux.bin $(obj)/vmlinux.bin.lzma
        ^^^^
Would you please use $(call if_changed,lzma) as it is in other places ?
This is very handy as it allows you to use another binary by simply
passing "cmd_lzma=" to make.

Thanks,
Willy

