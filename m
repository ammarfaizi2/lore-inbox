Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbTFSAup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbTFSAup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:50:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44797 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265659AbTFSAuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:50:40 -0400
Subject: Re: [RFC][PATCH] CONFIG_NR_CPUS for 2.4.21
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20030618230136.GG3768@werewolf.able.es>
References: <20030618222336.GC3768@werewolf.able.es>
	 <20030618230136.GG3768@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1055984673.8770.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 18 Jun 2003 18:04:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 16:01, J.A. Magallon wrote:

> Oops, credits for this should go to (and possible comments/reject come
> from) Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>

It looks fine to me, although I do not think this is as critical an
issue as it was for 2.5, because the per-processor bloat is not nearly
as bad in 2.4 as 2.5. Nonetheless, this does not actually break
anything.

Except, I notice in some places (namely, 64-bit architectures), you set
the default NR_CPUS value to 64. While this ought to work if
sizeof(unsigned long)==8, it might not and is probably not a change we
want in a stable series. The default should be 32 all around.

	Robert Love

