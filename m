Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264790AbUFCXlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264790AbUFCXlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUFCXlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:41:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:15273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264790AbUFCXlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:41:45 -0400
Date: Thu, 3 Jun 2004 16:44:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: herbert@gondor.apana.org.au, len.brown@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [APIC] Avoid change apic_id failure panic
Message-Id: <20040603164415.06a7098c.akpm@osdl.org>
In-Reply-To: <20040603233748.GN21007@holomorphy.com>
References: <20040603101313.GB6578@gondor.apana.org.au>
	<20040603162045.7a335350.akpm@osdl.org>
	<20040603233748.GN21007@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >> I've received two reports at http://bugs.debian.org/251207 where
> >> ioapic caused machines to lock up during booting due to the
> >> change apic_id panic in arch/i386/kernel/io_apic.c.
> >> Since it appears that we can avoid panicking at all, I think we
> >> should replace the panic calls with the following patch which
> >> attempts to continue after the failure.
> >> I've also done the same thing to the other panic() call in the
> >> same function.
> 
> On Thu, Jun 03, 2004 at 04:20:45PM -0700, Andrew Morton wrote:
> > Well.  Question is, why are we getting insame APIC ID's in there in the
> > first place?
> 
> They're usually not insane. xAPIC's have 8-bit physical ID's, not 4-bit,
> but no one's bothered tracking whether the APIC's found were serial APIC
> or xAPIC, and then dispatching on that in the IO-APIC physid check to
> avoid unnecessarily renumbering the things or panicking.

So... what should we do?
