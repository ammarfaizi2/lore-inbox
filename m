Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUH0Otw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUH0Otw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUH0Otw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:49:52 -0400
Received: from [192.188.244.13] ([192.188.244.13]:51460 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S265697AbUH0Otu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:49:50 -0400
Date: Fri, 27 Aug 2004 16:49:38 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-ntfs-dev@lists.sourceforge.net,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: RE: [Linux-NTFS-Dev] Fwd: 2.4.28-pre2 and ntfs-2.1.6b ?
Message-ID: <Pine.LNX.4.21.0408271619500.27072-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


O.Sezer wrote,

> With 2.4.28-pre2, ntfs-2.1.6b from linux-ntfs site
> started failing to compile at aops.c:
>
> aops.c: In function `ntfs_read_block':
> aops.c:315: parse error before "else"

This is a kernel header problem, introduced in 2.4.28-pre2 in
include/linux/mm.h where the problematic line

  #define SetPageUptodate(page) set_bit(PG_uptodate, &(page)->flags);

should be

  #define SetPageUptodate(page) set_bit(PG_uptodate, &(page)->flags)

Note, there is no ";" at the end of line in the latter case.

	Szaka


