Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbTGKUDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTGKUCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:02:49 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:12931 "EHLO server")
	by vger.kernel.org with ESMTP id S265542AbTGKUBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:01:38 -0400
Message-ID: <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva> <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02> <1057703020.5568.10.camel@dhcp22.swansea.linux.org.uk> <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307091428450.26373@freak.distro.conectiva> <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva> <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva> <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
Subject: Re: Linux 2.4.22-pre3
Date: Fri, 11 Jul 2003 13:15:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,
    Here is what I got from my check. Snort is the culprit. When it starts,
it runs at 40mb. Each hour it adds 20 mb. So by the time the system is up
for hours, it starts cosuming memory. Today after I restartd my system, I
noticed every hour it was adding a mb of RAM.

It started at 40mb and after 4 hours is up to 45mb.

Thanx all for your help and assistance.

----- Original Message ----- 
From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
To: "Jim Gifford" <maillist@jg555.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Sent: Friday, July 11, 2003 10:06 AM
Subject: Re: Linux 2.4.22-pre3


>
> Right. Waiting for more results.
>
> Please always forawrd lkml okay?
>
> On Fri, 11 Jul 2003, Jim Gifford wrote:
>
> > It locked up last night, but no error information. But I did notice a
> > massive memory leak. I will follow up on that today, (756MB).
> >
> > ----- Original Message -----
> > From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> > To: "Jim Gifford" <maillist@jg555.com>
> > Cc: <riel@redhat.com>; "Andrea Arcangeli" <andrea@suse.de>
> > Sent: Friday, July 11, 2003 5:56 AM
> > Subject: Re: Linux 2.4.22-pre3
> >
> >
> > > y
> > >
> > > On Thu, 10 Jul 2003, Jim Gifford wrote:
> > >
> > > > I have a question, look at the buffers. Should the buffers be
increasing
> > in
> > > > this manner??
> > >
> > > I think its correct - its just caching more data after time passes.
> > >
> > > RIel, Andrea?
> > >
> > > >
> > > > When I started the system this was my reading
> > > >
> > > > top - 01:39:10 up 5 min, 1 user, load average: 3.70, 1.78, 0.72
> > > > Tasks: 106 total, 3 running, 103 sleeping, 0 stopped, 0 zombie
> > > > Cpu0 : 30.8% user, 13.5% system, 55.8% nice, 0.0% idle
> > > > Cpu1 : 39.7% user, 18.6% system, 41.7% nice, 0.0% idle
> > > > Mem: 1033896k total, 195548k used, 838348k free, 7188k buffers
> > > > Swap: 265060k total, 0k used, 265060k free, 45132k cached
> > > >
> > > > Here is my current reading after being up 13 hours.
> > > >
> > > > top - 14:41:57 up 13:06,  2 users,  load average: 2.92, 3.26, 3.11
> > > > Tasks: 118 total,   5 running, 113 sleeping,   0 stopped,   0 zombie
> > > >  Cpu0 :  32.5% user,  10.8% system,  56.7% nice,   0.0% idle
> > > >  Cpu1 :  27.4% user,  12.1% system,  60.5% nice,   0.0% idle
> > > > Mem:   1033672k total,   577568k used,   456104k free,   137452k
buffers
> > > > Swap:   265060k total,        0k used,   265060k free,   167232k
cached
> > >
> > >
> >
>

