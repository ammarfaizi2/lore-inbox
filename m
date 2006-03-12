Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWCLPsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWCLPsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWCLPsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:48:15 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:57066 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1751059AbWCLPsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:48:14 -0500
Date: Sun, 12 Mar 2006 16:48:23 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.16-rc6-mm1
Message-ID: <20060312154823.GC16013@ens-lyon.fr>
References: <20060312031036.3a382581.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> 
> 

fs/reiserfs/item_ops.c: In function 'indirect_print_item':
fs/reiserfs/item_ops.c:278: warning: 'num' may be used uninitialized in this function

num isn't used during the first iteration of the loop, but it does not harm to initialize
it anyway.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.fr>

Index: linux/fs/reiserfs/item_ops.c
===================================================================
--- linux.orig/fs/reiserfs/item_ops.c
+++ linux/fs/reiserfs/item_ops.c
@@ -275,7 +275,7 @@ static void indirect_print_item(struct i
 	int j;
 	__le32 *unp;
 	__u32 prev = INT_MAX;
-	int num;
+	int num = 0;
 
 	unp = (__le32 *) item;
 


-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
