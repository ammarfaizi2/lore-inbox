Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbQKUOA2>; Tue, 21 Nov 2000 09:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130463AbQKUOAS>; Tue, 21 Nov 2000 09:00:18 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:20462 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130329AbQKUOAE>;
	Tue, 21 Nov 2000 09:00:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001121122617.88D1A26@ganymede.cdt.luth.se> 
In-Reply-To: <20001121122617.88D1A26@ganymede.cdt.luth.se> 
To: Hakan Lennestal <hakanl@cdt.luth.se>
Cc: Peter Samuelson <peter@cadcamlab.org>, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Nov 2000 13:29:51 +0000
Message-ID: <27102.974813391@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hakanl@cdt.luth.se said:
>  When it comes to the partition detection during bootup, udma4 or
> udma3 doesn't seem to matter. It passes approx. one out of ten times
> either way. 

How have you made it use udma3 at bootup? Something like the patch below?

Index: drivers/ide/hpt366.c
===================================================================
RCS file: /inst/cvs/linux/drivers/ide/Attic/hpt366.c,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 hpt366.c
--- drivers/ide/hpt366.c	2000/11/10 14:56:31	1.1.2.10
+++ drivers/ide/hpt366.c	2000/11/21 13:27:32
@@ -55,6 +55,8 @@
 };
 
 const char *bad_ata66_4[] = {
+	"IBM-DTLA-307045",
+	"IBM-DTLA-307030",
 	"WDC AC310200R",
 	NULL
 };

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
