Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279338AbRJWJ7Z>; Tue, 23 Oct 2001 05:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279342AbRJWJ7Q>; Tue, 23 Oct 2001 05:59:16 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:5391 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S279338AbRJWJ7J>; Tue, 23 Oct 2001 05:59:09 -0400
Reply-To: <frey@scs.ch>
From: "Martin Frey" <frey@scs.ch>
To: "'Jens Axboe'" <axboe@suse.de>, "'Shailabh Nagar'" <nagar@us.ibm.com>
Cc: "'Reto Baettig'" <baettig@scs.ch>, <lse-tech@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
Date: Tue, 23 Oct 2001 05:59:03 -0400
Message-ID: <000b01c15ba9$58ba4e90$e6c02f10@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <20011023084238.C638@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I haven't seen the SGI rawio patch, but I'm assuming it used kiobufs to
>pass a single unit of 1 meg down at the time. Yes currently we do incur
>significant overhead compared to that approach.
>
Yes, it used kiobufs to get a gatherlist, setup a gather DMA out
of that list and submitted it to the SCSI layer. Depending on
the controller 1 MB could be transfered with 0 memcopies, 1 DMA,
1 interrupt. 200 MB/s with 10% CPU load was really impressive.

Regards, Martin
