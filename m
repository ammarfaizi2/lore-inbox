Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965329AbWJ2TXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbWJ2TXc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWJ2TXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:23:30 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:61262 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965333AbWJ2TUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=HTUA3ayDQTPA7q5lCwdzTTc34pP07N2y1DF2xgg6mOPyTdXbbAUkXpo8HdqBz5z9ekbwWF9DCPD4H6oc5npgzPEM1JdKvA86u5IWOgfDC3qJ0bujc0RlNEqLJCCwRcsIE2fynZL7b+cAr3h7qLXb3lxmI+ervROkAsJeMhzh9L4=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 09/11] uml ubd driver: use bitfields where possible
Date: Sun, 29 Oct 2006 20:20:46 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029192046.12292.72461.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Use bitfields for boolean fields in ubd data structure.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/ubd_kern.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 1a85d39..66dc23d 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -174,8 +174,8 @@ struct ubd {
 	__u64 size;
 	struct openflags boot_openflags;
 	struct openflags openflags;
-	int shared;
-	int no_cow;
+	unsigned shared:1;
+	unsigned no_cow:1;
 	struct cow cow;
 	struct platform_device pdev;
 };
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
