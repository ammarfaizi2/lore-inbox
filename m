Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUGTF7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUGTF7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 01:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUGTF7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 01:59:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62436 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265668AbUGTF7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 01:59:39 -0400
Date: Tue, 20 Jul 2004 08:01:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] NX: clean up legacy binary support, 2.6.8-rc2
Message-ID: <20040720060104.GA27118@elte.hu>
References: <20040718084406.GA4766@elte.hu> <16636.17877.90080.590149@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16636.17877.90080.590149@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Mosberger <davidm@napali.hpl.hp.com> wrote:

> This looks better, but is still insufficient.  Remember: on some
> platforms, you'll want to support READ_IMPLIES_EXEC differently
> depending on personality (e.g, native binary vs. x86 binary).

> -#define LEGACY_BINARIES
> +#define elf_read_implies_exec_binary(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))

sure, looks good to me.

	Ingo
