Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932855AbWFXGDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbWFXGDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 02:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbWFXGDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 02:03:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53208 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932855AbWFXGDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 02:03:40 -0400
Date: Fri, 23 Jun 2006 23:00:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] mm/readahead.c: cleanups
Message-Id: <20060623230022.965f93b9.akpm@osdl.org>
In-Reply-To: <20060623105617.GS9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<20060623105617.GS9111@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:56:17 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> This patch contains the following cleanups:
> - make needlessly global code static
> - rename the global variable debug_level (sic) to readahead_debug_level
> - proper extern declaration for readahead_debug_level in 
>   include/linux/mm.h
> 

I can't really use this, since it sprinkles changes all over the patch
series.  Three separate patches would have been better, although even that
would be a hassle.

Anyway, I just edited the diffs, got most of it.

What does this

-	READAHEAD_DEBUGFS_ENTRY_U32(debug_level);
+	debugfs_create_u32("debug_level", 0644, root, &readahead_debug_level);

do?
