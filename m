Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSIIMND>; Mon, 9 Sep 2002 08:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSIIMND>; Mon, 9 Sep 2002 08:13:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40202 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317182AbSIIMND>;
	Mon, 9 Sep 2002 08:13:03 -0400
Date: Mon, 9 Sep 2002 13:17:44 +0100
From: Matthew Wilcox <willy@debian.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix.
Message-ID: <20020909131744.G10583@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Yeah, but you can still leave a spinlock uninitialized, and it'll
> work.

If your architecture has load-and-zero as its only atomic primitive,
leaving spinlocks uninitialised will _not_ work ;-)

-- 
Revolutions do not require corporate support.
