Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVA1HJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVA1HJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 02:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVA1HJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 02:09:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:29844 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261497AbVA1HIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 02:08:52 -0500
Date: Fri, 28 Jan 2005 08:08:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1-V0.7.34-01 ACPI err in dmesg
Message-ID: <20050128070840.GA1456@elte.hu>
References: <200501072156.54803.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501072156.54803.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 32752 pages, LIFO batch:7
> DMI 2.2 present.
> __iounmap: bad address c00f0000  <-why?
> ACPI: RSDP (v000 Nvidia                                ) @ 0x000f7220

I have no idea what is causing this. If it still occurs with recent
kernels then stick a WARN_ON(1) into __iounmap()'s error path, to get a
stack dump? It is almost certainly not related to -RT.

	Ingo
