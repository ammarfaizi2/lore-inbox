Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSGGTlu>; Sun, 7 Jul 2002 15:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSGGTlt>; Sun, 7 Jul 2002 15:41:49 -0400
Received: from vvv.conterra.de ([212.124.44.162]:55054 "EHLO vvv.conterra.de")
	by vger.kernel.org with ESMTP id <S316532AbSGGTls>;
	Sun, 7 Jul 2002 15:41:48 -0400
Message-ID: <3D289A14.29B713C5@conterra.de>
Date: Sun, 07 Jul 2002 21:44:20 +0200
From: Dieter Stueken <stueken@conterra.de>
Organization: con terra GmbH
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [FREEZE] 2.4.19-pre10 + Promise ATA100 tx2 ver 2.20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:

> No matter which one of the
> installations is booted, the system will lock up if the VIA controller is in
> use at the same time as the PDC. However, system seems to be stable (short
> test priod though) if only the PDC controller is in use. (I left the old
> drives attached to the VIA controller unmounted.)
> 
> Does this problem sound similar to yours?

seems similar to my problem. If I connect large (75-120G) disks on
both PDC channels and run /sbin/badblocks in parallel (dd might do, too)
I get a kernel panic/freeze. I get it even with no disk on the onboard
controller. I can reproduce this on two different VIA boards with both,
a PDC20267 and a PDC20262, too. On a board with Ali chiset, however
no error occured during a short (5 minutes) test. On a board with an
Intel
chipset I got some "DMA timeout" after 3 hours, but may be this was
an unrelated problem.

Dieter.
