Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbULMLDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbULMLDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbULMLDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:03:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:51589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261182AbULMLDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:03:04 -0500
Date: Mon, 13 Dec 2004 03:02:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: andrea@suse.de, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-Id: <20041213030237.5b6f6178.akpm@osdl.org>
In-Reply-To: <41BCD5F3.80401@kolivas.org>
References: <20041211142317.GF16322@dualathlon.random>
	<20041212163547.GB6286@elf.ucw.cz>
	<20041212222312.GN16322@dualathlon.random>
	<41BCD5F3.80401@kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> The performance benefit, if any, is often lost in noise during 
>  benchmarks and when there, is less than 1%. So I was wondering if you 
>  had some specific advantage in mind for this patch? Is there some 
>  arch-specific advantage? I can certainly envision disadvantages to lower Hz.

There are apparently some laptops which exhibit appreciable latency between
the start of ACPI sleep and actually consuming less power.  The 1ms wakeup
frequency will shorten battery life on these machines significantly.  (I
forget the exact numbers - Len will know).

So I guess we're going to have to do this sometime - I don't think there's
any other solution apart from going fully tickless, which would be
considerably more intrusive.

We should retain the option of compile-time constant HZ - it's
easy enough.  Probably the patch already does that.
