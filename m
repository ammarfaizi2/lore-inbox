Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVDEP1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVDEP1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVDEP1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:27:53 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:5481 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261783AbVDEPZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:25:29 -0400
X-ME-UUID: 20050405152522636.9B6E51C001E8@mwinf0603.wanadoo.fr
Date: Tue, 5 Apr 2005 17:21:59 +0200
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Sven Luther <sven.luther@wanadoo.fr>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405152159.GB25311@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1112689164.3086.100.camel@icampbell-debian>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 09:19:24AM +0100, Ian Campbell wrote:
> On Mon, 2005-04-04 at 23:19 +0200, Sven Luther wrote:
> 
> > I am only saying that the tg3.c and other file are under the GPL, and
> > that the firmware included in it is *NOT* intented to be under the
> > GPL, so why not say it explicitly ? 
> 
> I don't think anyone here has disagreed. What almost everyone has said
> however is "so go and do it" -- go do the research, contact the
> copyright holders directly and get the permission to make patches, then
> post them here.
> 
> There is really no point in discussing it here, just get on and do it.

Ok, for info, here is the email i just sent to the boradcom driver support :

---

Hello,

I am part of the Debian GNU/Linux kernel team, and recently stumbled about
some legal problems with the tg3.c driver for broadcom gigabit ethernet
controllers. The problem seems to be the same for the bcm570x drivers you
distribute from your web page, and after discussion with the debian-legal
team [1] and airing the issue with the larger linux kernel developers [2],
i now come to you for clarfication of this issue.

The broadcom 570x drivers are placed under the GPL, which is nice, and come
accompanied by sources, but include a few blobs of binary-only firmware to be
uploaded to the controller.

After discussion with debian-legal, we accept that the binary-only firmware
blob does not constitute a derivative work of the rest of the driver, but mere
agregation, so distributing it as binary only as you do is not a problem,
altough getting real sources for this part would be preferable.

Now, the problem is that both in the files included in the mainline kernel, as
well as the sources you distribute yourself, these firmware blobs come in a
file like fw_lso05.h, whose licence text says : 

/******************************************************************************/
/*                                                                            */
/* Broadcom BCM5700 Linux Network Driver, Copyright (c) 2000 - 2003 Broadcom  */
/* Corporation.                                                               */
/* All rights reserved.                                                       */
/*                                                                            */
/* This program is free software; you can redistribute it and/or modify       */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation, located in the file LICENSE.                 */
/*                                                                            */
/* (c) COPYRIGHT 2001-2004 Broadcom Corporation, ALL RIGHTS RESERVED.         */
/*                                                                            */
/*  Name: F W _ L S O 0 5. H                                                  */
/*  Author : Kevin Tran                                                       */
/*  Version: 1.2                                                              */
/*                                                                            */
/* Module Description:  This file contains firmware binary code of TCP        */
/* Segmentation firmware (BCM5705).                                           */
/*                                                                            */
/* History:                                                                   */
/*    08/10/02 Kevin Tran       Incarnation.                                  */
/*    02/02/04 Kevin Tran       Added Support for BCM5788.                    */
/******************************************************************************/

The above copyright statement clearly places the firmware blob under the GPL,
and makes the whole file undistributable without providing also the source
code, that is the prefered form of modification, of the firmware code in
question.

There are two solutions to this issue, either you abide by the GPL and provide
also the source code of those firmware binaries (the prefered solution :), or
you modify the copyright statement of these files, to indicate that even
thought the file per se is under the GPL, the firmware binary code is not, and
give us a licence to distribute it. Something akin to :

/******************************************************************************/
/*                                                                            */
/* Broadcom BCM5700 Linux Network Driver, Copyright (c) 2000 - 2003 Broadcom  */
/* Corporation.                                                               */
/* All rights reserved.                                                       */
/*                                                                            */
/* This program, except the firmware binary code,  is free software; you can  */
/* redistribute it and/or modify it under the terms of the GNU General Public */
/* License as published by the Free Software Foundation, located in the file  */
/* LICENSE.                                                                   */
/* Distribution, either as is or modified syntactically to adapt to the       */
/* layout of the surrounding GPLed code is allowed, provided this copyright   */
/* notice is acompanying it                                                   */
/*                                                                            */
/* (c) COPYRIGHT 2001-2004 Broadcom Corporation, ALL RIGHTS RESERVED.         */
/*                                                                            */
/*  Name: F W _ L S O 0 5. H                                                  */
/*  Author : Kevin Tran                                                       */
/*  Version: 1.2                                                              */
/*                                                                            */
/* Module Description:  This file contains firmware binary code of TCP        */
/* Segmentation firmware (BCM5705).                                           */
/*                                                                            */
/* History:                                                                   */
/*    08/10/02 Kevin Tran       Incarnation.                                  */
/*    02/02/04 Kevin Tran       Added Support for BCM5788.                    */
/******************************************************************************/

Or something else such acceptable to your legal department.

In hope of hearing from you soon, and that a quick resolution of this problem
can be achieved,

Friendly,

Sven Luther

[1] -- http://lists.debian.org/debian-legal/2005/03/msg00283.html
[2] -- http://lists.debian.org/debian-legal/2005/04/msg00047.html

