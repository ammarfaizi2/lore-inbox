Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTDCU72 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263556AbTDCU71 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:59:27 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:8741 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S263540AbTDCU7K 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:59:10 -0500
Message-ID: <004901c2fa25$795b5d80$2e77c23e@pentium4>
From: "Jonathan Vardy" <jonathanv@explainerdc.com>
To: "Andy Arvai" <arvai@scripps.edu>, <linux-raid@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
References: <200304031949.LAA28555@astra.scripps.edu>
Subject: Re: RAID 5 performance problems
Date: Thu, 3 Apr 2003 23:10:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you're right, it should be. When I was writing the original mail I had it
running in degraded mode so I edited the values that /proc/mdstat gave me to
match the array in normal mode. I forgot to make [_UUUU]  [UUUUU]. I'm
currently rebuilding the array but it's taking some time...

md0 : active raid5 hdc1[5] hdk1[4] hdi1[3] hdg1[2] hde1[1]
      468872704 blocks level 5, 128k chunk, algorithm 0 [5/4] [_UUUU]
      [================>....]  recovery = 83.1% (97429504/117218176)
finish=65.5min speed=5034K/sec

----- Original Message -----
From: "Andy Arvai" <arvai@scripps.edu>
To: <linux-raid@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, April 03, 2003 9:49 PM
Subject: Re: RAID 5 performance problems


>
> Shouldn't /proc/mdstat have [UUUUU] instead of [_UUUU]? Perhaps
> this is running in degraded mode. Also, you have 'algorithm 0',
> whereas my raid5 has 'algorithm 2', which is the left-symmetric
> parity algorithm.
>
> Andy
>
> > cat /proc/mdstat gives:
> >
> > Personalities : [raid0] [raid5]
> > read_ahead 1024 sectors
> > md0 : active raid5 hdk1[4] hdi1[3] hdg1[2] hde1[1] hdc1[0]
> > 468872704 blocks level 5, 128k chunk, algorithm 0 [5/5] [_UUUU]
> > unused devices: <none>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

