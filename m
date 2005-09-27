Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbVI0Wxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbVI0Wxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbVI0Wxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:53:36 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:10901 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965220AbVI0Wxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:53:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:Mime-Version:Content-Type:Content-Disposition:User-Agent;
  b=tYUrwnFk5xm9YvQg1FEeO+d2YKV6nZ3aSGJSdXV9zA5dIRSkg9amfyDyEIY9FCjtdHdCM+A+WqocG73kESZCW/deWL3s+WP1FljTdhkSWsVdsM49OEMZ/zG7XrQzKvfVCjsa+v+/EjWecSMw/R4L26Kbow56slMn1AboPXFZACU=  ;
Date: Wed, 28 Sep 2005 00:53:27 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: akpm@osdl.org
Cc: waite@skycomputers.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove check_region from arch/ppc/platforms/hdpu.c
Message-ID: <20050927225327.GA6752@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks as if this function is not called by anyone, so removing it
is perfectly safe. In addition,we get rid of one more call to check_region().

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>


--- 2.6.14-rc2/arch/ppc/platforms/hdpu.c.orig	2005-09-27 19:08:51.000000000 +0200
+++ 2.6.14-rc2/arch/ppc/platforms/hdpu.c	2005-09-27 19:09:01.000000000 +0200
@@ -609,12 +609,6 @@ static void parse_bootinfo(unsigned long
 	}
 }
 
 #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-static int hdpu_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
 static void
 hdpu_ide_request_region(ide_ioreg_t from, unsigned int extent, const char *name)
 {

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
