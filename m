Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281762AbSAAPQi>; Tue, 1 Jan 2002 10:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbSAAPQ0>; Tue, 1 Jan 2002 10:16:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51716 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281458AbSAAPQM>; Tue, 1 Jan 2002 10:16:12 -0500
Subject: Re: [patch] Prefetching file_read_actor()
To: davej@suse.de (Dave Jones)
Date: Tue, 1 Jan 2002 15:26:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        manfred@colorfullife.com (Manfred Spraul),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0201011342350.23436-100000@Appserv.suse.de> from "Dave Jones" at Jan 01, 2002 01:45:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LQns-0000ZC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've come up with a preload_cache() function (for want of a better name)
> and plonked that in prefetch.h for now. Having this #define to nothing
> on other arch's would mean we could use this in places like we currently
> do prefetch().  I'm still not happy with it, but its cleaner than my
> original hack.

copy_*_user_prefetched() is probably the one you need. Then you can prefetch
first for PIII, prefetch as copying for athlon etc. It will also provide
the needed hints about which copies are wins. 
