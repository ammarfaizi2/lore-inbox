Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUIMVHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUIMVHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268964AbUIMVHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:07:01 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:60599 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268961AbUIMVFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:05:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm5
Date: Mon, 13 Sep 2004 23:06:38 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20040913015003.5406abae.akpm@osdl.org>
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409132306.38340.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 of September 2004 10:50, Andrew Morton wrote:
> 
> Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
> 
>  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
> 
> and will later appear at
> 
>  
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm5/

It does not compile on SMP x86-64 w/ NUMA:

  CC      arch/x86_64/ia32/ia32_ioctl.o
In file included from fs/compat_ioctl.c:63,
                 from arch/x86_64/ia32/ia32_ioctl.c:14:
include/linux/reiserfs_fs.h:441: error: redefinition of `struct key'
include/linux/reiserfs_fs.h: In function `le_key_k_offset':
include/linux/reiserfs_fs.h:608: error: structure has no member named `u'
include/linux/reiserfs_fs.h:609: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `le_key_k_type':
include/linux/reiserfs_fs.h:620: error: structure has no member named `u'
include/linux/reiserfs_fs.h:621: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `set_le_key_k_offset':
include/linux/reiserfs_fs.h:633: error: structure has no member named `u'
include/linux/reiserfs_fs.h:634: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `set_le_key_k_type':
include/linux/reiserfs_fs.h:647: error: structure has no member named `u'
include/linux/reiserfs_fs.h:648: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `cpu_key_k_offset':
include/linux/reiserfs_fs.h:677: error: structure has no member named `u'
include/linux/reiserfs_fs.h:678: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `cpu_key_k_type':
include/linux/reiserfs_fs.h:684: error: structure has no member named `u'
include/linux/reiserfs_fs.h:685: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `set_cpu_key_k_offset':
include/linux/reiserfs_fs.h:691: error: structure has no member named `u'
include/linux/reiserfs_fs.h:692: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `set_cpu_key_k_type':
include/linux/reiserfs_fs.h:699: error: structure has no member named `u'
include/linux/reiserfs_fs.h:700: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `cpu_key_k_offset_dec':
include/linux/reiserfs_fs.h:707: error: structure has no member named `u'
include/linux/reiserfs_fs.h:709: error: structure has no member named `u'
include/linux/reiserfs_fs.h: In function `le_key_version':
include/linux/reiserfs_fs.h:1869: error: structure has no member named `u'
make[1]: *** [arch/x86_64/ia32/ia32_ioctl.o] Error 1
make: *** [arch/x86_64/ia32] Error 2

The .config is available at: 
http://www.sisk.pl/kernel/040913/2.6.9-rc1-mm5-NUMA.config

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
