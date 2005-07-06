Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVGFVTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVGFVTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVGFVT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:19:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4525
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262539AbVGFU6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:58:22 -0400
Date: Wed, 06 Jul 2005 13:58:07 -0700 (PDT)
Message-Id: <20050706.135807.105431412.davem@davemloft.net>
To: davej@redhat.com
Cc: pmarques@grupopie.com, linux-kernel@vger.kernel.org
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050706205315.GC27630@redhat.com>
References: <42CBE97C.2060208@grupopie.com>
	<20050706.125719.08321870.davem@davemloft.net>
	<20050706205315.GC27630@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
Date: Wed, 6 Jul 2005 16:53:15 -0400

> On Wed, Jul 06, 2005 at 12:57:19PM -0700, David S. Miller wrote:
>  > It might be attributable to more cpu cache misses in userspace since
>  > the virtual addresses of everything are changing each and every
>  > invocation.
> 
> On Transmeta CPUs that probably triggers a retranslation of
> x86->native bytecode, if it thinks it hasn't seen code at that
> address before.

That sounds like a more likely cause than my theory.
