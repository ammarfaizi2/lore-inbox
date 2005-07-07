Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVGGBOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVGGBOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 21:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVGGBNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 21:13:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261799AbVGGBNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 21:13:09 -0400
Date: Wed, 6 Jul 2005 18:12:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: davem@davemloft.net, pmarques@grupopie.com, linux-kernel@vger.kernel.org
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
Message-Id: <20050706181220.3978d7f6.akpm@osdl.org>
In-Reply-To: <20050706205315.GC27630@redhat.com>
References: <42CBE97C.2060208@grupopie.com>
	<20050706.125719.08321870.davem@davemloft.net>
	<20050706205315.GC27630@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Wed, Jul 06, 2005 at 12:57:19PM -0700, David S. Miller wrote:
>  > From: Paulo Marques <pmarques@grupopie.com>
>  > Date: Wed, 06 Jul 2005 15:23:56 +0100
>  > 
>  > > What is weird is that most of the extra time is being accounted as 
>  > > user-space time, but the user-space application is exactly the same in 
>  > > both runs, only the "randomize_va_space" parameter changed.
>  > 
>  > It might be attributable to more cpu cache misses in userspace since
>  > the virtual addresses of everything are changing each and every
>  > invocation.
> 
> On Transmeta CPUs that probably triggers a retranslation of
> x86->native bytecode, if it thinks it hasn't seen code at that
> address before.
> 

ouch.   What do we do?  Default to off?  Default to off on xmeta?
