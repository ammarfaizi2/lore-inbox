Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWAJWGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWAJWGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWAJWGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:06:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030225AbWAJWGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:06:24 -0500
Date: Tue, 10 Jan 2006 14:05:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: hch@infradead.org, rdreier@cisco.com, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
Message-Id: <20060110140557.41e85f7d.akpm@osdl.org>
In-Reply-To: <1136915714.6294.10.camel@serpentine.pathscale.com>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	<d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	<20060110011844.7a4a1f90.akpm@osdl.org>
	<adaslrw3zfu.fsf@cisco.com>
	<1136909276.32183.28.camel@serpentine.pathscale.com>
	<20060110170722.GA3187@infradead.org>
	<1136915386.6294.8.camel@serpentine.pathscale.com>
	<20060110175131.GA5235@infradead.org>
	<1136915714.6294.10.camel@serpentine.pathscale.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> OK, that header file will vanish.
>

It's kinda fun playing Brian along like this ;)

One option is to just stick the thing in an existing lib/ or kernel/ file
and mark it __attribute__((weak)).  That way architectures can override it
for free with no ifdefs, no Makefile trickery, no Kconfig trickery, etc.

attribute(weak) is creepily useful - I keep waiting for something to go
wrong with it.
