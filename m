Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264810AbSKEIhy>; Tue, 5 Nov 2002 03:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264811AbSKEIhy>; Tue, 5 Nov 2002 03:37:54 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:1684 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264810AbSKEIhx>; Tue, 5 Nov 2002 03:37:53 -0500
Message-ID: <3DC784E3.2090001@namesys.com>
Date: Tue, 05 Nov 2002 00:44:19 -0800
From: reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Zarochentcev <zam@namesys.com>
CC: Nikita Danilov <Nikita@namesys.com>, Tomas Szepe <szepe@pinerecords.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <3DC19F61.5040007@namesys.com>	<200210312334.18146.Dieter.Nuetzel@hamburg.de>	<3DC1B2FA.8010809@namesys.com>	<3DC1D63A.CCAD78EF@digeo.com>	<3DC1D885.6030902@namesys.com>	<3DC1D9D0.684326AC@digeo.com>	<3DC1DF02.7060307@namesys.com>	<20021101102327.GA26306@louise.pinerecords.com>	<15810.46998.714820.519167@crimson.namesys.com>	<20021102132421.GJ28803@louise.pinerecords.com>	<15814.21309.758207.21416@laputa.namesys.com>	<3DC773B0.4070701@namesys.com> <15815.33089.583184.62816@crimson.namesys.com>
In-Reply-To: <3DC19F61.5040007@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Zarochentcev wrote:

> > >
> > >In reiser4 allocation of disk space is delayed to transaction commit. It
> > >is not possible to estimate precisely amount of disk space that will be
> > >allocated during commit, and hence statfs(2) results are not updated
> > >until one does sync(2) (forcing commit) or transaction is committed due
> > >to age (10 minutes by default).
> > >
> > >  
> > >
> > The above is badly phrased, and the behavior complained of is indeed a 
> > bug not a feature.  Please fix.  
> > 
> > statfs should be updated immediately in accordance with estimates used 
> > by the space reservation code, and then adjusted at commit time in 
> > accordance with actual usage.
>
>We should not do that unless we implement forcing of commits at out of free
>space situation.
>
I thought we had agreed to do forcing of commits at out of free space 
quite some time ago?  In any event, we should do forcing of commits at 
out of free space.  Yes?

