Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUBEC7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUBEC7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:59:44 -0500
Received: from ns.suse.de ([195.135.220.2]:149 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266445AbUBEC7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:59:39 -0500
To: Yaroslav Klyukin <skintwin@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aacraid, opteron, over 1G memory....
References: <40217690.5070107@mail.ru.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Feb 2004 03:59:38 +0100
In-Reply-To: <40217690.5070107@mail.ru.suse.lists.linux.kernel>
Message-ID: <p73r7xakz8l.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaroslav Klyukin <skintwin@mail.ru> writes:

> aacraid does not seem to initialize if there is above 1-2 gigs of memory.
> If I boot with mem=1000M , it works.
> I tried to change the comminit.c file in the aacraid directory and
> played with the memory values, but it looks like it does not make a
> difference.
> I am using 2.6.2 kernel.

I assume you're using a 64bit compiled kernel.

Are you sure you have CONFIG_GART_IOMMU enabled ?  Without this it won't
work because aacraid doesn't support 64bit IO.

-Andi
