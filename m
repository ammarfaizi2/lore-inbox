Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129437AbQLAS7L>; Fri, 1 Dec 2000 13:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbQLAS7B>; Fri, 1 Dec 2000 13:59:01 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:30483 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129437AbQLAS6r>; Fri, 1 Dec 2000 13:58:47 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14887.60824.271322.811343@wire.cadcamlab.org>
Date: Fri, 1 Dec 2000 12:27:36 -0600 (CST)
To: Marc Mutz <Marc@Mutz.com>
Cc: Android <android@turbosport.com>, linux-kernel@vger.kernel.org
Subject: [uPATCH] Re: Questions about Kernel 2.4.0.*
In-Reply-To: <001c01c05a86$45bb6380$19211518@vnnys1.ca.home.com>
	<20001130060732.A14250@wire.cadcamlab.org>
	<3A27CB48.38A1907C@Mutz.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Marc Mutz <Marc@Mutz.com>]
> Should that not be first converted to paths that contain no symlinks?

I agree.

--- Makefile~	Tue Nov 28 21:53:31 2000
+++ Makefile	Fri Dec  1 12:25:28 2000
@@ -10,7 +10,7 @@
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
 	  else if [ -x /bin/bash ]; then echo /bin/bash; \
 	  else echo sh; fi ; fi)
-TOPDIR	:= $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
+TOPDIR	:= $(shell pwd -P)
 
 HPATH   	= $(TOPDIR)/include
 FINDHPATH	= $(HPATH)/asm $(HPATH)/linux $(HPATH)/scsi $(HPATH)/net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
