Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUFCXSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUFCXSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUFCXSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:18:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:23961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264655AbUFCXSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:18:10 -0400
Date: Thu, 3 Jun 2004 16:20:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [APIC] Avoid change apic_id failure panic
Message-Id: <20040603162045.7a335350.akpm@osdl.org>
In-Reply-To: <20040603101313.GB6578@gondor.apana.org.au>
References: <20040603101313.GB6578@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> I've received two reports at http://bugs.debian.org/251207 where
> ioapic caused machines to lock up during booting due to the
> change apic_id panic in arch/i386/kernel/io_apic.c.
> 
> Since it appears that we can avoid panicking at all, I think we
> should replace the panic calls with the following patch which
> attempts to continue after the failure.
> 
> I've also done the same thing to the other panic() call in the
> same function.

Well.  Question is, why are we getting insame APIC ID's in there in the
first place?

