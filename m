Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbTIKE6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbTIKE6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:58:49 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:51873 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S266091AbTIKE6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:58:47 -0400
Message-ID: <0a5801c37821$54eb8180$890010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>, "Andi Kleen" <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>
References: <uqD5.3BI.3@gated-at.bofh.it> <m3iso0arlx.fsf@averell.firstfloor.org>
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Thu, 11 Sep 2003 06:58:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@muc.de>
>
> Of course they may want to also fix it in a different way to run on older
> kernels (e.g. handling the signal in user space or avoiding the
conditions).
> But doing it centrally in the kernel is a bit cleaner and at some point
> people have to update their kernels anyways.

Could you be kind enough to post here the example code for a SIGSEGV handler
that would be necessary for old kernels ?

I do think it woul help some people like me, for the future googling on the
prefetch errata.

I do use preftechnta instructions on my programs, and this errata could
explain some strange crashes.

As the program crashing is a huge multi-threaded network application, with
up to 300000 opened TCP sockets, the SIGSEGV fault is usually followed by a
system crash (networks buffers using all of lowmem)

Thanks
Eric Dumazet

