Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbQLLDKd>; Mon, 11 Dec 2000 22:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130499AbQLLDKX>; Mon, 11 Dec 2000 22:10:23 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:24071 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130468AbQLLDKP>;
	Mon, 11 Dec 2000 22:10:15 -0500
To: davej@suse.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mj@suse.cz
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.21.0012091122460.3465-100000@neo.local>
From: Jes Sorensen <jes@linuxcare.com>
Date: 12 Dec 2000 03:39:41 +0100
In-Reply-To: davej@suse.de's message of "Sat, 9 Dec 2000 11:30:44 +0000 (GMT)"
Message-ID: <d366kqmkgi.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == davej  <davej@suse.de> writes:

Dave> Hi, I noticed a lot of drivers are setting the
Dave> PCI_CACHE_LINE_SIZE themselves, some to
Dave> L1_CACHE_BYTES/sizeof(u32), others to arbitrary values (4, 8,
Dave> 16).

Dave> Then I spotted that we have a routine in the PCI subsystem
Dave> (pdev_enable_device) that sets all these to
Dave> L1_CACHE_BYTES/sizeof(u32) Further digging revealed that this
Dave> routine was not getting called.

If it comes to that, it really should based upen SMP_CACHE_BYTES
rather than L1_CACHE_BYTES.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
