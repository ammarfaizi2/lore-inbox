Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273787AbRJIJGX>; Tue, 9 Oct 2001 05:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273495AbRJIJGN>; Tue, 9 Oct 2001 05:06:13 -0400
Received: from frank.gwc.org.uk ([212.240.16.7]:7942 "EHLO frank.gwc.org.uk")
	by vger.kernel.org with ESMTP id <S273305AbRJIJGB>;
	Tue, 9 Oct 2001 05:06:01 -0400
Date: Tue, 9 Oct 2001 10:06:24 +0100 (BST)
From: Alistair Riddell <ali@gwc.org.uk>
To: David Chow <davidchow@rcn.com.hk>
cc: raid@ddx.a2000.nu, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: write/read cache raid5
In-Reply-To: <3BC26BDE.45D893A6@rcn.com.hk>
Message-ID: <Pine.LNX.4.21.0110091004450.27693-100000@frank.gwc.org.uk>
X-foo: bar
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, David Chow wrote:

> Yes my server serve lots of clients and have lots of NICs even
> gigabit... how can I increase write/read cache on RAID5 ? It is better
> performed when big cache allows on top (before) raid computation work
> and physical disk writes.

In that case more memory will certainly help. You might like to check out
Jens Axboe's block-highmem patch if you have more than 1GB of RAM. It
allows hardware to DMA direct to high memory, rather than using bounce
buffers, which can increase performance considerably.

-- 
Alistair Riddell - BOFH
IT Manager, George Watson's College, Edinburgh
Tel: +44 131 447 7931 Ext 176       Fax: +44 131 452 8594
Microsoft - because god hates us

