Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTH2Ufi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTH2UfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:35:16 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:62642 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261939AbTH2Uct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:32:49 -0400
Message-Id: <200308292032.h7TKWats006188@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Date: Fri, 29 Aug 2003 22:31:47 +0200
References: <pV54.523.43@gated-at.bofh.it> <pX6U.7Vu.35@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:

> Shouldn't the above use BUS_ID_SIZE instead of DEVICE_ID_SIZE?

Right. Actually, all uses of DEVICE_ID_SIZE in drivers/s390 are wrong.
I'll take care of that.

The only other user of DEVICE_ID_SIZE right now is drivers/usb/core/file.c
and I'm not sure if it's used in the intended way there.
Greg, maybe you want to get rid of it as well, or move the definition
into file.c.

        Arnd <><
