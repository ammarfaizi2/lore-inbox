Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264056AbTDOTzO (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbTDOTzO 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:55:14 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:56784 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264056AbTDOTzM 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 15:55:12 -0400
Message-Id: <200304152007.h3FK72sD003180@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [2.5] include/asm-generic/bitops.h {set,clear}_bit return  void
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       linux-kernel@vger.kernel.org
Date: Tue, 15 Apr 2003 22:04:59 +0200
References: <20030415174010$3e7e@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:

> +     mask = 1 << (nr & 0x1f);
> +     cli();
> +     *addr |= mask;
> +     sti();

cli() and sti() are no more. Moreover, the file you are trying to fix is
not even used anywhere. Better submit a patch to remove it completely.

        Arnd <><
