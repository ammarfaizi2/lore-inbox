Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTEIOkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 10:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTEIOkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 10:40:35 -0400
Received: from holomorphy.com ([66.224.33.161]:33696 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262275AbTEIOke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 10:40:34 -0400
Date: Fri, 9 May 2003 07:53:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm3
Message-ID: <20030509145307.GA8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030508013958.157b27b7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508013958.157b27b7.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 01:39:58AM -0700, Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.69-mm3.gz
>   Will appear sometime at
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm3/

This comment looks stale; AIUI the behavior coded is what's desired.
This came up in a discussion with some implementors of a language
runtime about the cause of failures to open large files.

-- wli

diff -prauN linux-2.5.69-1/fs/open.c open-2.5.69-1/fs/open.c
--- linux-2.5.69-1/fs/open.c	Wed Apr  9 06:42:36 2003
+++ open-2.5.69-1/fs/open.c	Fri May  9 07:19:25 2003
@@ -902,7 +902,7 @@
 
 /*
  * Called when an inode is about to be open.
- * We use this to disallow opening RW large files on 32bit systems if
+ * We use this to disallow opening large files on 32bit systems if
  * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
  * on this flag in sys_open.
  */
