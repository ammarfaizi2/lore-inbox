Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWH0IEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWH0IEo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWH0IEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:04:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3553 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751283AbWH0IEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:04:34 -0400
Date: Sun, 27 Aug 2006 01:04:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 und LZO compression
Message-Id: <20060827010428.5c9d943b.akpm@osdl.org>
In-Reply-To: <20060827003426.GB5204@martell.zuzino.mipt.ru>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 04:34:26 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> The patch below is so-called reiser4 LZO compression plugin as extracted
> from 2.6.18-rc4-mm3.
> 
> I think it is an unauditable piece of shit and thus should not enter
> mainline.

Like lib/inflate.c (and this new code should arguably be in lib/).

The problem is that if we clean this up, we've diverged very much from the
upstream implementation.  So taking in fixes and features from upstream
becomes harder and more error-prone.

I'd suspect that the maturity of these utilities is such that we could
afford to turn them into kernel code in the expectation that any future
changes will be small.  But it's not a completely simple call.

(iirc the inflate code had a buffer overrun a while back, which was found
and fixed in the upstream version).


