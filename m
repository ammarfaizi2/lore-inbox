Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUIWXH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUIWXH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUIWXHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:07:10 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:36822 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S267526AbUIWWzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:55:36 -0400
Date: Thu, 23 Sep 2004 15:55:16 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch/RFC]Removing zone and node ID from page->flags[0/3]
Cc: Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>
Message-Id: <20040923135108.D8CC.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.11.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. 

I updated my patches which remove zone and node ID from page->flags.
Page->flags is 32bit space and 19 bits of them have already been used on
2.6.9-rc2-mm2 kernel, and zone and node ID uses 8 bits on 32 archtecture.
So, remaining bits is only 5 bits. In addition, only 3 bits have remained
on 2.6.8.1 stock kernel.

But, my patches make more 8 bits space in page->flags again.
And kernel can use large number of node and types of zone.

These patches are for 2.6.9-rc2-mm2. 

Please comment.

Bye.
-- 
Yasunori Goto <ygoto at us.fujitsu.com>


