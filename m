Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWFTOGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWFTOGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWFTOGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:06:43 -0400
Received: from vscan03.westnet.com.au ([203.10.1.142]:1696 "EHLO
	vscan03.westnet.com.au") by vger.kernel.org with ESMTP
	id S1750975AbWFTOGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:06:42 -0400
Message-ID: <449801C0.1000503@snapgear.com>
Date: Wed, 21 Jun 2006 00:10:08 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.6.17-uc0 (MMU-less updates)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) code against 2.6.17.
There is a couple of bug fixes, some new CPU support,
but mostly this is some new features and improvements.
Some do need some good solid testing before merging to
mainline. Pretty much everything in this patch set is
related to m68knommu arch.

http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.17-uc0.patch.gz

The biggest change is way the clock frequency and RAM setup
is now configured for m68knommu targets. Both are now free-form
configs, not just a small set of possible values from a menu.
This will break older configs, so you will need to update them
appropriately when using this patch set. Advantage is that
this new mechanism greatly cleans and simplifies the clock and
RAM setup handling.


Change log:

. new m68knommu defconfig                          Greg Ungerer
. configurable clock for ColdFire                  Greg Ungerer
. configurable RAM setup                           Greg Ungerer
. ColdFire timers use reg offsets                  Greg Ungerer
. ColdFire 5329 support                            Matt Waddel
. Cobra5329 support                                Thomas Brinker
. Avnet 5282 support                               Daniel Alomar
. remove get_cpuinfo from setup                    Philippe De Muyter
. clean out use of rom_length                      Greg Ungerer
. cleanups for new gcc versions                    Greg Ungerer
. remove use of -Wa,-S from compilation            Philippe De Muyter
. fix strace support                               Philippe De Muyter
. speed up syscalls                                Philippe De Muyter
. fec use different irq priority/level             Willson Callan
. fec stats and speed fixes                        Philippe De Muyter
. fix word aligned stack                           Andrea Tarani


Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a division of Secure Computing  PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com

