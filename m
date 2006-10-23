Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWJWPrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWJWPrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWJWPrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:47:53 -0400
Received: from xenotime.net ([66.160.160.81]:6327 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751054AbWJWPrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:47:51 -0400
Date: Mon, 23 Oct 2006 08:49:30 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] make pdfdocs broken in 2.6.19rc2 and needs fixes
Message-Id: <20061023084930.8d33a996.rdunlap@xenotime.net>
In-Reply-To: <1161601779.19388.20.camel@localhost.localdomain>
References: <200610222347.42418.ak@suse.de>
	<1161601779.19388.20.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 12:09:39 +0100 Alan Cox wrote:

> Ar Sul, 2006-10-22 am 23:47 +0200, ysgrifennodd Andi Kleen:
> > When you do make pdfdocs  with 2.6.19rc2-git7 you get tons of error 
> > messages and  then some corrupted PDFs in the end.
> 
> Some vendor shipped pdf and TeX tools are problematic. It works
> correctly on Red Hat except for kernel-api which has become too big for
> the default settings when ext4 was added. The TeX hash size gets
> exceeded, TeX emits
> 
> "! TeX capacity exceeded, sorry [hash size=60000].
> If you really absolutely need more capacity,
> you can ask a wizard to enlarge me."

I have a k-doc note to self which says something like "move all
filesystems from kernel-api to filesystems-api".  That was just
for compartmentalization or modularization, not to fix this tools
problem, but it would do that as well.  So I can do that soon.

> Really it would be nice to find a more modern way from the input to pdf
> without going via tex.

Agreed.

I've been thinking of exploring other transform tools, but I
haven't taken the time to do that yet.

---
~Randy
