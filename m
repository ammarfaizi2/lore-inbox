Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWCVAKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWCVAKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWCVAKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:10:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751852AbWCVAKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:10:51 -0500
Date: Tue, 21 Mar 2006 16:13:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, clemens@ladisch.de
Subject: Re: [PATCH] hpet header sanitization
Message-Id: <20060321161303.53c2895f.akpm@osdl.org>
In-Reply-To: <20060321144607.153d1943.rdunlap@xenotime.net>
References: <20060321144607.153d1943.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Add __KERNEL__ block.
> Use __KERNEL__ to allow ioctl interface to be usable.

hm, why?

My general approach to __KERNEL__ fixes is to not support new includers of
kernel headers but to accept patches which fix up existing applications of
__KERNEL__.

It's basically a compromise between the
dont-include-kernel-headers-from-userspace fundamentalists and the
but-i-want-my-stuff-to-work pragmatists ;)

But hpet.h never had __KERNEL__, so there's no regression here.

That being said, it looks like a sensible change - let's see if we can
sneak it in without the fundies noticing.

oops.

