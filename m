Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUBHXDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUBHXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:03:21 -0500
Received: from dp.samba.org ([66.70.73.150]:23972 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264278AbUBHXDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:03:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx, davem@redhat.com
Subject: Re: When should we use likely() / unlikely() / get_unaligned() ? 
In-reply-to: Your message of "Sun, 08 Feb 2004 11:13:53 -0000."
             <1076238833.12587.229.camel@imladris.demon.co.uk> 
Date: Mon, 09 Feb 2004 10:00:47 +1100
Message-Id: <20040208230331.79FEB2C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1076238833.12587.229.camel@imladris.demon.co.uk> you write:
> To be honest, I'm more interested in the case of get_unaligned(). The
> principle is fairly similar -- the ratio between the performance of the
> inline and the exception cases varies wildly from architecture to
> architecture. But the range is far wider -- we now support architectures
> in 2.6 where alignment fixups _cannot_ happen, and the cost of the
> 'exception' case should be considered infinite.

Um, we do?  I thought it was compulsory in the kernel, otherwise
networking breaks on packets w/ wierd hardware headers.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
