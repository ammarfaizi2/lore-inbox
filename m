Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267348AbUBSV0e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267256AbUBSV0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:26:34 -0500
Received: from ns.suse.de ([195.135.220.2]:4510 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267348AbUBSV0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:26:13 -0500
Date: Fri, 20 Feb 2004 21:12:50 +0100
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: tony@atomide.com, linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-Id: <20040220211250.5142f78d.ak@suse.de>
In-Reply-To: <9AB83E4717F13F419BD880F5254709E5011EB8BE@scsmsx402.sc.intel.com>
References: <9AB83E4717F13F419BD880F5254709E5011EB8BE@scsmsx402.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 13:14:27 -0800
"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:

> > 
> > Which change exactly is supposed to fix it? And why? 
> > 
> > For me the UP kernel boots just fine.
> > 
> > -Andi
> 
> GDT changes that I sent, fixes the boot problem. Its broken with CONFIG_X86_L1_CACHE_BYTES=64.

Ah, ok, that explains it. I only tested with the GENERIC kernel which had a 128 byte cache line.

I think I will just always pad to 128 bytes instead of applying the patch though.

-Andi

