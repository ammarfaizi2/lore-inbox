Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWEQWNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWEQWNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWEQWMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:52 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15491 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751236AbWEQWMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:12 -0400
Message-Id: <20060517221358.082566000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       adobriyan@gmail.com, drepper@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/22] [PATCH] fs/compat.c: fix if (a |= b ) typo
Content-Disposition: inline; filename=fs-compat.c-fix-if-typo.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Mentioned by Mark Armbrust somewhere on Usenet.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Ulrich Drepper <drepper@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/compat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.16.orig/fs/compat.c
+++ linux-2.6.16.16/fs/compat.c
@@ -1901,7 +1901,7 @@ asmlinkage long compat_sys_ppoll(struct 
 	}
 
 	if (sigmask) {
-		if (sigsetsize |= sizeof(compat_sigset_t))
+		if (sigsetsize != sizeof(compat_sigset_t))
 			return -EINVAL;
 		if (copy_from_user(&ss32, sigmask, sizeof(ss32)))
 			return -EFAULT;

--
