Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTIFNzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 09:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbTIFNzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 09:55:35 -0400
Received: from www.piratehaven.org ([204.253.162.40]:47595 "EHLO
	skull.piratehaven.org") by vger.kernel.org with ESMTP
	id S261458AbTIFNze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 09:55:34 -0400
Date: Sat, 6 Sep 2003 06:55:33 -0700
From: Dale Harris <rodmur@maybe.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: compile problems on PPC for 2.6.0-test4
Message-ID: <20030906135533.GN29466@maybe.org>
Mail-Followup-To: Dale Harris <rodmur@maybe.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030906040904.GM29466@maybe.org> <1062835714.824.17.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062835714.824.17.camel@gaston>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 10:08:34AM +0200, Benjamin Herrenschmidt elucidated:
> 
> It shoud not be failing on this though:

No, it didn't fail, it was just a warning from the compiler.

> 
> #define mdelay(n) (\
> 	(__builtin_constant_p(n) && (n)<=MAX_UDELAY_MS) ? udelay((n)*1000) : \
> 	({unsigned long __ms=(n); while (__ms--) udelay(1000);}))
> 
> The __builtin_constant_p(5000) && (5000)<=5 test should fail thus
> turning into a loop of udelay(1000). Your gcc seems to be screwing
> it up. What version are you using ?

2.95.4, but this is from Debian unstable, package version: 2.95.4-17. 

> 
> The current bk snapshot I have here doesn't have a problem at this line.

BTW, I guess I wasn't compiling a straight vanilla kernel, it was off
your rsync server, source.mvista.com::linuxppc-2.5.  The vanilla kernel
bombs drivers/ide/ppc/pmac.c on my laptop.


-- 
Dale Harris   
rodmur@maybe.org
/.-)
