Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbTIHQR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTIHQR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:17:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:35471 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263063AbTIHQR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:17:58 -0400
Date: Mon, 8 Sep 2003 17:17:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nasm over gas?
Message-ID: <20030908161729.GB26829@mail.jlokier.co.uk>
References: <rZQN.83u.21@gated-at.bofh.it> <saVL.7lR.1@gated-at.bofh.it> <soFo.16a.1@gated-at.bofh.it> <ssJa.6M6.25@gated-at.bofh.it> <tcVB.rs.3@gated-at.bofh.it> <3F5C7009.4030004@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5C7009.4030004@softhome.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:
>   It will depend on arch CPU only in case if you have unlimited i$ size.
>   Servers with 8MB of cache - yes it is faster.
>   Celeron with 128k of cache - +4bytes == higher probability of i$ miss 
> == lower performance.

Higher probability != optimal performance.

It depends on your execution context.  If it's part of a tight loop
which is executed often, then saving a cycle in the loop gains more
performance than saving icache, even on a 128k Celeron.

The execution context can depend on the input to the program, in which
case the faster of the two code sequences can depend on the program's
input too.  Then, for optimal performance, you need to profile the
"expected" inputs.

> P.S. Add having good macroprocessor for assembler is a must: CPP is 
> terribly stupid by design. I beleive gas has no preprocessor comparable 
> to masm's one? I bet they are using C's cpp.

You obviously have not read the GAS documentation.

It has quite a good macro facility built in.

-- Jamie
