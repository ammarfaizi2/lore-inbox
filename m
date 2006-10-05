Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWJEVmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWJEVmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWJEVmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:42:18 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:47732 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932248AbWJEVmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:42:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=NBz9SD3sGZADlccLRddvu8FAtLJBhPqPaK3Sv3Qw36y9ckLciwi3cLhfJhUMpuimszx1chgRyh+2VzuSuMpIxi5I+qthhlDc2soPEIvUmOdVIb2VGbdcZ3AvX9jibefBh97vmAY2n+AXHknrE9DsmrvReM9PSpibb4Mn+98s7Wc=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 09/14] uml: declare in Kconfig our partial LOCKDEP support
Date: Thu, 05 Oct 2006 23:39:02 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061005213902.17268.25046.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Declare UML partial support for LOCKDEP - however IRQFLAGS tracing requires some
coding which nobody did yet, so we cannot run full lockdep on UML. Grep for
CONFIG_TRACE_IRQFLAGS on i386 code to find their implementation.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index d753075..450547a 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -25,6 +25,19 @@ config PCI
 config PCMCIA
 	bool
 
+# Yet to do!
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default n
+
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
+config STACKTRACE_SUPPORT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
