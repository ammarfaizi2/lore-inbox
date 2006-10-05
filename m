Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWJEVmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWJEVmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWJEVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:42:00 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:34738 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932244AbWJEVlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:41:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=gzgzjHfiUpKYYmNkhTS1yx1OFkpG7Wge9G+GvAJ6D7wa2PTa1Vh4PaQvvKbilvZU5+piiUthc4SvA2rHls6MG5xdRb8iN4MKETcfWg+ISNrwyzFq5Bns2x6TqjpmjZ6Hnu6iHybodV04w1xj4r5npkDy5LYNFzNBsIOBkeAAfhU=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 02/14] uml: revert wrong patch
Date: Thu, 05 Oct 2006 23:38:39 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213839.17268.28062.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Andi Kleen pointed out that -mcmodel=kernel does not make sense for userspace
code and would stop everything from working, and pointed out the correct fix for
the original bug (not easy to do for me).

Reverts part of commit 06837504de7b4883e92af207dbbab4310d0db0ed.

Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-x86_64 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 11154b6..87d6373 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -4,7 +4,7 @@ # Released under the GPL
 core-y += arch/um/sys-x86_64/
 START := 0x60000000
 
-_extra_flags_ = -fno-builtin -m64 -mcmodel=kernel
+_extra_flags_ = -fno-builtin -m64
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
