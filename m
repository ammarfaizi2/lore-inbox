Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVGWAl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVGWAl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVGWAjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:39:01 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:51342 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S262263AbVGWAgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:36:40 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con)
In-Reply-To: <20050723003140.GB1988@elf.ucw.cz>
References: <Pine.LNX.4.58.0507221942540.5475@skynet> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <20050723003140.GB1988@elf.ucw.cz>
Date: Sat, 23 Jul 2005 01:36:38 +0100
Message-Id: <E1Dw80M-0001EG-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> Unfortunately, if you only get printk() working after you ran
> userspace app... well it makes debugging things like SATA
> "interesting". So I quite like this patch.

Most interesting laptop vendors have at least one model in each range
with a serial port, which makes this sort of thing a bit easier. 

> If your BIOS does something wrong, well... your machine crashes.

I think it's hard to define it as "something wrong" - there's no reason
for BIOS authors to support the OS calling BIOS setup code after the
machine has booted. Thinkpads seem to manage this fine, Sonys tend to be
less good at it. Using the VBE mode setting code tends to be more
reliable, and is pretty much guaranteed to be there even after boot.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
