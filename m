Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVEORpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVEORpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 13:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVEORpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 13:45:09 -0400
Received: from waste.org ([216.27.176.166]:15038 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261169AbVEORpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 13:45:03 -0400
Date: Sun, 15 May 2005 10:39:23 -0700
From: Matt Mackall <mpm@selenic.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: pasky@ucw.cz, git@vger.kernel.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mercurial@selenic.com, torvalds@osdl.org
Subject: Re: Mercurial 0.4e vs git network pull
Message-ID: <20050515173923.GK5914@waste.org>
References: <200505151122.j4FBMJa01073@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505151122.j4FBMJa01073@adam.yggdrasil.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 04:22:19AM -0700, Adam J. Richter wrote:
> On Sun, 15 May 2005 10:54:05 +0200, Petr Baudis wrote:
> >Dear diary, on Thu, May 12, 2005 at 10:57:35PM CEST, I got a letter
> >where Matt Mackall <mpm@selenic.com> told me that...
> >> Does this need an HTTP request (and round trip) per object? It appears
> >> to. That's 2200 requests/round trips for my 800 patch benchmark.
> 
> >Yes it does. On the other side, it needs no server-side CGI. But I guess
> >it should be pretty easy to write some kind of server-side CGI streamer,
> >and it would then easily take just a single HTTP request (telling the
> >server the commit ID and receiving back all the objects).
> 
> 	I don't understand what was wrong with Jeff Garzik's previous
> suggestion of using http/1.1 pipelining to coalesce the round trips.

You can't do pipelining if you can't look ahead far enough to fill the pipe.

-- 
Mathematics is the supreme nostalgia of our time.
