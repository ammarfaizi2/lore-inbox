Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbTIKSSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbTIKSSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:18:11 -0400
Received: from ns.suse.de ([195.135.220.2]:59286 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261391AbTIKSSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:18:09 -0400
Date: Thu, 11 Sep 2003 20:18:06 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911201806.2b2d9c5b.ak@suse.de>
In-Reply-To: <20030911174839.GM29532@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
	<20030911165845.GE29532@mail.jlokier.co.uk>
	<20030911190516.64128fe9.ak@suse.de>
	<20030911173245.GJ29532@mail.jlokier.co.uk>
	<20030911193954.63724a82.ak@suse.de>
	<20030911174839.GM29532@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 18:48:39 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> Andi Kleen wrote:
> > signal exception path is thousands of cycles, we're talking about tens
> > of cycles here.
> 
> <hand-waving>
> 
> Tens vs thousands == percentage points.

It is more thousands than tens :-)

[just the page fault alone is quite costly]

> 
> Isn't it about 20 cycles per mispredicted branch on a P4?
> 
> Five of those and we're talking several percent slowdown, ridiculous
> as it seems.

There are a lot of conditional branches in the signal
path. If you don't believe me I can send you simics full instruction traces of it.
I'm not going to believe that 2-3 more make a significant difference.

-Andi
