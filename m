Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUIXASQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUIXASQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUIXAQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:16:35 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:23546 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S267601AbUIXAJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:09:20 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: tabris <tabris@tabris.net>
Subject: Re: undecoded slave?
Date: Fri, 24 Sep 2004 02:09:13 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200409222357.39492.tabris@tabris.net> <200409231314.55547.bzolnier@elka.pw.edu.pl> <200409231630.49153.tabris@tabris.net>
In-Reply-To: <200409231630.49153.tabris@tabris.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409240209.13884.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 22:30, tabris wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Thursday 23 September 2004 7:14 am, Bartlomiej Zolnierkiewicz wrote:
> > [ use linux-ide@vger.kernel.org for ATA stuff ]
> >
> > On Thursday 23 September 2004 05:57, tabris wrote:
> > > Probing IDE interface ide3...
> > > hdg: Maxtor 4D060H3, ATA DISK drive
> > > hdh: Maxtor 4D060H3, ATA DISK drive
> > > ide-probe: ignoring undecoded slave
> > >
> > > Booted 2.6.9-rc2-mm2, and I no longer have an hdh. the error above
> > > seems to be the only [stated] reason why.
> >
> > Please send hdparm -I output for both drives.
> 
> As you can see, both drives are the same brand/size/model.
> Both are connected to the PDC20265 on my ASUS A7V266-E motherboard.
> 
> /dev/hdg:
> 
> ATA device, with non-removable media
>         Model Number:       Maxtor 4D060H3
>         Serial Number:      D3000000
>         Firmware Revision:  DAK019K0

Thanks.
It seems we will need to add this Serial Number to "undecoded slave" fixup.

Please also send /proc/ide/hd?/identify to exclude kernel/hdparm parsing bug.
