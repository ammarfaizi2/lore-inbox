Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQLDEKp>; Sun, 3 Dec 2000 23:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbQLDEKf>; Sun, 3 Dec 2000 23:10:35 -0500
Received: from mail5.doit.wisc.edu ([144.92.9.76]:41476 "EHLO
	mail5.doit.wisc.edu") by vger.kernel.org with ESMTP
	id <S129523AbQLDEKU>; Sun, 3 Dec 2000 23:10:20 -0500
Message-Id: <200012040339.VAA43998@mail5.doit.wisc.edu>
Date: Sun, 03 Dec 2000 21:39:52 -0600
From: Erik Paulson <epaulson@students.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: Exporting access_process_vm
Reply-To: epaulson@students.wisc.edu
X-Mailer: Spruce 0.7.2 for X11 w/smtpio 0.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Back in September, David Howells sent in a one-line patch that just
exported
access_process_vm. It doesn't seem to have been applied, and there was no
discussion of it. 

Was it simply overlooked, or was there a good reason not to apply it and no
one
ever replied to the list about it? 

I'm dragging some checkpointing code into the Wonderful World of Linux 2.4,
and it'd
be great if I could chuck all the scary
walk-the-page-tables-and-hope-it-works
code that's currently in there with more modern stuff. 

Thanks!

-Erik

This was the original message: (I can re-create the "patch" against the
current
release, but it seemed straight-forward enough :)

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Could you please apply this little patch to export access_process_vm()?

Cheers,
David Howells
=============

diff -uNr linux-2.4.0-test8-orig/kernel/ksyms.c
linux-2.4.0-test8/kernel/ksyms.c
--- linux-2.4.0-test8-orig/kernel/ksyms.c Fri Sep 15 00:04:36 2000
+++ linux-2.4.0-test8/kernel/ksyms.c Mon Sep 11 23:39:38 2000
@@ -123,6 +123,7 @@
EXPORT_SYMBOL(find_vma);
EXPORT_SYMBOL(get_unmapped_area);
EXPORT_SYMBOL(init_mm);
+EXPORT_SYMBOL(access_process_vm);
#ifdef CONFIG_HIGHMEM
EXPORT_SYMBOL(kmap_high);
EXPORT_SYMBOL(kunmap_high);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
