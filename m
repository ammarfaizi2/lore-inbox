Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbTCGUXO>; Fri, 7 Mar 2003 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261764AbTCGUXN>; Fri, 7 Mar 2003 15:23:13 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:38822 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S261748AbTCGUXM>; Fri, 7 Mar 2003 15:23:12 -0500
Date: Fri, 7 Mar 2003 21:33:43 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] Re: Linux 2.5.64-ac3
In-Reply-To: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.51.0303072131570.23212@dns.toxicfilms.tv>
References: <200303071756.h27HuiY01551@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-23717851-936764168-1047069223=:23212"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---23717851-936764168-1047069223=:23212
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

> Linux 2.5.64-ac3
> o	Bring core IDE code into sync with the latest	(me)
> 	2.4.21pre5-ac code base. The drivers are not
> 	quite current with it yet.
There's a typo that breaks compiling ide-default.c

Here's the patch:

--- linux-2.5.60/drivers/ide/ide-default.c~	2003-03-07 20:32:32.000000000 +0100
+++ linux-2.5.60/drivers/ide/ide-default.c	2003-03-07 21:30:01.000000000 +0100
@@ -51,7 +51,7 @@
 	.name		=	"ide-default",
 	.version	=	IDEDEFAULT_VERSION,
 	.attach		=	idedefault_attach,
-	.supports_dma	=	1.
+	.supports_dma	=	1,
 	.drives		=	LIST_HEAD_INIT(idedefault_driver.drives)
 };

---23717851-936764168-1047069223=:23212
Content-Type: TEXT/plain; name="ide-default.c.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0303072133430.23212@dns.toxicfilms.tv>
Content-Description: ide-default.c.diff
Content-Disposition: attachment; filename="ide-default.c.diff"

LS0tIGxpbnV4LTIuNS42MC9kcml2ZXJzL2lkZS9pZGUtZGVmYXVsdC5jfgky
MDAzLTAzLTA3IDIwOjMyOjMyLjAwMDAwMDAwMCArMDEwMA0KKysrIGxpbnV4
LTIuNS42MC9kcml2ZXJzL2lkZS9pZGUtZGVmYXVsdC5jCTIwMDMtMDMtMDcg
MjE6MzA6MDEuMDAwMDAwMDAwICswMTAwDQpAQCAtNTEsNyArNTEsNyBAQA0K
IAkubmFtZQkJPQkiaWRlLWRlZmF1bHQiLA0KIAkudmVyc2lvbgk9CUlERURF
RkFVTFRfVkVSU0lPTiwNCiAJLmF0dGFjaAkJPQlpZGVkZWZhdWx0X2F0dGFj
aCwNCi0JLnN1cHBvcnRzX2RtYQk9CTEuDQorCS5zdXBwb3J0c19kbWEJPQkx
LA0KIAkuZHJpdmVzCQk9CUxJU1RfSEVBRF9JTklUKGlkZWRlZmF1bHRfZHJp
dmVyLmRyaXZlcykNCiB9Ow0KIA0K

---23717851-936764168-1047069223=:23212--
