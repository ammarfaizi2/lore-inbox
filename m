Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTDCVH7 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263444AbTDCVH7 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:07:59 -0500
Received: from popmail.goshen.edu ([199.8.232.22]:15258 "EHLO mail.goshen.edu")
	by vger.kernel.org with ESMTP id S263440AbTDCVHz 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 16:07:55 -0500
Subject: Re: RAID 5 performance problems
From: Ezra Nugroho <ezran@goshen.edu>
To: Jonathan Vardy <jonathanv@explainerdc.com>
Cc: Andy Arvai <arvai@scripps.edu>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <004901c2fa25$795b5d80$2e77c23e@pentium4>
References: <200304031949.LAA28555@astra.scripps.edu> 
	<004901c2fa25$795b5d80$2e77c23e@pentium4>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 03 Apr 2003 16:31:39 -0500
Message-Id: <1049405499.22426.5184.camel@ezran.goshen.edu>
Mime-Version: 1.0
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That looks like a slow build!
Mine is about 15 - 20M/sec.

Another observation I saw, I raided the raw devices instead of the
partitions; meaning my array is build from hde, hdg, hdi and hdk
as opposed to hde1, hdg1, hdi1 and hdk1.


On Thu, 2003-04-03 at 16:10, Jonathan Vardy wrote:
> you're right, it should be. When I was writing the original mail I had it
> running in degraded mode so I edited the values that /proc/mdstat gave me to
> match the array in normal mode. I forgot to make [_UUUU]  [UUUUU]. I'm
> currently rebuilding the array but it's taking some time...
> 
> md0 : active raid5 hdc1[5] hdk1[4] hdi1[3] hdg1[2] hde1[1]
>       468872704 blocks level 5, 128k chunk, algorithm 0 [5/4] [_UUUU]
>       [================>....]  recovery = 83.1% (97429504/117218176)
> finish=65.5min speed=5034K/sec
> 
> ----- Original Message -----
> From: "Andy Arvai" <arvai@scripps.edu>
> To: <linux-raid@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Thursday, April 03, 2003 9:49 PM
> Subject: Re: RAID 5 performance problems
> 
> 
> >
> > Shouldn't /proc/mdstat have [UUUUU] instead of [_UUUU]? Perhaps
> > this is running in degraded mode. Also, you have 'algorithm 0',
> > whereas my raid5 has 'algorithm 2', which is the left-symmetric
> > parity algorithm.
> >
> > Andy
> >
> > > cat /proc/mdstat gives:
> > >
> > > Personalities : [raid0] [raid5]
> > > read_ahead 1024 sectors
> > > md0 : active raid5 hdk1[4] hdi1[3] hdg1[2] hde1[1] hdc1[0]
> > > 468872704 blocks level 5, 128k chunk, algorithm 0 [5/5] [_UUUU]
> > > unused devices: <none>
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


