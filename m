Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266544AbRGONPO>; Sun, 15 Jul 2001 09:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266512AbRGONPF>; Sun, 15 Jul 2001 09:15:05 -0400
Received: from mail010.mail.bellsouth.net ([205.152.58.30]:23951 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S266438AbRGONO6>; Sun, 15 Jul 2001 09:14:58 -0400
Message-ID: <005501c10d30$54e0e260$7c853dd0@hppav>
From: "Ken Hirsch" <kenhirsch@myself.com>
To: "Chris Wedgwood" <cw@f00f.org>, "John Alvord" <jalvo@mbay.net>
Cc: "Daniel Phillips" <phillips@bonn-fries.net>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Andrew Morton" <andrewm@uow.edu.au>,
        "Andreas Dilger" <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Ben LaHaise" <bcrl@redhat.com>,
        "Ragnar Kjxrstad" <kernel@ragnark.vestdata.no>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mike@bigstorage.com>, <kevin@bigstorage.com>, <linux-lvm@sistina.com>
In-Reply-To: <Pine.LNX.4.20.0107142304010.17541-100000@otter.mbay.net> <20010715180752.B7993@weta.f00f.org>
Subject: Re: [PATCH] 64 bit scsi read/write
Date: Sun, 15 Jul 2001 09:16:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
> On Sat, Jul 14, 2001 at 11:05:36PM -0700, John Alvord wrote:
>
>     In the IBM solution to this (1977-78, VM/CMS) the critical data was
>     written at the begining and the end of the block. If the two data
items
>     didn't match then the block was rejected.
>
> Neat.
>
>
> Simple and effective.  Presumably you can also checksum the block, and
> check that.

The first technique is not sufficient with modern disk controllers, which
may reorder sector writes within a block.  A checksum, especially a robust
CRC32, is sufficient, but rather expensive.

Mohan has a clever technique that is computationally trivial and only uses
one bit per sector: http://www.almaden.ibm.com/u/mohan/ICDE95.pdf

Unfortunately, it's also patented:
http://www.delphion.com/details?pn=US05418940__

Perhaps IBM will clarify their position with respect to free software and
patents in the upcoming conference.



