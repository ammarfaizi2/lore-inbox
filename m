Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVFTS1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVFTS1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVFTS1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:27:06 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:28129 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261422AbVFTS0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:26:53 -0400
Message-ID: <42B70A6D.7030308@namesys.com>
Date: Mon, 20 Jun 2005 11:26:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Edward Shishkin <edward@namesys.com>
Subject: Re: [PATCH] Fix Reiser4 Dependencies
References: <20050619233029.45dd66b8.akpm@osdl.org> <200506200832.22260.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200506200832.22260.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please discuss with Edward Shishkin.

Hans

Andrew James Wade wrote:

>*    ZLIB_INFLATE is not visible in menuconfig. Reiser4 should probably
>     just select it like the other filesystems do.
>
>*    Reiser4 also depends on ZLIB_DEFLATE.
>
>signed-off-by: Andrew Wade <ajwade@alumni.uwaterloo.ca>
>
>--- 2.6.12-mm1/fs/reiser4/Kconfig	2005-06-20 07:38:22.087653000 -0400
>+++ linux/fs/reiser4/Kconfig	2005-06-20 08:01:28.914324250 -0400
>@@ -1,6 +1,8 @@
> config REISER4_FS
> 	tristate "Reiser4 (EXPERIMENTAL)"
>-	depends on EXPERIMENTAL && !4KSTACKS && ZLIB_INFLATE
>+	depends on EXPERIMENTAL && !4KSTACKS
>+	select ZLIB_INFLATE
>+	select ZLIB_DEFLATE
> 	help
> 	  Reiser4 is a filesystem that performs all filesystem operations
> 	  as atomic transactions, which means that it either performs a
>
>
>  
>

