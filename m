Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVALElg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVALElg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 23:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVALEld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 23:41:33 -0500
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:35960 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261236AbVALElZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 23:41:25 -0500
Subject: [PATCH]add '--extra=+f' to ctags in Makefile in order to search
	for file names
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: kai@germaschewski.name, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1105504220.5047.42.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 Jan 2005 23:30:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I usually add the following to ctags in the Makefile so I can search for
file names in my editor. If you think others would find this useful too,
then please apply.

--- linux-2.6.10/Makefile.orig  2005-01-11 22:45:30.971843616 -0500
+++ linux-2.6.10/Makefile       2005-01-11 22:56:07.308105800 -0500
@@ -1167,7 +1167,7 @@
 define cmd_tags
        rm -f $@; \
        CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo
"-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
-       $(all-sources) | xargs ctags $$CTAGSF -a
+       $(all-sources) | xargs ctags $$CTAGSF -a --extra=+f
 endef

 TAGS: FORCE



