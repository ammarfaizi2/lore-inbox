Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbUKFGlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUKFGlg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 01:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUKFGlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 01:41:36 -0500
Received: from port-222-152-48-85.fastadsl.net.nz ([222.152.48.85]:8320 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S261317AbUKFGle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 01:41:34 -0500
Message-Id: <6.2.0.10.2.20041106194124.01ec4ac8@tornado.reub.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.0.10 (Beta)
Date: Sat, 06 Nov 2004 19:41:35 +1300
To: linux-kernel@vger.kernel.org
From: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: Oops with 2.6.10-rc1-mm3
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops resolved by patching with:

-next = (address + PGDIR_SIZE) & PGDIR_MASK;
+next = (address + PML4_SIZE) & PML4_MASK;

The weird PHP problem is fixed in -mm3 as well.

Reuben



At 06:22 p.m. 6/11/2004, linux-kernel@vger.kernel.org wrote:
>Hi,
>
>I'm experiencing a problem with -mm3 on FC3-rawhide.  -mm2 did not do 
>this...but it had another problem (for some reason, -mm2 broke php 
>binaries on FC3-rawhide).  I haven't seen any mention of either of these 
>problems on LKML.
>
>Box is a P4-2.8/SMP/HT with multiple raid-1 volumes on reiser3.  Below is 
>the oops shown when booting up -mm3.

