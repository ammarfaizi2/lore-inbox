Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUC3Bok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUC3Bok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:44:40 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:2397 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263467AbUC3Boi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:44:38 -0500
Date: Mon, 29 Mar 2004 16:47:01 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040329164701.0edff5e4.pj@sgi.com>
In-Reply-To: <1080606618.6742.89.camel@arrakis>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1080606618.6742.89.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following typo needs fixing.  I had double opening
brace, instead of parenthesis-brace.  Time to increase
my screen font size.

===== include/linux/mask.h 1.3 vs edited =====
--- 1.3/include/linux/mask.h    Mon Mar 29 17:10:27 2004
+++ edited/include/linux/mask.h Mon Mar 29 17:37:01 2004
@@ -352,13 +352,13 @@
 })

 #define MASK_ALL(nbits)
-{{
+({
        [0 ... BITS_TO_LONGS(nbits)-1] = ~0UL,
        [BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)
 }}

 #define MASK_NONE(nbits)
-{{
+({
        [0 ... BITS_TO_LONGS(nbits)-1] =  0UL
 }}

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
