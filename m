Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWJ0MZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWJ0MZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWJ0MZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 08:25:58 -0400
Received: from poczta.o2.pl ([193.17.41.142]:18576 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751781AbWJ0MZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 08:25:58 -0400
Date: Fri, 27 Oct 2006 14:31:11 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistent lock state in 2.6.18.1
Message-ID: <20061027123111.GA2898@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	John M Flinchbaugh <john@hjsoft.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025110024.GA4320@hjsoft.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-2006 13:00, John M Flinchbaugh wrote:
> I see this OOPS on boot with 2.6.18.1/amd64:

You mean this INFO?

> [  113.147347] =================================
> [  113.147561] [ INFO: inconsistent lock state ]
> [  113.147668] ---------------------------------
> [  113.147775] inconsistent {in-hardirq-W} -> {hardirq-on-W} usage.
> [  113.147883] dhclient3/1787 [HC0[0]:SC0[1]:HE1:SE0] takes:
> [  113.147991]  (&ei_local->page_lock){+...}, at: [<ffffffff88080fbb>] ei_start_xmit+0x95/0x24e [8390]
> [  113.148274] {in-hardirq-W} state was registered at:
> [  113.148382]   [<ffffffff802443d5>] lock_acquire+0x7a/0xa1
> [  113.148556]   [<ffffffff80438c09>] _spin_lock+0x2e/0x3c
> [  113.148730]   [<ffffffff880808e0>] ei_interrupt+0x44/0x2fb [8390]

It looks there is a patch for this in 2.6.19-rc (8390.c). 

Jarek P.
