Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUCHIxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 03:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbUCHIxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 03:53:00 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:22874 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262435AbUCHIw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 03:52:58 -0500
Date: Mon, 8 Mar 2004 19:52:34 +1100
From: Nathan Scott <nathans@sgi.com>
To: Olaf Hering <olh@suse.de>, akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5 cset 1.1654.1.2  xfs filemap_flush() unresolved
Message-ID: <20040308195234.A132331@wobbly.melbourne.sgi.com>
References: <20040307052556.4BABC468E4@mandarine.suse.de> <20040307161550.GA2812@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040307161550.GA2812@suse.de>; from olh@suse.de on Sun, Mar 07, 2004 at 05:15:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 05:15:50PM +0100, Olaf Hering wrote:
> 
> filemap_flush() is not an exported symbol, at least not in my tree.
> 

Thanks Olaf,

Trivial fix follows (for modular XFS builds).

cheers.

-- 
Nathan


--- mm/filemap.c.orig	2004-03-08 19:44:18.904099904 +1100
+++ mm/filemap.c	2004-03-08 19:44:45.641035272 +1100
@@ -168,6 +168,8 @@
 	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
 }
 
+EXPORT_SYMBOL(filemap_flush);
+
 /**
  * filemap_fdatawait - walk the list of locked pages of the given address
  *                     space and wait for all of them.
