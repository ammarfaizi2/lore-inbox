Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUHMHCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUHMHCD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269011AbUHMHCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:02:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60646 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269010AbUHMHB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:01:57 -0400
Date: Fri, 13 Aug 2004 09:01:20 +0200
From: Jens Axboe <axboe@suse.de>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040813070119.GC2321@suse.de>
References: <1092099669.5759.283.camel@cube> <cone.1092113232.42936.29067.502@pc.kolivas.org> <411BF083.8060406@tmr.com> <yw1xllgkgcl9.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xllgkgcl9.fsf@kth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13 2004, Måns Rullgård wrote:
> Bill Davidsen <davidsen@tmr.com> writes:
> 
> > Con Kolivas wrote:
> >
> >> It was a hard lockup and randomly happened during a cd write,
> >> creating my first coaster in a long time... in rt mode ironically
> >> which is how it is recommended to be run. So I removed the foolish
> >> superuser bit and have had no problem since. Yes it was unaltered
> >> cdrecord source and it was the so-called alpha branch and... Not
> >> much else I can say about it really?
> >
> > I said I'd never seen this (true), but it could happen if you were
> > burning an audio CD using the ide-scsi or ATA: interface. In 2.6 the
> > ATAPI: interface uses DMA. I don't know what the program does if you
> > just say dev=/dev/hdx,

This is only true for recent 2.6 kernels.

> Whatever it does, it doesn't load the system noticeably.

ATA uses SG_IO. Bill should re-read most of this thread as he is
repeating what others have said and have been corrected on (not just
this mail, btw).

-- 
Jens Axboe

