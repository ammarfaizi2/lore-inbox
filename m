Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWEKTjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWEKTjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWEKTjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:39:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:59 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750735AbWEKTjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:39:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EA283TQKHuBtjKc7mii/EDfzHjnhUvJsqszPmfzxXkq7Jy9r9EggVAYNYGABUB20cbp66TK8S6ZR2jzqWRRjP01/8HipeeA8yRhq77Nv110G1PCXmcGb7cWg1y5JIFyu/kGI+hkuRxn8EjohNYqwVRgIUnw1DEl54O9PMUGAkY4=
Date: Thu, 11 May 2006 23:37:54 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/compat.c: fix 'if (a |= b )' typo
Message-ID: <20060511193754.GD11194@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mentioned by Mark Armbrust somewhere on Usenet.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1913,7 +1913,7 @@ asmlinkage long compat_sys_ppoll(struct
 	}
 
 	if (sigmask) {
-		if (sigsetsize |= sizeof(compat_sigset_t))
+		if (sigsetsize != sizeof(compat_sigset_t))
 			return -EINVAL;
 		if (copy_from_user(&ss32, sigmask, sizeof(ss32)))
 			return -EFAULT;

