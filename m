Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVIUQrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVIUQrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVIUQrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:31 -0400
Received: from [151.97.230.9] ([151.97.230.9]:39310 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751124AbVIUQrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:07 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 04/10] uml: fix modify_ldt - missing break in switch
Date: Wed, 21 Sep 2005 18:38:57 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921163855.30500.65000.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I am a lamer :-(. Luckily, Luo Xin performed LTP testing and found this failure.
Btw, the fact that the patch in which I introduced this was merged shows that:

a) I'm really trusted by people
b) sometimes they're wrong about point a).
c) lack of time for reviewers.

CC: Luo Xin <luothing@sina.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-i386/ldt.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/sys-i386/ldt.c b/arch/um/sys-i386/ldt.c
--- a/arch/um/sys-i386/ldt.c
+++ b/arch/um/sys-i386/ldt.c
@@ -83,6 +83,7 @@ int sys_modify_ldt(int func, void __user
 			goto out;
 		}
 		p = buf;
+		break;
 	default:
 		res = -ENOSYS;
 		goto out;

