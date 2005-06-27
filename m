Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVF0Aq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVF0Aq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVF0Aq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:46:27 -0400
Received: from smtp06.auna.com ([62.81.186.16]:38797 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261683AbVF0Aor convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:44:47 -0400
Date: Mon, 27 Jun 2005 00:44:45 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050626040329.3849cf68.akpm@osdl.org> (from akpm@osdl.org on
	Sun Jun 26 13:03:29 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119833085l.10734l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Mon, 27 Jun 2005 02:44:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.26, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/
> 
> 
> - A reminder that there is a vger mailing list for tracking patches which
>   are added to -mm.  Do
> 
>     `echo subscribe mm-commits | mail majordomo@vger.kernel.org'
> 
> - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
>   the recent PCI breakage sorted out.
> 
> - Big arch/cris update.
> 
> 

This is missing. Is it critical ?

--- 2.6.12/mm/memory.c	2005-06-17 20:48:29.000000000 +0100
+++ linux/mm/memory.c	2005-06-21 20:31:42.000000000 +0100
@@ -1051,7 +1051,7 @@ int remap_pfn_range(struct vm_area_struc
 {
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long end = addr + size;
+	unsigned long end = addr + PAGE_ALIGN(size);
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
 

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam4 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


