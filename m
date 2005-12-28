Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVL1SWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVL1SWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVL1SWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:22:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:3037 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964864AbVL1SWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:22:39 -0500
Message-ID: <6232114.1135794150848.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 28 Dec 2005 19:22:30 +0100 (CET)
From: Andreas Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [RFC] [PATCH] Add memcpy32 function
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1135793503.1527.125.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-304-smp i386 (JVM 1.3.1_16)
Organization: SuSE Linux AG
References: <1135301759.4212.76.camel@serpentine.pathscale.com> <p73fyodmqn6.fsf@verdi.suse.de> <1135782025.1527.104.camel@serpentine.pathscale.com> <1880308.1135792235045.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <1135793503.1527.125.camel@serpentine.pathscale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi 28.12.2005 19:11 schrieb Bryan O'Sullivan <bos@pathscale.com>:

> On Wed, 2005-12-28 at 18:50 +0100, Andreas Kleen wrote:
>
> > Ok thanks. And do you have numbers that show that the assembly
> > function with rep ; movsl actually improves performance over C?
>
> I'll see if I can ferret some numbers out. If not, I'll generate them,
> but it will take me a day or so. I'm pretty sure it makes a difference
> of tens to hundreds of nanoseconds, which in our case is very
> significant (we measure some of our user-level performance in
> increments
> of 10ns, very repeatably).

If you test the C version use

CFLAGS_memcpy32.o := -funroll-loops

BTW on x86-64 with CONFIG_UNORDERED_IO writel can actually expand to a
non temporal write which might break it.

-Andi


