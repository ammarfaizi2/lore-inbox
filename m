Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVBOS1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVBOS1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVBOS1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:27:11 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:49156 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP id S261794AbVBOS1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:27:06 -0500
Message-Id: <3.0.32.20050215192749.01165860@pop.xs4all.nl>
X-Mailer: Windows Eudora Pro Version 3.0 (32)
Date: Tue, 15 Feb 2005 19:27:49 +0100
To: linux-kernel@vger.kernel.org
From: Vincent Diepeveen <diep@xs4all.nl>
Subject: 2.6.7 modification, does it hurt?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good Morning,

In order to get to work suse 9.1 with 2.6.7 patched with quadrics
supercomputing network patches (which only work at vanilla 2.6.7) the
following function gave an error:
  "coproc_invalidate_range(mm,start,start+length);"
  in /mm/hugetlb.c in function zap_hugepage_range() 

I removed that coprop_invalidate_range() line.

Can it hurt?

It is in order to get x86-32 to work with the cards. x86-64 already works.
All nodes here are dual k7's with 1GB - 1.5GB ram
   
After removing that line, the kernel compiled, installed and booted fine
and quadrics network card (QM500) seems to function excellent as ever at
this node when performing tests. 

Under which conditions this change will give problems?

Thanks in advance for answerring,
Vincent Diepeveen
www.diep3d.com
diep@xs4all.nl


