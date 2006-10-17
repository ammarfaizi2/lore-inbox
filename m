Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWJQV1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWJQV1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWJQV1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:27:37 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:54651 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750732AbWJQV1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=newqv1WTii4xujwdsu5sPZNImhNn6MkG6D9+/PK0CB1qBZmX6bXMpjM6fvQyd0MbqVVw2fO9W5OzDg7ffozDWEs4xb+aXX4HD42kEvdWNvvwu9pLGGaUcsAX0IKUdiF5oIcYkPaPT4+EylReS2P7k7PxYHSvPXZHW8iQ3wcnH9Y=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 06/10] uml: reenable compilation of enable_timer, disabled by mistake
Date: Tue, 17 Oct 2006 23:27:15 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212715.26445.87166.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

CONFIG_MODE_TT does not work there, the UML_ prefixed version must be used -
this causes a link-time failure when CONFIG_MODE_TT is enabled (i.e. always
here, never by Jeff).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/time.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 38be096..2115b8b 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -16,6 +16,7 @@ #include "user.h"
 #include "process.h"
 #include "kern_constants.h"
 #include "os.h"
+#include "uml-config.h"
 
 int set_interval(int is_virtual)
 {
@@ -30,7 +31,7 @@ int set_interval(int is_virtual)
 	return 0;
 }
 
-#ifdef CONFIG_MODE_TT
+#ifdef UML_CONFIG_MODE_TT
 void enable_timer(void)
 {
 	set_interval(1);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
