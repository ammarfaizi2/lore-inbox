Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTILWRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTILWRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:17:30 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:45233 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261367AbTILWR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:17:29 -0400
Date: Sat, 13 Sep 2003 00:17:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ricardo Bugalho <ricardo.b@zmail.pt>
Cc: insecure@mail.od.ua, linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030912221717.GB11952@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309100034.58742.insecure@mail.od.ua> <pan.2003.09.11.11.06.59.523742@zmail.pt> <200309121826.22936.insecure@mail.od.ua> <1063387648.15891.26.camel@ezquiel.nara.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1063387648.15891.26.camel@ezquiel.nara.homeip.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 September 2003 18:27:29 +0100, Ricardo Bugalho wrote:
> On Fri, 2003-09-12 at 16:26, insecure wrote:
> 
> > How can you know that it won't evict useful code?
> 
> a) the code is at the beginning of the program
> b) its only run once
> 
> Therefore, its impact on i-cache is a non-issue.

> > > You can complain about the time it gets to fetch the code from
> > > RAM though.

Non-issue, eh? ;)

> I'll assume the goal is speed, not code size. Lets look at that piece of
> code:
> a) its only run once, so it doesn't benefict of caching

While it may not benefit from caching, cache misses still hurt it.
And as it is only run once, there are only cache misses (ignoring the
cacheline effect).  Shorter code is faster code.

> In modern, general purpose, computer systems, code size is irrelevant.
> It has been for 15 years and its not going to change.

- How long does you 50MB word processor take to load?
- Why do dietlibc and friends speed up server workloads?
- Why has Alan measured faster kernels with -Os than with -O2?

Code size *does* matter.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
