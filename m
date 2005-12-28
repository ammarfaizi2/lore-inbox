Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVL1SLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVL1SLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVL1SLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:11:49 -0500
Received: from mx.pathscale.com ([64.160.42.68]:5057 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964862AbVL1SLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:11:48 -0500
Subject: Re: [RFC] [PATCH] Add memcpy32 function
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andreas Kleen <ak@suse.de>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1880308.1135792235045.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
References: <1135301759.4212.76.camel@serpentine.pathscale.com>
	 <p73fyodmqn6.fsf@verdi.suse.de>
	 <1135782025.1527.104.camel@serpentine.pathscale.com>
	 <1880308.1135792235045.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 28 Dec 2005 10:11:43 -0800
Message-Id: <1135793503.1527.125.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 18:50 +0100, Andreas Kleen wrote:

> Ok thanks. And do you have numbers that show that the assembly
> function with rep ; movsl actually  improves performance over C?

I'll see if I can ferret some numbers out.  If not, I'll generate them,
but it will take me a day or so.  I'm pretty sure it makes a difference
of tens to hundreds of nanoseconds, which in our case is very
significant (we measure some of our user-level performance in increments
of 10ns, very repeatably).

> If the assembly is not really faster I would recommend you just use a
> writel()
> loop in the driver instead of adding this very special purpose function
> everywhere.

Yeah, clearly if there's no difference, it's not worth the trouble.

	<b

