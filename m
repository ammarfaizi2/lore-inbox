Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWF1MVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWF1MVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161289AbWF1MVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:21:04 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:21477 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161009AbWF1MVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:21:02 -0400
Date: Wed, 28 Jun 2006 14:15:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: special s390 print_symbol() version
Message-ID: <20060628121524.GA22131@elte.hu>
References: <20060628112435.GD9452@osiris.boeblingen.de.ibm.com> <20060628120635.GE9452@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628120635.GE9452@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> +static inline void print_symbol(const char *fmt, unsigned long addr)
> +{
> +	__check_printsym_format(fmt, "");
> +	__print_symbol(fmt, (unsigned long)
> +		       __builtin_extract_return_addr((void *)addr));
> +}

yeah, this looks better i think than the #ifdef variant.

	Ingo
