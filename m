Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTEUMAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 08:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTEUMAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 08:00:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:50180 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261294AbTEUMAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 08:00:42 -0400
Date: Wed, 21 May 2003 16:13:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrew Morton <akpm@digeo.com>
Cc: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm7
Message-ID: <20030521161316.A3541@jurassic.park.msu.ru>
References: <20030519012336.44d0083a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030519012336.44d0083a.akpm@digeo.com>; from akpm@digeo.com on Mon, May 19, 2003 at 01:23:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 01:23:36AM -0700, Andrew Morton wrote:
> sound-core-memalloc-build-fix.patch
>   soubd/core/memalloc.c needs mm.h

Ditto sound/core/sgbuf.c, at least on alpha, for
mem_map and other page stuff.

Ivan.

--- 2.5/sound/core/sgbuf.c	Mon Apr  7 21:31:57 2003
+++ linux/sound/core/sgbuf.c	Mon Apr 14 19:15:11 2003
@@ -23,6 +23,7 @@
 #include <linux/version.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <sound/memalloc.h>
 
