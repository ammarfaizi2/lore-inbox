Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319027AbSHFJVC>; Tue, 6 Aug 2002 05:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319029AbSHFJVC>; Tue, 6 Aug 2002 05:21:02 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:64724 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S319027AbSHFJVB>; Tue, 6 Aug 2002 05:21:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] 16/18 add more possible root devices
Date: Tue, 6 Aug 2002 13:23:53 +0200
User-Agent: KMail/1.4.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Bernhard Kaindl <bk@suse.de>
References: <200208051830.50713.arndb@de.ibm.com> <200208051956.39722.arndb@de.ibm.com> <20020805181519.D16035@infradead.org>
In-Reply-To: <20020805181519.D16035@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208061323.53799.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 19:15, Christoph Hellwig wrote:
> On Mon, Aug 05, 2002 at 07:56:39PM +0200, Arnd Bergmann wrote:
> > This patch adds some more s/390 specific devices to the list of root
> > devices.
>
> Indentation is b0rked.

Thanks, this fixes indentation and removes the extra xpram entries noticed
by Bernd.

diff -ur linux-2.4.19-s390/init/do_mounts.c linux-2.4.19-s390-bootdev/init/do_mounts.c
--- linux-2.4.19-s390/init/do_mounts.c	Tue Aug  6 11:10:06 2002
+++ linux-2.4.19-s390-bootdev/init/do_mounts.c	Tue Aug  6 11:14:20 2002
@@ -162,6 +162,27 @@
 	{ "dasdf", (DASD_MAJOR << MINORBITS) + (5 << 2) },
 	{ "dasdg", (DASD_MAJOR << MINORBITS) + (6 << 2) },
 	{ "dasdh", (DASD_MAJOR << MINORBITS) + (7 << 2) },
+	{ "dasdi", (DASD_MAJOR << MINORBITS) + (8 << 2) },
+	{ "dasdj", (DASD_MAJOR << MINORBITS) + (9 << 2) },
+	{ "dasdk", (DASD_MAJOR << MINORBITS) + (10 << 2) },
+	{ "dasdl", (DASD_MAJOR << MINORBITS) + (11 << 2) },
+	{ "dasdm", (DASD_MAJOR << MINORBITS) + (12 << 2) },
+	{ "dasdn", (DASD_MAJOR << MINORBITS) + (13 << 2) },
+	{ "dasdo", (DASD_MAJOR << MINORBITS) + (14 << 2) },
+	{ "dasdp", (DASD_MAJOR << MINORBITS) + (15 << 2) },
+	{ "dasdq", (DASD_MAJOR << MINORBITS) + (16 << 2) },
+	{ "dasdr", (DASD_MAJOR << MINORBITS) + (17 << 2) },
+	{ "dasds", (DASD_MAJOR << MINORBITS) + (18 << 2) },
+	{ "dasdt", (DASD_MAJOR << MINORBITS) + (19 << 2) },
+	{ "dasdu", (DASD_MAJOR << MINORBITS) + (20 << 2) },
+	{ "dasdv", (DASD_MAJOR << MINORBITS) + (21 << 2) },
+	{ "dasdw", (DASD_MAJOR << MINORBITS) + (22 << 2) },
+	{ "dasdx", (DASD_MAJOR << MINORBITS) + (23 << 2) },
+	{ "dasdy", (DASD_MAJOR << MINORBITS) + (24 << 2) },
+	{ "dasdz", (DASD_MAJOR << MINORBITS) + (25 << 2) },
+#endif
+#ifdef CONFIG_BLK_DEV_XPRAM
+	{ "xpram", (XPRAM_MAJOR << MINORBITS) },
 #endif
 #if defined(CONFIG_BLK_CPQ_DA) || defined(CONFIG_BLK_CPQ_DA_MODULE)
 	{ "ida/c0d0p",0x4800 },

