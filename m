Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSKAMOD>; Fri, 1 Nov 2002 07:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbSKAMOD>; Fri, 1 Nov 2002 07:14:03 -0500
Received: from urtica.linuxnews.pl ([217.67.200.130]:62982 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S262314AbSKAMOC> convert rfc822-to-8bit; Fri, 1 Nov 2002 07:14:02 -0500
Date: Fri, 1 Nov 2002 13:20:24 +0100 (CET)
From: Pawel Kot <pkot@bezsensu.pl>
X-X-Sender: <pkot@urtica.linuxnews.pl>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Anton Altaparmakov <aia21@cantab.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45: NTFS unresolved symbol
In-Reply-To: <200211010431.00941.Dieter.Nuetzel@hamburg.de>
Message-ID: <Pine.LNX.4.33.0211011318270.5622-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Dieter [iso-8859-15] Nützel wrote:

> depmod: *** Unresolved symbols in /lib/modules/2.5.45/kernel/fs/ntfs/ntfs.o
> depmod:         page_states__per_cpu
> /lib/modules/2.5.45/kernel/fs/ntfs/ntfs.o

Hi, The following patch should fix it:
--- kernel/ksyms.c~	Fri Nov  1 13:16:51 2002
+++ kernel/ksyms.c	Fri Nov  1 13:16:51 2002
@@ -112,6 +112,7 @@
 EXPORT_SYMBOL(vunmap);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(remap_page_range);
+EXPORT_SYMBOL(page_states__per_cpu);
 #ifndef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(contig_page_data);
 EXPORT_SYMBOL(mem_map);

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

