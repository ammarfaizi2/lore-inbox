Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWG3QlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWG3QlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWG3QlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:41:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:60977 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932365AbWG3QlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:41:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BzKPyXr3mdEhtBsyAoOMZeEo9hPqVZoCkUEFpxBk8pCwAsnITCkrTRHe6lcZVX6Pqg4ejs4QjnyQ8qsUPa94yedUKWLNOuFSNcydZiq1ZKNtSy8LYZYzNcReeYKkCbMkEPZ1fh7f9n8LGzsW/irSTrsLzcV6nncoblvG/M5zqgc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] making the kernel -Wshadow clean - neighbour.h and 'proc_handler'
Date: Sun, 30 Jul 2006 18:42:15 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301842.15598.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several hundred -Wshadow warnings, caused by include/net/neighbour.h,
by renaming the 'proc_handler' argument in the neigh_sysctl_register() 
prototype to 'handler', just like it is named in net/core/neighbour.c


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 include/net/neighbour.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18-rc2-git7-orig/include/net/neighbour.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2-git7/include/net/neighbour.h	2006-07-30 06:37:28.000000000 +0200
@@ -276,7 +276,7 @@ extern int			neigh_sysctl_register(struc
 						      struct neigh_parms *p,
 						      int p_id, int pdev_id,
 						      char *p_name,
-						      proc_handler *proc_handler,
+						      proc_handler *handler,
 						      ctl_handler *strategy);
 extern void			neigh_sysctl_unregister(struct neigh_parms *p);
 


