Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264066AbUECVok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUECVok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbUECVok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:44:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:50429 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264039AbUECVo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:44:26 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Booting off of IDE while using different libata drives on same southbridge
Date: Mon, 3 May 2004 23:44:58 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200403121826.21442.markus.kossmann@inka.de> <200403121902.44371.bzolnier@elka.pw.edu.pl> <4096B752.9050602@clanhk.org>
In-Reply-To: <4096B752.9050602@clanhk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405032344.58597.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 of May 2004 23:19, J. Ryan Earl wrote:
> I am having a similar problem to what Markus Kossmann wrote about, but
> with the VIA Southbridge (Asus K8V).  My situation is similar, but a
> little different.  I would like to boot off a PATA drive attached to the
> Southbridge, but use libata for a couple SATA drives attached to the
> same Southbridge.
>
> Is this still not possible?  I also tried hde/hdg=noprobe options, but
> they didn't help the situation.  It appears the only way to get the
> drives on sata_via is to boot off of them.  Am I correct in thinking
> this is the only way to go about this?

Did you actually tried it (booting off of them)?
[ I can't see how this can help. ]

Just don't compile-in generic IDE PCI driver which controls your SATA drives
(or don't load this module if you're using initrd).

> -ryan
>
> Bartlomiej Zolnierkiewicz wrote:
> >>Is there any chance to use sata_sil with that kernel configuration ?
> >>Or is recompiling with CONFIG_BLK_DEV_SIIMAGE=m or with siimage disabled
> >>the only option ?
> >
> >Yep.
> >
> >Regards,
> >Bartlomiej

