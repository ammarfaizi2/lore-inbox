Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSF1N1P>; Fri, 28 Jun 2002 09:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSF1N1O>; Fri, 28 Jun 2002 09:27:14 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:37328 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id <S317251AbSF1N1N>; Fri, 28 Jun 2002 09:27:13 -0400
Message-ID: <3D1C64BD.4F57F3EE@bull.net>
Date: Fri, 28 Jun 2002 15:29:33 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel lock order
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a list describing the lock hierarchy ?
If not:
Does do_swap_page() (in mm/memory.c) release mm->page_table_lock because
one cannot hold this lock when lookup_swap_cache() ... __find_get_page()
takes pagecache_lock ? Or does it do only for shorten the locked path ?
(Can I keep mm->page_table_lock when I call __find_get_page() ?)

Thanks,

Zoltan Menyhart
