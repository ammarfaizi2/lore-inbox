Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVCDRAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVCDRAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVCDQ5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:57:23 -0500
Received: from ozlabs.org ([203.10.76.45]:3210 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262956AbVCDQyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:54:49 -0500
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, kai@germaschewski.name,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050302140019.GC4608@stusta.de>
References: <422550FC.9090906@gmail.com>
	 <20050302012331.746bf9cb.akpm@osdl.org>
	 <65258a58050302014546011988@mail.gmail.com>
	 <20050302032414.13604e41.akpm@osdl.org>  <20050302140019.GC4608@stusta.de>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 21:23:17 +1100
Message-Id: <1109931797.28203.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-02 at 15:00 +0100, Adrian Bunk wrote:
> Why doesn't an EXPORT_SYMBOL create a reference?

It does: EXPORT_SYMBOL(x) drops the address of "x", including
__attribute_used__, in the __ksymtab section.

However, if CONFIG_MODULES=n, it does nothing: perhaps that is what you
are seeing.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

