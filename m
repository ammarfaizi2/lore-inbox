Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUF3OY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUF3OY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUF3OY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:24:26 -0400
Received: from mail.shareable.org ([81.29.64.88]:13485 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266680AbUF3OYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:24:15 -0400
Date: Wed, 30 Jun 2004 15:23:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040630142351.GD29285@mail.shareable.org>
References: <20040630013824.GA24665@mail.shareable.org> <200406300910.16396.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406300910.16396.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> > This can only happen when something branches to a page with PROT_EXEC
> > _not_ set, on a kernel which honours that, and the target address is a
> > prefetch instruction.
> 
> Well. To be safe, just skip prefetch instruction, always.
> Hm. An attacker can supply us with whole gigabyte of
> prefetches back-to-back... Better skip all prefetches,
> with resheduling between every 1000 of them.

You could just skip one and return from the handler.
That's not a bad idea.

-- Jamie
