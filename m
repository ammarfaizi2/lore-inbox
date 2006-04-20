Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWDTSJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWDTSJG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWDTSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:09:06 -0400
Received: from ns.suse.de ([195.135.220.2]:21202 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751217AbWDTSJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:09:05 -0400
Date: Thu, 20 Apr 2006 20:09:04 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 1/5] mm: remap_vmalloc_range
Message-ID: <20060420180903.GF21660@wotan.suse.de>
References: <20060228202202.14172.60409.sendpatchset@linux.site> <20060228202212.14172.59536.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228202212.14172.59536.sendpatchset@linux.site>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hotfix #1


Index: linux-2.6/drivers/media/video/usbvideo/vicam.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/vicam.c
+++ linux-2.6/drivers/media/video/usbvideo/vicam.c
@@ -1000,6 +1000,7 @@ vicam_mmap(struct file *file, struct vm_
 	 * It shouldn't have been, so let's try this check again -np
 	 */
 	 if (size > VICAM_FRAMES*VICAM_MAX_FRAME_SIZE)
+		return -EINVAL;
 
 	if (remap_vmalloc_range(vma, cam->framebuf, 0))
 		return -EAGAIN;
