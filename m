Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUEJXRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUEJXRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUEJXRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:17:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:26546 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262902AbUEJXOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:14:33 -0400
Date: Mon, 10 May 2004 16:13:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] All Symbols in /proc/kallsyms
Message-ID: <20040510231336.GE2196@smtp.west.cox.net>
References: <1084166916.8127.46.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084166916.8127.46.camel@bach>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 03:28:37PM +1000, Rusty Russell wrote:

> Debuggers (ie. xmon) can use kallsyms, but they want all symbols, not
> just functions.  Fair enough.
> 
> Name: Debugging Option to Put text symbols in kallsyms
> Status: Tested on 2.6.6-rc3-bk11
> 
> kallsyms contains only function names, but some debuggers (eg. xmon on
> PPC/PPC64) use it to lookup symbols: it'd be much nicer if it included
> data symbols too.

Shouldn't you make xmon depend on both of these, on ppc64? 
(iirc, it won't compile w/o KALLSYMS, so select/suggest, or whatever,
and ppc32 hasn't yet had the kallsyms stuff backported).

-- 
Tom Rini
http://gate.crashing.org/~trini/
