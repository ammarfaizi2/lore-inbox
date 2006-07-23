Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWGWPZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWGWPZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGWPZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 11:25:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:34684 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751229AbWGWPZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 11:25:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZV3SMmcYKHd3A6zb3SH5L3EDbxEBku6pSmw2BU6I6cSXvnQfdT9Ncx7JU5oV6MM/cDaFo4sVJ788Yn7p2PO61de2Yws2UG2snkT1LCRt4oYn8B/1+vBwJUGAQ6OIMns6MFPr5mSH7X2yvjCSsPOsBXy7sm42nKjqWRkkgLWLWz8=
Date: Sun, 23 Jul 2006 19:25:51 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: Graphic: userspace headers interdependencies
Message-ID: <20060723152551.GA6816@martell.zuzino.mipt.ru>
References: <20060723101523.GS25367@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060723101523.GS25367@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2006 at 12:15:23PM +0200, Adrian Bunk wrote:
> I've written a quick'n'dirty script for visualizing the
> interdependencies of the i386 userspace headers in 2.6.18-rc2.
>
> In case anyone is interested, it's at [1] (warning: it's big).
>
> The graphic also shows some problems like headers including not exported
> headers. I'm currently working on fixing such issues in my hdrcleanup
> tree.

[PATCH] mqueue.h: don't include linux/types.h

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/include/linux/mqueue.h
+++ b/include/linux/mqueue.h
@@ -18,8 +18,6 @@
 #ifndef _LINUX_MQUEUE_H
 #define _LINUX_MQUEUE_H
 
-#include <linux/types.h>
-
 #define MQ_PRIO_MAX 	32768
 /* per-uid limit of kernel memory used by mqueue, in bytes */
 #define MQ_BYTES_MAX	819200

