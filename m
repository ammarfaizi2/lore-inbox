Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263214AbTCWVAp>; Sun, 23 Mar 2003 16:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbTCWVAo>; Sun, 23 Mar 2003 16:00:44 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:4532 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263214AbTCWVAn>; Sun, 23 Mar 2003 16:00:43 -0500
Message-Id: <200303232111.h2NLBloa013334@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] slab.c cleanup
To: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Date: Sun, 23 Mar 2003 22:11:04 +0100
References: <20030323191010$7678@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

> - Don't create caches that are not multiples of L1_CACHE_BYTES.

This sounds a bit drastic to me considering that the vast majority
of kmalloc allocations that I see are either in the <32 byte or
in the 64..128 byte range. Enlarging the minimum size to 256
byte would immediately waste over 1MB on my machine...

        Arnd <><
