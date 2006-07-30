Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWG3Qe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWG3Qe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWG3Qe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:34:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:50976 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932353AbWG3Qe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:34:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AZs5eB3GxovFqE5ly+wtBgAut2WX6E7sSnWMcIEytEStrFhkV5gLA6HEIF0DHdL1zsBeMag8xwIRF7fzjZrAqhN0csaKnNCl7xUz/KHY/14oVHDKoq/ULeV9cGxM7IYIb4FuXvFxATROywoqWRJoxCW7dX9PKAAYIk8VdTtrbK0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Date: Sun, 30 Jul 2006 18:35:34 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301835.35053.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -Wshadow warnings in mconf


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 scripts/kconfig/mconf.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18-rc2-orig/scripts/kconfig/mconf.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/scripts/kconfig/mconf.c	2006-07-18 23:39:51.000000000 +0200
@@ -258,7 +258,7 @@ search_help[] = N_(
 
 static char buf[4096], *bufptr = buf;
 static char input_buf[4096];
-static char filename[PATH_MAX+1] = ".config";
+static char config_filename[PATH_MAX+1] = ".config";
 static char *args[1024], **argptr = args;
 static int indent;
 static struct termios ios_org;
@@ -983,7 +983,7 @@ static void conf_load(void)
 		cprint(load_config_text);
 		cprint("11");
 		cprint("55");
-		cprint("%s", filename);
+		cprint("%s", config_filename);
 		stat = exec_conf();
 		switch(stat) {
 		case 0:
@@ -1012,7 +1012,7 @@ static void conf_save(void)
 		cprint(save_config_text);
 		cprint("11");
 		cprint("55");
-		cprint("%s", filename);
+		cprint("%s", config_filename);
 		stat = exec_conf();
 		switch(stat) {
 		case 0:



