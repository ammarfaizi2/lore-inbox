Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTI2NKn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263318AbTI2NKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:10:43 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:33033 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263314AbTI2NKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:10:42 -0400
Subject: Re: [2.6.0-test4,5,6] [APM] when do you expect to get APM working
	again?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: schierlm@gmx.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <S263203AbTI2MAQ/20030929120016Z+1564@vger.kernel.org>
References: <S263203AbTI2MAQ/20030929120016Z+1564@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1064841037.3970.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Sep 2003 15:10:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 13:59, Michael Schierl wrote:
> Hi,
> 
> i'm using an Acer Travelmate 210 TEV notebook. (Celeron 700).
> 
> I don't use any acpi, swsuspend, suspend-to-disk, only apm. (ACPI did
> not work in test3, and since then I did not change anything on my
> config, always did just 'make oldconfig'.
> 
> with kernels test1 to test3 i could say 'apm -s' to go to standby mode
> and the computer woke up properly afterwards (with 2.4.20 kernel it
> went down "properly" but crashed when it should wake up again).

It's working fine for me, but I still need to unload some modules before
trying to suspend. In my case, I must remove the CardBus/PCMCIA modules,
the sound drivers and UHCI-HCD for my system to suspend and then resume
properly.

I have created a shell script which, when used with the "apmd" daemon,
makes things work automagically. Thus, simply by closing the lid, the
system suspends automatically.

