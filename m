Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTGBCSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 22:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTGBCSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 22:18:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:56340 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264569AbTGBCR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 22:17:59 -0400
Date: Tue, 1 Jul 2003 19:32:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: Bernardo Innocenti <bernie@develer.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Message-Id: <20030701193250.1cbd4af9.akpm@digeo.com>
In-Reply-To: <200307020424.47629.bernie@develer.com>
References: <200307020232.20726.bernie@develer.com>
	<20030701173612.280d1296.akpm@digeo.com>
	<200307020424.47629.bernie@develer.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 02:32:23.0200 (UTC) FILETIME=[2B1F5A00:01C34042]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> wrote:
>
>  By the way, what do you think about getting rid of the do_div() macro
>  altogether?

I think we leave it the way it is because 64-bit divides are slow.

It is very easy to go accidentally adding 64-bit divides.  Say, by changing
the disk indexing to use 64-bit sector numbers as we did earlier in 2.5.

By requiring an explicit do_div we are made aware of all those 64-bit
divides and are made to think about them.

Why 64-bit divides in particular were victimised in this manner is a matter
for speculation ;)

