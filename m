Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVJ2EZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVJ2EZP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVJ2EZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:25:14 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:11186 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751125AbVJ2EZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:25:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:Reply-To:To:Cc:Content-Type:Date:Message-Id:Mime-Version:X-Mailer;
  b=KE/QLWbCAXe8DXu69OzkSv3Rw3PutxnJNWZLIDl66vK2L2Bw5qIHCrhnvymBLh/y04LFeovSBGlRDNua7mJTqZSN9SVHrtl5bsXrIpvm6X71S0cpPkcbj7W8XAjiQShaOMKHcJnuFYnPGH8rTX9BJ6S4FXtXOFvUAFLI3Mk1SRI=  ;
Subject: [PATCH] Add ctag support for function prototypes and external
	variable declarations
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-JYWnmZbdiLMKoqbJbKEu"
Date: Sat, 29 Oct 2005 00:25:13 -0400
Message-Id: <1130559913.5606.41.camel@moblin.torolab.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JYWnmZbdiLMKoqbJbKEu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


This patch adds function prototypes and external variable declarations
to the set of tag kinds when running ctags. I find this useful when
perusing the kernel. Please apply.

Signed-off-by: John Kacur <jkacur@rogers.com>

---
diff -u linux-2.6.14/Makefile{orig,}


--=-JYWnmZbdiLMKoqbJbKEu
Content-Disposition: attachment; filename=Makefile.patch
Content-Type: text/x-patch; name=Makefile.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.14/Makefile.orig	2005-10-28 22:08:31.828865544 -0400
+++ linux-2.6.14/Makefile	2005-10-28 22:18:26.528457464 -0400
@@ -1227,7 +1227,7 @@
 quiet_cmd_TAGS = MAKE   $@
 define cmd_TAGS
 	rm -f $@; \
-	ETAGSF=`etags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
+	ETAGSF=`etags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f --c-kinds=+px"`; \
 	$(all-sources) | xargs etags $$ETAGSF -a
 endef
 
@@ -1238,7 +1238,7 @@
 quiet_cmd_tags = MAKE   $@
 define cmd_tags
 	rm -f $@; \
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f --c-kinds=+px"`; \
 	$(all-sources) | xargs ctags $$CTAGSF -a
 endef
 

--=-JYWnmZbdiLMKoqbJbKEu--

