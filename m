Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUBIM4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUBIM4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:56:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12237 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265127AbUBIM4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:56:10 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Tomt <andre@tomt.net>
Subject: Re: Linux 2.6.3-rc1
Date: Mon, 9 Feb 2004 14:01:29 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <200402090234.20832.bzolnier@elka.pw.edu.pl> <4026F312.60703@tomt.net>
In-Reply-To: <4026F312.60703@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402091401.29398.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 of February 2004 03:40, Andre Tomt wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Ok thanks, I got the same dump.  I think the problem is that memory used
> > by previously registered ide_pci_host_proc_list entry (for pdc202xx_new
> > driver) is already unmapped because of __initdata in pdc202xx_new.h.
> > (This doesn't happen in built-in case because this memory is freed after
> > all drivers are initialized.)
> >
> > Does this patch help?
>
> Ahh, indeed it does, _but_
>
> pdc202xx_old seems to have the same bug, making via82cxxx crash later on
> instead.
>
> Doing the same change to pdc202xx_old.h (removing __initdata) fixes this
> case too :-)

Yes, __initdata needs to be removed from every ide_pci_proc_host_t.
I will make a patch and submit it to Linus.

Thanks!
--bart

