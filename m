Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTGKOTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTGKOSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:18:41 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:53978 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP id S261985AbTGKORt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:17:49 -0400
Message-ID: <3F0ECB2D.2080902@snapgear.com>
Date: Sat, 12 Jul 2003 00:35:25 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.75-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

An update of the uClinux (MMU-less) fixups against linux-2.5.75.
Mostly carried forward from 2.5.74. Not many new changes, just a
few small things.

Probably the main thing I would like feedback on is that I moved
the ptrinfo() function from mm/slab.c to mm/memory.c. I don't
think it makes any sense for this on non-MMU platforms. Comments?

You can get it at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.75-uc0.patch.gz

Changelog:

. port up to 2.5.75                          me
. move ptrinfo from slab.c to memory.c       me
. switch to asm-m68k/types.h for m68knommu   Bernardo Innocenti
. final div64 cleanups                       Bernardo Innocenti
. 68328serial fixups                         Georges Menie
. irqreturn_t fixups                         David McCullough
. mcfserial mcfrs_write cleanup              Daniele Bellucci

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
Snapgear Pty Ltd                            PHONE:       +61 7 3279 1822
825 Stanley St,                             FAX:         +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
























