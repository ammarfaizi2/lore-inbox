Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTAFA0N>; Sun, 5 Jan 2003 19:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTAFA0M>; Sun, 5 Jan 2003 19:26:12 -0500
Received: from dp.samba.org ([66.70.73.150]:8675 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265567AbTAFA0M>;
	Sun, 5 Jan 2003 19:26:12 -0500
Date: Mon, 6 Jan 2003 11:29:36 +1100
From: Anton Blanchard <anton@samba.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       grundler@cup.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030106002936.GA8584@krispykreme>
References: <m17ke3m3gl.fsf@frodo.biederman.org> <Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com> <15877.26255.524564.576439@argo.ozlabs.ibm.com> <1040569382.1966.11.camel@zion> <20021222222106.B30070@localhost.park.msu.ru> <15878.22747.913279.67149@argo.ozlabs.ibm.com> <20030105153735.A8532@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030105153735.A8532@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hopefully this patch should solve most problems with probing the BARs.
> The changes are quite minimal as everything still is done in one pass.
> - Added another level of fixups (PCI_FIXUP_EARLY), called with only
>   device/vendor IDs and class code filled in, before sizing the BARs.
> - pci_read_bases won't probe the BAR if the respective resource has
>   non-zero flags.
> 
> This allows to implement numerous alternative probing methods for
> particular architecture/device/BAR. Some of possible variants:
> get information from firmware and don't touch the BAR at all;

This sounds useful on ppc64 where firmware does a good job of setting
up the BARs.

Anton
