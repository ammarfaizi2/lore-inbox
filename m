Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbUACTLd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUACTLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:11:32 -0500
Received: from waste.org ([209.173.204.2]:26043 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263666AbUACTLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:11:22 -0500
Date: Sat, 3 Jan 2004 13:11:19 -0600
From: Matt Mackall <mpm@selenic.com>
To: Willy TARREAU <willy@w.ods.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.6.0-tiny1 tree for small systems
Message-ID: <20040103191119.GM18208@waste.org>
References: <20031227215606.GO18208@waste.org> <20031228103500.GA29298@alpha.home.local> <20040101014655.GD18208@waste.org> <20040103165051.GA2290@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103165051.GA2290@pcw.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 05:50:51PM +0100, Willy TARREAU wrote:
> BTW, I slightly changed your patch to be able to specify several
> options. I did it the dirty way because I don't know how to split
> the string into several words :

Doh, I fixed that but it didn't make it into the release:

+ifdef CONFIG_TINY_CFLAGS
+cflags-y += $(shell echo $(CONFIG_TINY_CFLAGS_VAL) | sed -e 's/"//g')
+else

> Other than that, I've compiled 2.6.1-rc1-tiny1. It's slightly
> smaller than 2.6.0-tiny1 here. But I had to keep CONFIG_INETPEER=y,
> CONFIG_DNOTIFY=y, CONFIG_PTRACE=y, and CONFIG_CPU_SUP_* otherwise it
> would not link. I can give you the error reports and .config in case
> you're interested.

Hmmm, works for me, error messages appreciated.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
