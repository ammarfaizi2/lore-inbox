Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284548AbRLNWhT>; Fri, 14 Dec 2001 17:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284553AbRLNWhK>; Fri, 14 Dec 2001 17:37:10 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:43400 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284548AbRLNWgz>; Fri, 14 Dec 2001 17:36:55 -0500
Date: Fri, 14 Dec 2001 23:26:22 +0100 (CET)
From: eduard.epi@t-online.de (Peter Bornemann)
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Jens Axboe <axboe@suse.de>, Kirk Alexander <kirkalx@yahoo.co.nz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20011214183721.H1878-100000@gerard>
Message-ID: <Pine.LNX.4.33.0112142248290.4722-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
> By the way, for now, I haven't received any report about sym-2 failing
> when sym-1 or ncr succeeds, and my feeling is that this could well be very
> unlikely.
>

Ahemm -- well,
maybe I'm the first one. I have a symbios card, which is recognized by
lspci:  SCSI storage controller: LSI Logic Corp. / Symbios Logic Inc.
(formerly NCR) 53c810 (rev 23).

This card goes into an endless loop during parity-checking. So tried to
disable it for the new sym53cxx in modules.conf:
options sym53c8xx mpar:n spar:n
This did not help in this case, however.

There have been so far three ways to solve  this problem:
1. Use the very old ncr53c7,8 or so driver. This is working rather
unreliable for me.
2. Use the ncr53c8xx, which works usually well
3. Use sym53c8xx(old) compiled with parity disabled

Probably there is a way around that, but somebody trying to install Linux
from a SCSI-CDROM with this card for the first time will very likely not
succeed. I have seen this with (for instance) Corel-Linux and FreeBSD
(same driver).
NB Parity checking for me is not really all that important as there is no
hardrive connected to that card. Only CD and scanner.

Peter B

          .         .
          |\_-^^^-_/|
          / (|)_(|) \
         ( === X === )
          \  ._|_.  /
           ^-_   _-^
              °°°

