Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTFGJsz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 05:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTFGJsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 05:48:55 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:37269 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262912AbTFGJsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 05:48:54 -0400
Date: Sat, 7 Jun 2003 12:02:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.70-bk11 zlib merge #4 pure magic
Message-ID: <20030607100217.GB24694@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de> <20030606183247.GB10487@wohnheim.fh-wedel.de> <20030606183920.GC10487@wohnheim.fh-wedel.de> <20030606185210.GE10487@wohnheim.fh-wedel.de> <20030606192325.GG10487@wohnheim.fh-wedel.de> <20030606192814.GH10487@wohnheim.fh-wedel.de> <20030606200051.GI10487@wohnheim.fh-wedel.de> <20030606201306.GJ10487@wohnheim.fh-wedel.de> <16097.45833.384548.319399@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16097.45833.384548.319399@argo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 June 2003 19:40:25 +1000, Paul Mackerras wrote:
> 
> Your change won't affect PPP, since pppd already refuses to use
> windowBits == 8 (as a workaround for this bug).

Seems like I have misread the ppp code then.  In that case, please
remove the ppp part from the previous patch or use this one instead,
Linus.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu

--- linux-2.5.70-bk11/lib/zlib_deflate/deflate.c~zlib_merge_magic	2003-06-06 20:44:51.000000000 +0200
+++ linux-2.5.70-bk11/lib/zlib_deflate/deflate.c	2003-06-06 22:05:30.000000000 +0200
@@ -216,7 +216,7 @@
         windowBits = -windowBits;
     }
     if (memLevel < 1 || memLevel > MAX_MEM_LEVEL || method != Z_DEFLATED ||
-        windowBits < 8 || windowBits > 15 || level < 0 || level > 9 ||
+        windowBits < 9 || windowBits > 15 || level < 0 || level > 9 ||
 	strategy < 0 || strategy > Z_HUFFMAN_ONLY) {
         return Z_STREAM_ERROR;
     }
