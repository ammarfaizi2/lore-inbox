Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVIQSqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVIQSqt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 14:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVIQSqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 14:46:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12292 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751184AbVIQSqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 14:46:48 -0400
Date: Sat, 17 Sep 2005 20:46:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Eradic disk access during reads
Message-ID: <20050917184643.GA1313@alpha.home.local>
References: <200509170717.03439.a1426z@gawab.com> <20050917055010.GG30279@alpha.home.local> <200509171323.53054.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509171323.53054.a1426z@gawab.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 01:32:53PM +0300, Al Boldi wrote:
> Willy Tarreau wrote:
> > On Sat, Sep 17, 2005 at 07:26:11AM +0300, Al Boldi wrote:
> > > Monitoring disk access using gkrellm, I noticed that a command like
> > >
> > > cat /dev/hda > /dev/null
> > >
> > > shows eradic disk reads ranging from 0 to 80MB/s on an otherwise idle
> > > system.
> > >
> > > 1. Is this a hardware or software problem?
> >
> > Difficult to tell without more info. Can be a broken IDE disk or defective
> > ribbon.
> 
> Tried the same with 2.4.31 which shows steady behaviour with occasional dips 
> and pops in the msec range.
> 
> >
> > > 2. Is there a lightweight perf-mon tool (cmd-line) that would log this
> > > behaviour graphically?
> >
> > You can do " readspeed </dev/hda | tr '\r' '\n' > log " with the readspeed
> > tool from there :
> >    http://w.ods.org/tools/readspeed
> 
> Does it have msec resolution?

no, it does not. It will only show you the average transfer rate during
the past second each second. It often helps me tune network, nfs, raid, ...

Denis' tool seems clearly more suited to analyse your problem.

Regards,
Willy

