Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVCZLXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVCZLXP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 06:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVCZLXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 06:23:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8456 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262034AbVCZLXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 06:23:01 -0500
Date: Sat, 26 Mar 2005 12:22:56 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc2
Message-ID: <20050326112256.GN30052@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326004631.GC17637@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

here's a patch from Dave Jones, which is already in 2.6 and which I've
used in my local tree for 6 months now. It removes a useless NULL check
in zlib_inflateInit2_(), since 'z' is already dereferenced one line
before the test. Can in go in 2.4.30 please ?

Thanks,
Willy

--- ./lib/zlib_inflate/inflate.c.orig	Tue Jan  7 15:50:49 2003
+++ ./lib/zlib_inflate/inflate.c	Sat Sep 18 17:30:59 2004
@@ -50,8 +50,6 @@
       return Z_VERSION_ERROR;
 
   /* initialize state */
-  if (z == Z_NULL)
-    return Z_STREAM_ERROR;
   z->msg = Z_NULL;
   z->state = &WS(z)->internal_state;
   z->state->blocks = Z_NULL;

