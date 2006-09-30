Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWI3KkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWI3KkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 06:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWI3KkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 06:40:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:49659 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750782AbWI3KkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 06:40:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Date: Sat, 30 Sep 2006 12:40:00 +0200
User-Agent: KMail/1.9.1
Cc: Linas Vepstas <linas@austin.ibm.com>, jeff@garzik.org, akpm@osdl.org,
       netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <20060929230552.GG6433@austin.ibm.com>
In-Reply-To: <20060929230552.GG6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609301240.03464.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Saturday 30 September 2006 01:05 schrieb Linas Vepstas:
> Although these patches have not been baking in
> any -mm tree, they have been tested and are
> generally available as a part of the Cell SDK 2.0
> overseen by Arnd Bergmann. (Arnd, if you want
> to lend a voice of authority here, or to correct
> me, please do so...)
>
> The following sequence of six patches implement a
> series of changes to the transmit side of the
> spidernet ethernet device driver, significantly
> improving performance for large packets.
>
> This series of patches is almost identical to
> those previously mailed on 18-20 August, with one
> critical change: NAPI polling is used instead of
> homegrown polling.
>
> Although these patches improve things, I am not
> satisfied with how this driver behaves, and so
> plan to do additional work next week.
>

I'm not sure if I have missed a patch in here, but I
don't see anything reintroducing the 'netif_stop_queue'
that is missing from the transmit path.

Do you have a extra patch for that?

	Arnd <><
