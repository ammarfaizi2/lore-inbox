Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287786AbSAAKU1>; Tue, 1 Jan 2002 05:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287792AbSAAKUP>; Tue, 1 Jan 2002 05:20:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3603 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287791AbSAAKUJ>; Tue, 1 Jan 2002 05:20:09 -0500
Subject: Re: [patch] Prefetching file_read_actor()
To: akpm@zip.com.au (Andrew Morton)
Date: Tue, 1 Jan 2002 10:30:18 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3C30BC5F.227349E8@zip.com.au> from "Andrew Morton" at Dec 31, 2001 11:28:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LMBW-0008Dk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like you'll need to do a __get_user() against the page to
> populate the tlb.  We're going to need it in the copy_to_user()
> anyway, so the cost is negligible.

Please bury such things in arch/cpu specific routines. Most non intel
processor hardware isnt that broken.
