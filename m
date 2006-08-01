Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWHAWBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWHAWBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWHAWBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:01:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58505 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751189AbWHAWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:01:22 -0400
Subject: Re: use persistent allocation for cursor blinking.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland Dreier <rdreier@cisco.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <adairlc5ktk.fsf@cisco.com>
References: <20060801185618.GS22240@redhat.com>  <adairlc5ktk.fsf@cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 23:20:13 +0100
Message-Id: <1154470813.15540.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 12:15 -0700, ysgrifennodd Roland Dreier:
>  > Every time the console cursor blinks, we do a kmalloc/kfree pair.
>  > This patch turns that into a single allocation.
> 
> A naiive question from someone who knows nothing about this subsystem:
> is there any possibility of concurrent calls into this function, for
> example if there are multiple cursors on a multiheaded system?

We don't do console multihead so its basically OK. Moving all the
console globals into a struct so we can have multiple instances would be
a good thing [tm] and it would make sense for the variable to end up in
said structure if it was done.

Definitely a janitor job there.

Alan

