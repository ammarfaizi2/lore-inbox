Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRBHCAt>; Wed, 7 Feb 2001 21:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130829AbRBHCAa>; Wed, 7 Feb 2001 21:00:30 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:47877 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129363AbRBHCAT>;
	Wed, 7 Feb 2001 21:00:19 -0500
Message-ID: <3A81FDAF.43DE0791@vgkk.com>
Date: Thu, 08 Feb 2001 11:00:15 +0900
From: "A.Sajjad Zaidi" <sajjad@vgkk.com>
Organization: Vanguard K.K.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
In-Reply-To: <Pine.LNX.4.10.10102070924340.19012-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

> > drives (all IBM-DTLA307045 s) that I realised that the cylinder/head
> > translation is different and I cant use the whole drive unless its
> > partitioned while attached to the other IDE ports.
>
> no, it's just that the bios doesn't perform the LBA geometry lie
> outside the hd[abcd].

Hmm, thats weird, because hd[abcd] were the ones without the LBA geometry.
Maybe it was because ide was reversed (ide=reverse lilo parameter).

> boot with hde="6666,255,63" (or whatever).

Thanks, I was searching for something like that.

> > Second, I set up raid mirroring for 4 drives(2 raid, 2spare).  Since one
> > drive isnt available yet, one of the 2 raid partitions are set as
> > 'failed-disk'. All drives are connected to the ATA-100 controller. This
>
> do you understand that you can't really have raid on ide involving
> two drives on the same channel?

Is that just because of performance or are there other problems? Its working
fine as it is, but Im considering setting up all drives as masters (2x
ATA-100, 2x ATA-66).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
