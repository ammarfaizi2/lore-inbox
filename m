Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUDSRzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUDSRzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:55:07 -0400
Received: from mail.ccur.com ([208.248.32.212]:22026 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261606AbUDSRzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:55:04 -0400
Date: Mon, 19 Apr 2004 13:55:03 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: siginfo & 32 bits compat, what is the story ?
Message-ID: <20040419175503.GA4383@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1082360155.1677.31.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082360155.1677.31.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 05:35:55PM +1000, Benjamin Herrenschmidt wrote:
> So I've been playing around the siginfo copy code for 32 bits
> processes on ppc64 and found some interesting stuffs that I don't
> know how to fix at this point.
> 
> I looked at x86-64, and they always copy/convert those 3 fields,
> never copy the rest of the siginfo. I looked at s390 and they do
> the opposite: just copy the rest of the structure...

I believe the x86_64 method is correct.

It might be worth moving this compatibility code to a
common place where all architectures could reference it.

Joe
