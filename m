Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWJQV2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWJQV2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWJQV1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:27:33 -0400
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:50837 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750757AbWJQV1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=XdGjpF0LVnS5wG3Vc9iGkOIamnaLbgltzDNRfUZcykuQTOi+Q+LU5xIVSVZkninxoqojWR+G1xFstbsTjp6F+3pWBjiZIOkDhwB3CH3U860RarU4/kan7EkqIAR+rUguug6Er5FU0fdDTy8Jhrds/CCu0y2jpXd55yzJLFDerX8=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 09/10] uml: kconfig - silence warning
Date: Tue, 17 Oct 2006 23:27:21 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017212721.26445.88024.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Silence useless warning about undefined symbol in Kconfig.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig.char |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig.char b/arch/um/Kconfig.char
index 62d87b7..e03e40c 100644
--- a/arch/um/Kconfig.char
+++ b/arch/um/Kconfig.char
@@ -190,6 +190,11 @@ config HOSTAUDIO
 	tristate
 	default UML_SOUND
 
+#It is selected elsewhere, so kconfig would warn without this.
+config HW_RANDOM
+	tristate
+	default n
+
 config UML_RANDOM
 	tristate "Hardware random number generator"
 	help
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
