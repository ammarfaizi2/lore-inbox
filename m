Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318943AbSIJBIP>; Mon, 9 Sep 2002 21:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318972AbSIJBIO>; Mon, 9 Sep 2002 21:08:14 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:53766 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S318943AbSIJBIO>; Mon, 9 Sep 2002 21:08:14 -0400
X-WebMail-UserID: bvadapal
Date: Mon, 9 Sep 2002 21:12:57 -0400
From: Venu Vadapalli <bvadapal@vt.edu>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002964
Subject: vmalloc/vfree
Message-ID: <3D81FB0C@zathras>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.62
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at vmalloc implementation, it fills the page table mappings (pgd and 
pmd) of only init_mm. When other tasks access these pages their mappings are 
updated on demand by the page fault handler, right? Vfree, also, updates the 
entries of just init_mm and, of course, flushes the cache and the tlb. But 
what about other tasks that have acquired mappings to these pages?

-Venu


