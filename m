Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbTGLQd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268047AbTGLQd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:33:27 -0400
Received: from ivimey.org ([194.106.52.201]:44133 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S268031AbTGLQdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:33:22 -0400
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Reply-To: Ruth.Ivimey-Cook@ivimey.org
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.75-bk update help texts for PDC202 (was [PATCH] Update COnfigure.help for PDC202 options)
Date: Sat, 12 Jul 2003 17:48:20 +0100
User-Agent: KMail/1.5.2
References: <Pine.SOL.4.30.0307121706520.19333-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0307121706520.19333-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307121748.20148.ruth@ivimey.org>
X-Spam-Score: -1.6 (-)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 Jul 2003 4:18 pm, Bartlomiej Zolnierkiewicz wrote:
> >  - integrate that patch with mine & resubmit
> Please do.

Ok. I will carry on. In my reply to the thread you pointed me to, I have 
proposed some other choices.

> > Does ataraid work well on 2.4? I have never used it as I have preferred
> > the user-space tools available for Linux-raid. On 2.5 KConfig as ataraid
> > doesn't
> I do not know. Hint: search lkml archive for bugreports :-).

The answer seems to be that people are happy with ataraid in 2.4, apart from 
Promise who would prefer it didn't exist :-)

> > work I guess the right thing is to always configure as non-raid, so not
> > requiring a user-question and therefore no help.
> Promise binary drivers can be used in 2.5.

Ahh.

> > I have updated my Configure.help patch in ways that I hope address your
> > concerns above. I can see from Steven Drake's patch that I should also
> > modify
>
> You don't. This patch looks (almost?) exactly as previous one.

It wasn't. This is what it looks like without 'diff' stuff around it. I have 
removed refs to Ultra33 in the new bit, and rewritten the main paras in both. 
However, as I said I did an alternative version in the other mail that you 
might prefer. However that didn't actually have as much information in it 
(e.g. stuff about using DMA by default, BIOS version problems):

PROMISE PDC20246/PDC20262/PDC20263/PDC20265/PDC20267 support
CONFIG_BLK_DEV_PDC202XX_OLD
  Promise Ultra 33 [PDC20246]
  Promise Ultra 66 [PDC20262]
  Promise FastTrak 66 [PDC20263]
  Promise MB Ultra 100 [PDC20265]
  Promise Ultra 100 [PDC20267]

  This driver adds support for the older series of Promise EIDE disk
  interface devices. Each device supports up to 4 disk drives that
  can use UDMA disk access (33MHz for Ultra 33 up to 100MHz for Ultra
  100).

  If multiple cards are installed you might have problems booting if
  the BIOS versions for the cards are different. Therefore the driver
  attempts to do dynamic tuning of the chipset at boot-time.

  If you are using an Ultra 33, BIOS version 1.25 or newer is required
  to support more than one card and you should say Y to "Special UDMA
  Feature" to force UDMA mode for connected UDMA capable disk drives.

  If you say Y here, you need to say Y to "Use DMA by default when
  available" as well.

  If unsure, say N.

PROMISE PDC202{68|69|70|71|75|76|77} support
CONFIG_BLK_DEV_PDC202XX_NEW
  Promise Ultra 100 TX2 [PDC20268]
  Promise Ultra 133 PTX2 [PDC20269]
  Promise FastTrak LP/TX2/TX4 [PDC20270]
  Promise FastTrak TX2000 [PDC20271]
  Promise MB Ultra 133 [PDC20275]
  Promise MB FastTrak 133 [PDC20276]
  Promise FastTrak 133 [PDC20277]

  This driver adds support for the older series of Promise EIDE disk
  interface devices. Each device supports up to 4 disk drives that
  can use UDMA disk access (100MHz for Ultra 100 up to 133MHz for
  Ultra 133).

  If multiple cards are installed you might have problems booting if
  the BIOS versions for the cards are different. Therefore the driver
  attempts to do dynamic tuning of the chipset at boot-time.

  If you say Y here, you need to say Y to "Use DMA by default when
  available" as well.

  If unsure, say N.




-- 
Engineer, Author and Webweaver

