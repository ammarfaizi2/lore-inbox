Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWHPXDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWHPXDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWHPXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:03:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:61660 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932323AbWHPXDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:03:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
Date: Thu, 17 Aug 2006 01:03:20 +0200
User-Agent: KMail/1.9.1
Cc: Linas Vepstas <linas@austin.ibm.com>, akpm@osdl.org, jeff@garzik.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com,
       David Miller <davem@davemloft.net>
References: <44E34825.2020105@garzik.org> <200608162324.47235.arnd@arndb.de> <20060816225558.GM20551@austin.ibm.com>
In-Reply-To: <20060816225558.GM20551@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608170103.21097.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday 17 August 2006 00:55 schrieb Linas Vepstas:
> > it only
> > seems to be hard to make it go fast using any of them.
>
> Last round of measurements seemed linear for packet sizes between
> 60 and 600 bytes, suggesting that the hardware can handle a
> maximum of 120K descriptors/second, independent of packet size.
> I don't know why this is.

Could well be related to latencies when going to the remote
node for descriptor DMAs. Have you tried if the hch's NUMA
patch or using numactl makes a difference here?

> > sounds like the right approach to simplify the code.
>
> Its not a big a driver. 'wc' says its 2.3 loc, which
> is 1/3 or 1/5 the size of tg3.c or the e1000*c files.

Right, I was thinking of removing a lock or another, not
throwing out half of the driver ;-)

	Arnd <><
