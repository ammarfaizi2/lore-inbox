Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbTCRQrf>; Tue, 18 Mar 2003 11:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbTCRQrf>; Tue, 18 Mar 2003 11:47:35 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43524 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262581AbTCRQre>; Tue, 18 Mar 2003 11:47:34 -0500
Date: Tue, 18 Mar 2003 17:58:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>, akpm@digeo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't refill pcp lists during SWSUSP.
Message-ID: <20030318165830.GB27387@atrey.karlin.mff.cuni.cz>
References: <1047945372.1714.19.camel@laptop-linux.cunninghams> <20030318081809.GB10472@atrey.karlin.mff.cuni.cz> <1047981979.2206.3.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047981979.2206.3.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You need to remember that this is infrastructure for later. I tried it
> other ways and would have needed a number of calls to drain local
> pages.

If you need 10x drain_local_pages(), that's okay -- because it does
not slow down non-suspend paths. If you need more of them... well then
I understand this is the way to go (but you should be able to hide
drain_local_pages in some local funcion or something...).
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
