Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSFKSC4>; Tue, 11 Jun 2002 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSFKSCz>; Tue, 11 Jun 2002 14:02:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4090 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317221AbSFKSCy>; Tue, 11 Jun 2002 14:02:54 -0400
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
From: Robert Love <rml@tech9.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <200206111428.g5BES0L15607@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jun 2002 11:01:40 -0700
Message-Id: <1023818500.21127.240.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 12:29, Denis Vlasenko wrote:

> I'm sorry it sounds like NTFS code needs rework, not Rusty's patch.
> Feel free to enlighten me why I am wrong.

Uh no.  We have both static (NR_CPUS) and dynamic (smp_num_cpus) code in
the kernel... both are legit for different purposes.

This patch takes Anton's code and swaps a kmalloc based on smp_num_cpus
to NR_CPUS.  I.e., on my 2-way machine I use 16x more memory.

	Robert Love

