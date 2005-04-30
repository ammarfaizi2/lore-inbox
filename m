Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVD3HcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVD3HcH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 03:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVD3HcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 03:32:07 -0400
Received: from mx2.mail.ru ([194.67.23.122]:60549 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262542AbVD3HcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 03:32:00 -0400
Date: Sat, 30 Apr 2005 11:35:19 +0000
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Tell users to install xmlto, not stylesheets
Message-ID: <20050430113519.GA9309@mipter.zuzino.mipt.ru>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai@germaschewski.name>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stylesheets_xmlto.patch"

We have at least two users which were confused by these messages, myself
included.

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

--- linux-2.6.12-rc3-mm1/Documentation/DocBook/Makefile	2005-04-30 11:20:31.000000000 +0000
+++ linux-2.6.12-rc3-mm1-xmlto/Documentation/DocBook/Makefile	2005-04-30 11:22:25.000000000 +0000
@@ -101,7 +101,7 @@ quiet_cmd_db2ps = XMLTO    $@
       cmd_db2ps = xmlto ps $(XMLTOFLAGS) -o $(dir $@) $<
 %.ps : %.xml
 	@(which xmlto > /dev/null 2>&1) || \
-	 (echo "*** You need to install DocBook stylesheets ***"; \
+	 (echo "*** You need to install xmlto ***"; \
 	  exit 1)
 	$(call cmd,db2ps)
 
@@ -109,7 +109,7 @@ quiet_cmd_db2pdf = XMLTO   $@
       cmd_db2pdf = xmlto pdf $(XMLTOFLAGS) -o $(dir $@) $<
 %.pdf : %.xml
 	@(which xmlto > /dev/null 2>&1) || \
-	 (echo "*** You need to install DocBook stylesheets ***"; \
+	 (echo "*** You need to install xmlto ***"; \
 	  exit 1)
 	$(call cmd,db2pdf)
 
@@ -120,7 +120,7 @@ quiet_cmd_db2html = XMLTO  $@
 
 %.html:	%.xml
 	@(which xmlto > /dev/null 2>&1) || \
-	 (echo "*** You need to install DocBook stylesheets ***"; \
+	 (echo "*** You need to install xmlto ***"; \
 	  exit 1)
 	@rm -rf $@ $(patsubst %.html,%,$@)
 	$(call cmd,db2html)
@@ -131,7 +131,7 @@ quiet_cmd_db2man = XMLTO   $@
       cmd_db2man = if grep -q refentry $<; then xmlto man $(XMLTOFLAGS) -o $(obj)/man $< ; gzip -f $(obj)/man/*.9; fi
 %.9 : %.xml
 	@(which xmlto > /dev/null 2>&1) || \
-	 (echo "*** You need to install DocBook stylesheets ***"; \
+	 (echo "*** You need to install xmlto ***"; \
 	  exit 1)
 	$(call cmd,db2man)
 	@touch $@

--a8Wt8u1KmwUX3Y2C--

