Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280583AbRKSSlR>; Mon, 19 Nov 2001 13:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbRKSSk6>; Mon, 19 Nov 2001 13:40:58 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:11269 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S280570AbRKSSkp>; Mon, 19 Nov 2001 13:40:45 -0500
Date: Mon, 19 Nov 2001 13:40:45 -0500
Message-Id: <200111191840.fAJIej230821@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: if (a & X || b & ~Y) in dasd.c
X-Newsgroups: linux.kernel
In-Reply-To: <20011108155749.A24023@devserv.devel.redhat.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011108155749.A24023@devserv.devel.redhat.com> zaitcev@redhat.com wrote:
>Carsten and others:
>
>this code in 2.2.14 looks suspicious to me:
>
>./drivers/s390/block/dasd.c:
>        /* first of all lets try to find out the appropriate era_action */
>        if (stat->flag & DEVSTAT_FLAG_SENSE_AVAIL ||
>            stat->dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END)) {

  If the code does what I think it does, it works as written. However, I
usually would throw in parenthesis on something like this to be sure
that the next person reading the code won't waste time thinking about
it. I always thought that good code was literature, which could be read,
understood, and enjoyed by many.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
