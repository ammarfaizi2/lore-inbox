Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264034AbUD0Mgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUD0Mgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbUD0Mgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:36:33 -0400
Received: from ns.suse.cz ([82.208.2.84]:19978 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id S264034AbUD0Mgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:36:31 -0400
Message-ID: <408E53E8.50305@suse.cz>
Date: Tue, 27 Apr 2004 14:36:56 +0200
From: Michal Ludvig <mludvig@suse.cz>
Organization: SuSE CR, s.r.o.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto_null autoload
References: <Xine.LNX.4.44.0404231005130.26066-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0404231005130.26066-100000@thoron.boston.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070602060203070400030500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070602060203070400030500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Morris told me that:
> On Thu, 22 Apr 2004, Michal Ludvig wrote:
>>the attached patch enables autoload of crypto_null module. Please apply.
> 
> It would be nice to also have these for:
> 
> alias des3_ede des
> alias sha384 sha512

Attached.

Michal Ludvig
-- 
SUSE Labs                    mludvig@suse.cz | Cray is the only computer
(+420) 296.545.373        http://www.suse.cz | that runs an endless loop
Personal homepage http://www.logix.cz/michal | in just four hours.

--------------070602060203070400030500
Content-Type: text/plain;
 name="kernel-crypto-autoload-des+sha.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-crypto-autoload-des+sha.diff"

diff -upr linux-2.6.5.orig/crypto/des.c linux-2.6.5/crypto/des.c
--- linux-2.6.5.orig/crypto/des.c	2004-04-04 05:38:22.000000000 +0200
+++ linux-2.6.5/crypto/des.c	2004-04-26 13:09:08.847375208 +0200
@@ -1269,6 +1269,8 @@ static struct crypto_alg des3_ede_alg = 
 	.cia_decrypt	  	=	des3_ede_decrypt } }
 };
 
+MODULE_ALIAS("des3_ede");
+
 static int __init init(void)
 {
 	int ret = 0;
diff -upr linux-2.6.5.orig/crypto/sha512.c linux-2.6.5/crypto/sha512.c
--- linux-2.6.5.orig/crypto/sha512.c	2004-04-04 05:38:18.000000000 +0200
+++ linux-2.6.5/crypto/sha512.c	2004-04-26 13:09:45.647780696 +0200
@@ -348,6 +348,8 @@ static struct crypto_alg sha384 = {
         }
 };
 
+MODULE_ALIAS("sha384");
+
 static int __init init(void)
 {
         int ret = 0;

--------------070602060203070400030500--
