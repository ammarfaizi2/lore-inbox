Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266607AbUG2IGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266607AbUG2IGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUG2IGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:06:40 -0400
Received: from denise.shiny.it ([194.20.232.1]:45246 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S266607AbUG2IGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:06:23 -0400
Message-ID: <XFMail.20040729100549.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20040728220733.GA16468@smtp.west.cox.net>
Date: Thu, 29 Jul 2004 10:05:49 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Cc: Kumar Gala <kumar.gala@freescale.com>, Sylvain Munaut <tnt@246tNt.com>,
       linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       olh@suse.de, Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-Jul-2004 Tom Rini wrote:

> I've taken the binutils-2.14+gcc-3.4 bit out (and none of the other
> cleanups) as it seems like we get 1-2 reports a week from this bad tools
> combination:

I had no time to do a lot of testing, but it seems that binutils 2.15 +
gcc 3.3.3 is a bad one too. I didn't try to compile the kernel (which
may also break), but at least I couldn't compile gcc 3.4.1 with the
above combination. It seems that as doesn't get the -mxxx parameter
required to compile altivec stuff. Hacking the Makefile to make it
pass -Wa,-m7455 helped a little, but it eventually failed in another
weird way. I hadn't time to investigate further, sorry.


--
Giuliano.
