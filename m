Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWHUBLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWHUBLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 21:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWHUBLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 21:11:04 -0400
Received: from mother.openwall.net ([195.42.179.200]:53461 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751659AbWHUBLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 21:11:03 -0400
Date: Mon, 21 Aug 2006 05:07:00 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce CONFIG_BINFMT_ELF_AOUT
Message-ID: <20060821010700.GA22806@openwall.com>
References: <20060819232556.GA16617@openwall.com> <20060820001637.GC27115@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820001637.GC27115@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy,

On Sun, Aug 20, 2006 at 02:16:37AM +0200, Willy Tarreau wrote:
> Most people compiling 2.4 for
> servers right now most probably do not enable support for a.out already.

I'm afraid that most don't change the default, not being aware that this
is an unreasonable security risk.

>   - you split the defconfig changes from the rest and let them in a
>     state compatible with 2.4.33 features, which even implies setting
>     CONFIG_BINFMT_ELF_AOUT to 'y', even if this sounds gross to you.
>   - I merge the changes to support the new option

I can do that, but:

- it almost defeats the purpose of the patch since most people won't
know to change the defaults;
- Marcelo is of the opinion that it's "not 2.4 material at this point in
time".

Given the above, do you still want me to resubmit a reworked patch like
that?

>   - you just have to maintain the patch for the defconfig files in owl.

I submit these patches in hope that they will be useful for mainstream
kernels, not in an attempt to simplify maintenance of -ow patches.

Thanks,

Alexander
