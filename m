Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288851AbSAFNH1>; Sun, 6 Jan 2002 08:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSAFNHV>; Sun, 6 Jan 2002 08:07:21 -0500
Received: from ns.suse.de ([213.95.15.193]:11539 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287866AbSAFNHG>;
	Sun, 6 Jan 2002 08:07:06 -0500
Date: Sun, 6 Jan 2002 14:07:05 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
In-Reply-To: <20020106123913.GA5407@krispykreme>
Message-ID: <Pine.LNX.4.33.0201061403120.3859-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Anton Blanchard wrote:

> Therefore there is no reason to waste 8 bytes per page when every page
> points to the same zone!

Some of the low end single zone machines (m68k, sparc32, arm etc)
could benefit from losing ->virtual too. wli has patches in
his dir on kernel.org that do this (and other struct page reductions)
The newer ones are against Rik's rmap vm though iirc, so you may have to
frob a bit to get them to play with the stock vm.

It'd be nice to see all these patches reducing this struct consolidated,
right now they're all ifdefing different bits with different names..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

