Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbULIAeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbULIAeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 19:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbULIAeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 19:34:02 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11502 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261386AbULIAd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 19:33:58 -0500
To: linux-kernel@vger.kernel.org,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>
In-Reply-To: <cp78ct$d65$1@sea.gmane.org>
Subject: CD-ROM ide-dma blacklist amnesty drive
From: Junio C Hamano <junkio@cox.net>
Date: Wed, 08 Dec 2004 16:33:56 -0800
Message-ID: <7v7jns2tu3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:

>The "SAMSUNG CD-ROM SC-148F" drive is listed in drive_blacklist in
>ide-dma.c. However, this drive worked well with DMA enabled with earlier
>kernel versions (<=2.6.8.1) where the "via82cxxx" driver did not look at
>this blacklist. So the question: what was the reason for blacklisting this
>(apparently working) drive? Is it still valid?

This was discussed about two months ago without a firm
resolution as far as I can tell, in this thread:

    http://thread.gmane.org/gmane.linux.kernel/241862

Especially from Jens and Alan:

    http://article.gmane.org/gmane.linux.kernel/242226
    http://article.gmane.org/gmane.linux.kernel/242228

I've been meaning to start a "CD-ROM ide-dma blacklist amnesty
drive" ;-) The intent is to gather comments from owners of
blacklisted drives to see if those models still deserve to be on
the blacklist.

As for myself, I would vote for removing "PLEXTOR CD-R
PX-W8432T" (at least firmware "1.09") from the list.  This model
seems to work fine with DMA.  As Alexander does, I have been
running it on VIA motherboard which only recently started
looking at the ide-dma blacklist without trouble; that is,
before via82cxxx started caring.

The following is a list of CD drives blacklisted (I've removed
hard-disks and flash from the list) in drivers/ide/ide-dma.c as
of 2.6.10-rc3:

    Compaq CRD-8241B
    CRD-8400B
    CRD-8480B
    CRD-8480C
    CRD-8482B
    CRD-84
    SANYO CD-ROM CRD
    HITACHI CDR-8
    HITACHI CDR-8335
    HITACHI CDR-8435
    Toshiba CD-ROM XM-6202B
    CD-532E-A
    E-IDE CD-ROM CR-840
    CD-ROM Drive/F5A
    WPI CDD-820
    SAMSUNG CD-ROM SC-148C
    SAMSUNG CD-ROM SC-148F
    SAMSUNG CD-ROM SC
    SAMSUNG CD-ROM SN-124
    PLEXTOR CD-R PX-W8432T
    ATAPI CD-ROM DRIVE 40X MAXIMUM
    _NEC DV5800A

If (1) you are a owner of one of the listed drives, and (2) you
know your drive works fine with DMA, please speak up.
It would especially be a big plus if your drive is on via82cxxx
and did not have any trouble running it with DMA before 2.6.8.

Thanks.

