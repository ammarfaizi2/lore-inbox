Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVBHWQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVBHWQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVBHWQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:16:55 -0500
Received: from mx1.elte.hu ([157.181.1.137]:991 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261589AbVBHWPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:15:22 -0500
Date: Tue, 8 Feb 2005 23:08:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: the "Turing Attack" (was: Sabotaged PaXtest)
Message-ID: <20050208220851.GA23687@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost> <20050208164815.GA9903@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208164815.GA9903@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

>  http://pax.grsecurity.net/docs/pax-future.txt
> 
>    To understand the future direction of PaX, let's summarize what we 
>    achieve currently. The goal is to prevent/detect exploiting of
>    software bugs that allow arbitrary read/write access to the attacked
>    process. Exploiting such bugs gives the attacker three different
>    levels of access into the life of the attacked process:
> 
>    (1) introduce/execute arbitrary code
>    (2) execute existing code out of original program order
>    (3) execute existing code in original program order with arbitrary 
>        data
> 
>    Non-executable pages (NOEXEC) and mmap/mprotect restrictions 
>    (MPROTECT) prevent (1) with one exception: if the attacker is able to
>    create/write to a file on the target system then mmap() it into the
>    attacked process then he will have effectively introduced and
>    executed arbitrary code.
>    [...]
> 
> the blanket statement in this last paragraph is simply wrong, as it
> omits to mention a number of other ways in which "code" can be
> injected.

i'd like to correct this sentence of mine because it's unfair: your
categories are consistent if you define 'code' as 'machine code', and
it's clear from your documents that you mean 'machine code' under code.

(My other criticism remains.)

	Ingo
