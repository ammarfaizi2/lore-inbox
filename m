Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131297AbRCHJJb>; Thu, 8 Mar 2001 04:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRCHJJW>; Thu, 8 Mar 2001 04:09:22 -0500
Received: from hmljs.rzs-hm.si ([193.2.208.10]:43275 "EHLO hmljs.rzs-hm.si")
	by vger.kernel.org with ESMTP id <S131296AbRCHJJL>;
	Thu, 8 Mar 2001 04:09:11 -0500
Date: Thu, 08 Mar 2001 10:08:32 +0100 (CET)
From: Metod Kozelj <metod.kozelj@rzs-hm.si>
Subject: Re: 2.4.3-pre2 aic7xxx crash on alpha
In-Reply-To: <200103080445.f284jsO36939@aslan.scsiguy.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org
Reply-to: Metod Kozelj <metod.kozelj@rzs-hm.si>
Message-id: <Pine.HPP.3.96.1010308095215.15847B-100000@hmljhp.rzs-hm.si>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 7 Mar 2001, Justin T. Gibbs wrote:

> >(scsi1:A:0:0): data overrun detected in Data-out phase.  Tag == 0x36.
> >(scsi1:A:0:0): Have seen Data Phase.  Length = 0.  NumSGs = 0.
> 
> As I mentioned to you the last time you brought up this problem, I
> don't believe that this is caused by the aic7xxx driver, but the
> aic7xxx driver may be the first to notice the corruption.

I can second this somehow. I was testing 2.4.2 on SX164 alpha, same
AHA-2940UW controller. In my case, system freezes solid if I do extensive
reading from CD-ROM (NEC CD-ROM DRIVE:465). It happens using stock AIC7xxx
driver (5.3.something) as well as the new (6.1.2 or something).
I'm back to 2.2.18 using AIC7xxx v5.1.31 and everything is happy.
This makes me believe that it must be mid-layer SCSI drivers causing
problems.

Peace!
  Mkx

---- perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'


