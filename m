Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWARBB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWARBB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWARBB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:01:29 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:48291 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932410AbWARBB2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:01:28 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Gain Paolo Mureddu <gmureddu@prodigy.net.mx>
Subject: Re: Problems building
Date: Wed, 18 Jan 2006 12:01:53 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
References: <43CD8FB7.90508@prodigy.net.mx>
In-Reply-To: <43CD8FB7.90508@prodigy.net.mx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601181201.53427.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006 11:45 am, Gain Paolo Mureddu wrote:
>     For some reason I am getting a strange message when I try to build
> either -ck1 or 2, another message I tried to send to the list seems to
> not have gotten where I intended to, I'm quoting that message here also:

The list is filtered due to my minimal resources and inability to have any 
formal spam filtering so only members or approved emails get through and 
everything else silently dropped. Sorry about any inconvenience. I've added 
your email to accept and cc'ed the mailing list now.

> Gain Paolo Mureddu wrote:
> > So I have been struggling to get this kernel built, and apparently
> > I've narrowed this down to the sched_iso3.2 and/or isobatch_ionice
> > patches, however I can't be fully certain. Here is what is dumped
> > to the console, I've gotten two dumps, this and one concerning
> > sched.o, which I am still investigating. So here goes the dump:
> >
> > <build_dump> .... [snip] CC init/do_mounts_md.o In file included
> > from include/linux/bio.h:25, from include/linux/blkdev.h:14, from
> > include/linux/raid/md.h:21, from init/do_mounts_md.c:2:
> > include/linux/ioprio.h: En la función ?task_nice_ioprio?:
> > include/linux/ioprio.h:58: error: ?SCHED_BATCH? not declared here
> > (first use in this function) include/linux/ioprio.h:58: error:
> > (Each undeclared identifier is only reported once
> > include/linux/ioprio.h:58: error: for each function it appears in.)
> > include/linux/ioprio.h:60: error: ?SCHED_ISO? not declared here
> > (first use in this function) make[1]: *** [init/do_mounts_md.o]
> > Error 1 make: *** [init] Error 2 </build_dump> Anyone else with
> > troubles in x86_64 systems?
> >
> > TIA!
>
> I get the same error, thus far I know that the file in question
> (iprio.h) inclues sched.h and that in sched.h SCHED_BATCH and
> SCHED_ISO are defined, so why am I getting this error in the said
> function, is beyond me.
>
> Any pointers?

These errors do not occur with the full patch. Are you using any split patches 
or just the full patch? Separating out patches is not a trivial thing to do.

Cheers,
Con
