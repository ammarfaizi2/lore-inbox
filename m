Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVGSRtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVGSRtD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 13:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVGSRtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 13:49:03 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:50874 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261599AbVGSRs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 13:48:59 -0400
Date: Tue, 19 Jul 2005 19:48:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: files_lock deadlock?
In-Reply-To: <42DD2E37.3080204@fujitsu-siemens.com>
Message-ID: <Pine.LNX.4.61.0507191948120.89@yvahk01.tjqt.qr>
References: <42DD2E37.3080204@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I noticed that files_lock is only protected with spin_lock() (file_list_lock(),
> include/linux/fs.h). Is it possible that this should be changed to
> spin_lock_irq()) or spin_lock_irqsave()? Or am I misssing something obvious?

I'm probably stabbing in the dark, but I've seen ipt_owner of netfilter to 
talk about spin_lock_bh() wrt. files->file_lock.


Jan Engelhardt
-- 
