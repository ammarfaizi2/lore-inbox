Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277241AbRJDVvF>; Thu, 4 Oct 2001 17:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277242AbRJDVu4>; Thu, 4 Oct 2001 17:50:56 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:15833 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S277241AbRJDVuq>; Thu, 4 Oct 2001 17:50:46 -0400
Message-ID: <3BBCDA59.55A5E247@oracle.com>
Date: Thu, 04 Oct 2001 23:53:29 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.11-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <E15pFzU-0004H7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Alan mentioned this was something to do with the IBM hard disk
> > > having strange write-cache properties that confuse ext3.
> >
> > Which IBM harddrive(s) does this? How can one check if it does?
> 
> Its not specifically IBM, there are two sets of things to watch out for
> 
> -       Cache flush as a nop/unimplemented. This is legal in all but the
>         most recent ATA specification. The spec has been tightened so that
>         problem will go in time
> 
> -       Some IBM laptop drives appeared to fail to write back the cache on
>         machine shutdown/suspend etc. The exact rights/wrongs/details on
>         that one haven't been pinned down because the folks concerned
>         swapped a couple of drives for different ones, saw the problem
>         vanish and being a large organisation had the supplier replace the
>         other fifty odd.

[asuardi@dolphin asuardi]$ dmesg | grep hda
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
hda: IBM-DJSA-220, ATA DISK drive
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2432/255/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >

This one has been used in the last 4 months without any issue
 doing lots of shutdowns, suspends, kernel rebuilds etc. ;)

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
