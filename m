Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSILSor>; Thu, 12 Sep 2002 14:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSILSor>; Thu, 12 Sep 2002 14:44:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:53441 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317012AbSILSoo>;
	Thu, 12 Sep 2002 14:44:44 -0400
Message-ID: <3D80E1B5.7B3B8AA0@digeo.com>
Date: Thu, 12 Sep 2002 11:49:25 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
References: <3D7FFF12.24B0FDAA@digeo.com> <200209120640.g8C6eTD00198@eng4.beaverton.ibm.com> <3D804036.4C000672@digeo.com> <200209121837.g8CIbIp06737@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 18:49:28.0102 (UTC) FILETIME=[1F40BC60:01C25A8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> On 12 September 2002 05:20, Andrew Morton wrote:
> > > Lastly, a bit of a philosophical question.  /proc/stat and (with this
> > > patch) /proc/diskstats provide some of the same information. Should
> > >
> > >     a) all of it appear in /proc/stat?
> > >
> > >     b) all of it appear in /proc/diskstats?
> > >
> > >     c) keep the current (limited) info in /proc/stat (for backward
> > >        compatibility) and introduce the expanded info in
> > >        /proc/diskstats?
> > >
> > > My preference is b, but I'm open to other opinions.
> >
> > b).  Let's get the kernel right and change userspace to follow.  We have
> > another accounting patch which breaks top(1), so Rik has fixed it (and
> > is feeding the fixes upstream).
> 
> Erm... Some of /proc/stat data has no relations to disks, namely CPU counts.
> It would be strange to have CPU stats in /proc/diskstats...

Rick is proposing that all the disk stuff be in /proc/diskstat and
that all the process stuff be in /proc/stat.  ie: move all the disk
accounting out of /proc/stat.
