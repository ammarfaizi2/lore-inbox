Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSHBTCU>; Fri, 2 Aug 2002 15:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSHBTCU>; Fri, 2 Aug 2002 15:02:20 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58829 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316768AbSHBTCQ>; Fri, 2 Aug 2002 15:02:16 -0400
Date: Fri, 2 Aug 2002 21:05:24 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nick Orlov <nick.orlov@mail.ru>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
Message-ID: <Pine.SOL.4.30.0208022057130.9348-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just FYI,
>
> before these "#ifdef" fixes it was treated as OFF_BOARD unless
> CONFIG_PDC202XX_FORCE is set. (now it's inverted)

This should be fixed.

>
> And my point is that it does not matter how physically this controller
> installed - onboard or offboard. Idea is that we should have control

It is not on/offboard case. It is primary/secondary boot device case.

> which controller should be treated as "primary" (ide0/1) and which as
> "secondary" (ide2/3). I don't see/know how we can do it unless we mark
> one of controllers ON_BOARD and another OFF_BOARD and play with
> CONFIG_BLK_DEV_OFFBOARD.

Yes.

> And also I don't believe that this is good idea to treat one of Promises
> so differently.

Once again - on some machines it is primary IDE (booting one), so we have
to give user possibility for 'onboarding' it. However it should depend on
CONFIG_PDC202XX_FORCE... hmm... but on others it is offboard so distro
compiled kernels might have problem here :\.

Regards
--
Bartlomiej

