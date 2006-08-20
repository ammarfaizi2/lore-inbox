Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWHTSc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWHTSc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWHTSc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:32:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65455 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751118AbWHTSc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:32:26 -0400
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Willy Tarreau <w@1wt.eu>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060820182137.GO602@1wt.eu>
References: <20060820003840.GA17249@openwall.com>
	 <20060820100706.GB6003@steel.home> <20060820153037.GA20007@openwall.com>
	 <1156097013.4051.14.camel@localhost.localdomain>
	 <20060820181025.GN602@1wt.eu>
	 <1156099006.4051.43.camel@localhost.localdomain>
	 <20060820182137.GO602@1wt.eu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:52:59 +0100
Message-Id: <1156099979.4051.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 20:21 +0200, ysgrifennodd Willy Tarreau:
> Arjan proposed to add a __must_check on the set*uid() function in glibc.
> I think that if killing the program is what makes you nervous, we could
> at least print a warning in the kernel logs so that the admin of a machine
> being abused has a chance to detect what's going on. Would you accept
> something like this ?

That ratelimited doesn't sound unreasonable - you want to know its
happening whatever the cause. You could do it with the kernel or with
the audit daemon I guess.

