Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWHXIZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWHXIZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 04:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWHXIZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 04:25:40 -0400
Received: from cs1.cs.huji.ac.il ([132.65.16.10]:6916 "EHLO cs1.cs.huji.ac.il")
	by vger.kernel.org with ESMTP id S1750839AbWHXIZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 04:25:39 -0400
Subject: bug report: mem_write
To: linux-kernel@vger.kernel.org
Date: Thu, 24 Aug 2006 11:25:37 +0300 (IDT)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1GGAWv-0001uP-Mu@lucifer.cs.huji.ac.il>
From: Amnon Shiloh <amnons@cs.huji.ac.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alright, I know that "mem_write" (fs/proc/base.c) is a "security hazard",
but I need to use it anyway (as super-user only), and find it broken,
somewhere between Linux-2.6.17 and Linux-2.6.18-rc4.

The point is that in the beginning of the routine, "copied" is set to 0,
but it is no good because in lines 805 and 812 it is set to other values.
Finally, the routine returns as if it copied 12 (=ENOMEM) bytes less than
it actually did.

Amnon.

