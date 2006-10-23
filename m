Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWJWSon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWJWSon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWJWSon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:44:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:4226 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965019AbWJWSom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:44:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YcI2fkD0Keb3faoOAAb7DnkBM8+TkUQoTtot5FHtIgKiwKBuQt9fjt7kI1bRP28z3UT4I3JYlUIwfUUnOZXzL7pR5bDkTSkNa4bfepjaRgY279qtQXhB+KXuAaismxA3jXG3okZ9HQsxf3d56U7PjSFZYGxqwsnnfNnAbNLh+fk=
Message-ID: <5bdc1c8b0610231144s420c1523p43af2a8349bac04@mail.gmail.com>
Date: Mon, 23 Oct 2006 11:44:40 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: tglx@linutronix.de
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6)
Cc: "Lee Revell" <rlrevell@joe-job.com>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, "John Stultz" <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Dipankar Sarma" <dipankar@in.ibm.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Mike Galbraith" <efault@gmx.de>, "Daniel Walker" <dwalker@mvista.com>,
       "Manish Lachwani" <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161628539.22373.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>
	 <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 2006-10-23 at 12:34 -0400, Lee Revell wrote:
> > On Fri, 2006-10-20 at 11:00 -0400, Lee Revell wrote:
> > > On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> > > > i've released the 2.6.18-rt6 tree, which can be downloaded from the
> > > > usual place:
> > > >
> > > >   http://redhat.com/~mingo/realtime-preempt/
> > >
> > > This does not work here.  It boots but then wants to fsck my disks, and
> > > dies with a sig 11 in fsck.ext3.  This is 100% reproducible and booting
> > > 2.6.18-rt5 works and does not want to fsck the disks.
> >
> > I see that -rt7 is posted.  The patch is a huge diff from -rt6.  Where
> > are the release notes?
>
> Basically we merged the latest hrt-dyntick queue into -rt.
>
>         tglx

Hi Thomas,
   Some differences/questions between 2.6.18-rt6 and 2.6.18-rt7:

   In 2.6.18-rt6, using make menuconfig, there were options on the
front page for HRT Support. This seems to have moved under Processor
Type with 2.6.18-rt7. Was that on purpose?

   In 2.6.18-rt6 I turned on HRT support, left 1000 nanoseconds for
the timing, but did not enable dynamic ticks since I wasn't sure it
was OK on AMD64. Should I be using DynTicks with an AMD64 single
processor? With a dual-processor?

   On 2.6.18-rt7 it seems there is no time value setting or it's been
moved somewhere I haven't found. does that 1000 nanosecond time
setting still apply?

Thanks,
Mark
