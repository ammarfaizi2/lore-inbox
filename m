Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWJKQDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWJKQDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbWJKQDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:03:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:47297 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161094AbWJKQDU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:03:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 0/21]: powerpc/cell spidernet bugfixes, etc.
Date: Wed, 11 Oct 2006 18:02:42 +0200
User-Agent: KMail/1.9.4
Cc: akpm@osdl.org, jeff@garzik.org, James K Lewis <jklewis@us.ibm.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
References: <20061010204946.GW4381@austin.ibm.com>
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610111802.43996.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 22:49, Linas Vepstas wrote:
> Andrew, please apply/forward upstream.
> 
> The following set of 21 patches (!) are all aimed at the the 
> spidernet ethernet device driver. The spidernet is an etherenet
> controller built into the Toshiba southbridge for the PowerPC Cell
> processor. (This is the only device in existance that with this
> ethernet hardware in it).
> 
> These patches re-package/re-order/re-cleanup a previous
> set of patches I've previously mailed. Thus, some have
> been previously Acked-by lines, most do not. Most of
> these patches are tiny, and handle problems that cropped
> up during testing. Sorry about there being so many of them.
> 
> The first set of 12 patches fix a large variety of mostly 
> minor bugs. 
> 
> The important patches are 13 through 17: these overcome a 
> debilitating performance problem on transmit (6 megabits
> per second !!) on transmit of patches 500 bytes or larger.
> After applying these, I am able to get the following:
> 
> pkt sz   speed (100K buffs)       speed (4M buffs)
> ------   -----------------        ----------------
> 1500     700 Mbits/sec            951 Mbits/sec
> 1000     658 Mbits/sec            770
> 800      600                      648
> 500      500                      500
> 300      372                      372
> 60        70                       70
> 
> Above buf size refers to /proc/sys/net/core/wmem_default

Excellent work! I guess this the best tx performance we've
seen so far on this hardware.

Consider this as an Acked-by: for all the patches, I'll save
the effort of replying to each one of them separately.

Jeff, do you plan on merging these fixes for 2.6.19?

	Arnd <><
