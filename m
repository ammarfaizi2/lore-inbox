Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280657AbRKFWv2>; Tue, 6 Nov 2001 17:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280674AbRKFWvM>; Tue, 6 Nov 2001 17:51:12 -0500
Received: from air-1.osdl.org ([65.201.151.5]:26754 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S280656AbRKFWuN>;
	Tue, 6 Nov 2001 17:50:13 -0500
Date: Tue, 6 Nov 2001 14:53:27 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Erik Andersen <andersen@codepoet.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <20011106154240.A32249@codepoet.org>
Message-ID: <Pine.LNX.4.33.0111061450530.22170-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Nov 2001, Erik Andersen wrote:

> On Tue Nov 06, 2001 at 11:33:49PM +0100, Jan-Benedict Glaw wrote:
> > On Tue, 2001-11-06 15:28:26 -0700, Erik Andersen <andersen@codepoet.org>
> > wrote in message <20011106152826.C31923@codepoet.org>:
> > > On Tue Nov 06, 2001 at 07:24:13PM -0200, Rik van Riel wrote:
> > > > PROCESSOR=0
> > > > VENDOR_ID=GenuineIntel
> > > > CPU_FAMILY=6
> > > > MODEL=6
> > > > MODEL_NAME="Celeron (Mendocino)"
> > > > .....
> >
> > PROCESSOR=1
> > ...
> >
> > > > . /proc/cpuinfo
> > >
> > > I think we have a winner!  If we could establish this
> > > as policy that would be _sweet_!
> >
> > What do you expect on a SMP system?
>
> How about something like:
> NUMBER_CPUS=8
> VENDOR_ID_0=GenuineIntel
> CPU_FAMILY_0=6
> MODEL_0=6
> MODEL_NAME_0="Celeron (Mendocino)"
> ...

(Though I think all caps variables are ugly, I can concede)

How about

$ cat /proc/cpus/0

PROCESSOR=0
VENDOR_ID=GenuineIntel
CPU_FAMILY=6
MODEL=6
MODEL_NAME="Celeron (Mendocino)"
.....

$ for i in `ls /proc/cpus/` ; do
	cat $i
  done
...


	-pat

