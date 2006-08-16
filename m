Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWHPF1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWHPF1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 01:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWHPF1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 01:27:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:1967 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750889AbWHPF1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 01:27:33 -0400
X-Authenticated: #14349625
Subject: Re: And another Oops / BUG? (2.6.17.8 on VIA Epia CL6000)
From: Mike Galbraith <efault@gmx.de>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, Folkert van Heusden <folkert@vanheusden.com>
In-Reply-To: <44E29415.4040400@xs4all.nl>
References: <44E29415.4040400@xs4all.nl>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 07:35:39 +0000
Message-Id: <1155713739.6011.30.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 05:42 +0200, Udo van den Heuvel wrote:
> Hello,

Greetings,

> Again my CL6000 Oopsed.
> Again named was involved.
> Again I cannot locate the cause.
> The log is below as it was pushed through ksymoops, providing a map and
> vlinux file.
> 
> How can I proceed to find the cause?
> 
> Kidn regards,
> Udo

(these oopsen would be a heck of a lot easier to look at if the
timestamp junk was stripped off)

> Aug 16 04:05:35 epia kernel: BUG: unable to handle kernel paging request
> at virtual address 4e2aad0b
> Aug 16 04:05:35 epia kernel:  printing eip:
> Aug 16 04:05:35 epia kernel: 4e2aad0b

The oops doesn't help much.  Once again, eip is in lala land, not the
kernel.

Given that you're the only person posting this kind of explosion, I
would cast a very skeptical glance toward my hardware.  I'd suggest
reverting to a known good kernel first, to verify that you really don't
have a hardware problem cropping up.

After I did that, I'd enable stack check thingies under kernel hacking,
and if that didn't turn up anything, I'd try slab and page allocator
debugging options and hope to catch someone scribbling where they're not
supposed to.

	-Mike

