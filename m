Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261734AbTCLPi5>; Wed, 12 Mar 2003 10:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261736AbTCLPi4>; Wed, 12 Mar 2003 10:38:56 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:64479 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S261734AbTCLPiN>; Wed, 12 Mar 2003 10:38:13 -0500
Date: Wed, 12 Mar 2003 16:48:49 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] Linux 2.4.21pre5-ac3 - change make_config to
 void
In-Reply-To: <Pine.LNX.4.51.0303121645130.10932@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.51.0303121647230.10932@dns.toxicfilms.tv>
References: <200303121500.h2CF0U2F000852@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.51.0303121645130.10932@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux 2.4.21pre5-ac3

scripts/mkconfigs.c:
make_configs is defined int, but the value is not used, and make_configs
does not return anything so it warns about: control reaching end of non
void function.


--- linux-2.4.20/scripts/mkconfigs.c~	2003-03-12 16:13:42.000000000 +0100
+++ linux-2.4.20/scripts/mkconfigs.c	2003-03-12 16:34:46.000000000 +0100
@@ -130,7 +130,7 @@
 	}
 }

-int make_configs (FILE *configfile, FILE *sourcefile)
+void make_configs (FILE *configfile, FILE *sourcefile)
 {
 	make_intro (sourcefile);
 	make_lines (configfile, sourcefile);
