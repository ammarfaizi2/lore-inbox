Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTI3Oaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTI3Oaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:30:46 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:16587 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261537AbTI3Oao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:30:44 -0400
Date: Tue, 30 Sep 2003 16:30:42 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] HugeTLB-less archs?
Message-ID: <Pine.GSO.4.21.0309301627210.7932-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Shouldn't this patch be applied to make sure allyesconfig works on
architectures that don't support HugeTLBs (yet)?

I'm not 100% we want the `|| BROKEN' there. What do you think?

--- linux-2.6.0-test6/fs/Kconfig	Sun Sep 28 09:36:23 2003
+++ linux-m68k-2.6.0-test6/fs/Kconfig	Tue Sep 30 16:22:02 2003
@@ -874,6 +874,7 @@
 
 config HUGETLBFS
 	bool "HugeTLB file system support"
+	depends X86 || IA64 || PPC64 || SPARC64 || X86_64 || BROKEN
 
 config HUGETLB_PAGE
 	def_bool HUGETLBFS

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

