Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSKTP2Y>; Wed, 20 Nov 2002 10:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSKTP2Y>; Wed, 20 Nov 2002 10:28:24 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:4233 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261305AbSKTP2X>; Wed, 20 Nov 2002 10:28:23 -0500
Date: Wed, 20 Nov 2002 13:04:42 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: the random driver
Message-ID: <20021120130442.M628@nightmaster.csn.tu-chemnitz.de>
References: <3DDB3DED.A4C9DC56@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3DDB3DED.A4C9DC56@digeo.com>; from akpm@digeo.com on Tue, Nov 19, 2002 at 11:46:53PM -0800
X-Spam-Score: -3.0 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18EWsx-0003Fv-00*LmNqboVIYkc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Nov 19, 2002 at 11:46:53PM -0800, Andrew Morton wrote:
> c) The ring-buffer handling is awkward.  It shouldn't be masking
>    the head and tail pointers to always remain within bounds.
> 
>    A better technique is to allow these indices to wrap at
>    0xffffffff and only mask their values when you actually use
>    them as a subscript.  This allows you to distinguish the
>    completely-full case from the completely-empty one.  See
>    LOG_BUF* in kernel/printk.c.

Care to implement a generic ringbuffer in a header file, to avoid
this kind of errors? I'm sure there are more (and even overflows
on some implementations).

The gory implementation details of basic computer science
algorithms seem to cause problems for many driver writers.

So the trend of abstracting these away in the kernel, if it costs
no time and doesn't lead to ugly code, is right.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
