Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUHZEod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUHZEod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267529AbUHZEod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:44:33 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:19323 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267507AbUHZEoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:44:30 -0400
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
X-Message-Flag: Warning: May contain useful information
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 25 Aug 2004 21:42:28 -0700
In-Reply-To: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net> (jmerkey@comcast.net's
 message of "Thu, 26 Aug 2004 04:21:48 +0000")
Message-ID: <52n00ibjd7.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Aug 2004 04:42:28.0354 (UTC) FILETIME=[17441620:01C48B27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    jmerkey> That incredibly useful patch for 2.4.X that Andrea wrote
    jmerkey> that splits the kernel user space into 1GB/2GB/3GB
    jmerkey> sections I ported to 2.6.8.1 and posted it to:

    jmerkey> ftp.kernel.org:/pub/linux/kernel/people/jmerkey/patches/linux-2.6.8.1-highmem-split-08-25-04.patch

This is indeed pretty useful.  A few comments on your version of the patch:

 - might as well post a patch this small inline
 - In Kconfig, what happens if someone turns on highmem?  It seems all
   the USER_XXX choices depend on NOHIGHMEM.  also, the config option
   probably needs at least some help text.
 - the change to vmlinux.ld.S can be dropped from future versions
   (Linus merged this post-2.6.8)
 - why create PAGE_OFFSET_RAW in asm-generic, when it depends on
   i386-only config symbols and is only used in i386?
 - what's the reason for the odd rewrite of free_one_pgd()? it looks
   equivalent (and misindented)

Thanks,
  Roland
