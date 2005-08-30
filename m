Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVH3McI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVH3McI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVH3McI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:32:08 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:40867 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751419AbVH3McH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:32:07 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 30 Aug 2005 15:31:32 +0300
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050830123132.GH6055@atomide.com>
References: <1125354385.4598.79.camel@mindpipe> <200508301005.07353.kernel@kolivas.org> <20050830025459.GA16467@thunk.org> <200508301348.59357.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508301348.59357.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [050830 06:47]:
> On Tue, 30 Aug 2005 12:54 pm, Theodore Ts'o wrote:
> > On Tue, Aug 30, 2005 at 10:05:06AM +1000, Con Kolivas wrote:
> > > On Tue, 30 Aug 2005 08:42, Christopher Friesen wrote:
> > > > Lee Revell wrote:
> > > > > The controversy over the introduction of CONFIG_HZ demonstrated the
> > > > > urgency of getting a dynamic tick solution merged before 2.6.14.
> > > > >
> > > > > Anyone care to give a status report?  Con, do you feel that the last
> > > > > version you posted is ready to go in?
> > > >
> > > > Last time I got interested in this, the management of the event queues
> > > > was still a fairly major performance hit.
> > > >
> > > > Has this overhead been brought down to reasonable levels?
> > >
> > > Srivatsa is still working on the smp-aware scalable version, so it's back
> > > in the development phase.
> >
> > Has there been an updated version of Thomas's C-state bus-mastering
> > measurement patch?
> 
> Same issue, it's waiting on dynticks before being reworked.

Also one more minor issue; Dyntick can cause slow boots with dyntick
enabled from boot because the there's not much in the timer queue
until init.

This probably does not show up much on x86 though because of the
short hardware timers.

Tony
