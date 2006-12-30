Return-Path: <linux-kernel-owner+w=401wt.eu-S1030276AbWL3GB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWL3GB2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 01:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWL3GB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 01:01:28 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:40001 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030276AbWL3GB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 01:01:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=hVcpDTlEHiuWjAyh52vjbQLL5Kp3Qhqf86wNM6F7dfy6TvdlHpWt1RMoDZYKrQYHYmL1OGLmISfd0fZ9oN0paL2EGlJc8wWQZE6QBIFUReOR/Z1O6MFIlwm5f63qQ6HzW4FNgHh7Km/XVHgR3XWViDYY8y9wiUy8zz8bV3PKygk=  ;
X-YMail-OSG: ilK9dDgVM1kzCtng0XvwDuDjBRjq1q5ofgEw_FFFoz5UCYlW._SJC9T9DDG.ECBTmdqxbbsGfTy5oZ1v7HOV8gIf41jUw6oEdZ.UQ8pzU7Wsr2yj.WsFkg--
From: David Brownell <david-b@pacbell.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Date: Fri, 29 Dec 2006 22:01:24 -0800
User-Agent: KMail/1.7.1
Cc: pHilipp Zabel <philipp.zabel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200612291821.44675.david-b@pacbell.net> <Pine.LNX.4.64.0612292141440.18171@xanadu.home>
In-Reply-To: <Pine.LNX.4.64.0612292141440.18171@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612292201.24989.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 December 2006 7:15 pm, Nicolas Pitre wrote:
> On Fri, 29 Dec 2006, David Brownell wrote:
> 
> > Here's a version that compiles ...
> 
> This patch is completely broken.

It's just what Philipp sent, with the "won't compile" bugs fixed.
Oh, and some #include tweaks.  Philipp?


> > Arch-neutral GPIO calls for PXA.
> 
> This is not PXA but SA1100 to start with.

I seem to have copied the wrong header comment, sorry; the original
patch had none.  It's marginally better than the header claiming it
was a PXA header...


> and you most probably need to protect the implied read-modify-write 
> cycle with a spinlock unless the generic gpio API expects this 
> protection is the responsibility of the caller.

No such lock is known to the caller.  Some of those calls will need
to move to a C file somewhere.

- Dave
