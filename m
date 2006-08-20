Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWHTRxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWHTRxu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWHTRxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:53:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19394 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751096AbWHTRxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:53:49 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060820003840.GA17249@openwall.com>
References: <20060820003840.GA17249@openwall.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:14:00 +0100
Message-Id: <1156097640.4051.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 04:38 +0400, ysgrifennodd Solar Designer:
> Willy and all,
> 
> Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
> set*uid() kill the current process rather than proceed with -EAGAIN when
> the kernel is running out of memory.  Apparently, alloc_uid() can't fail
> and return anyway due to properties of the allocator, in which case the
> patch does not change a thing.  But better safe than sorry.

Major behaviour change, non-standards compliant and is just an attempt
to wallpaper over problems. Was rejected by previous maintainers
already.

NAK  (think /usr/games/banner "NAK")

