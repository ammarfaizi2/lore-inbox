Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbVKYP3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbVKYP3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbVKYP3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:29:35 -0500
Received: from eurocopter-av-smtp1.gmessaging.net ([194.51.201.42]:57522 "EHLO
	eurocopter-av-smtp1.gmessaging.net") by vger.kernel.org with ESMTP
	id S1161081AbVKYP3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:29:34 -0500
Date: Fri, 25 Nov 2005 16:27:08 +0100
From: "Schultheiss, Christoph" <Christoph.Schultheiss@eurocopter.com>
Subject: AW: duration of udelay differs with activated realtime-preempt patch?
To: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-id: <B7DA45CF87D412408436D5ECAAB9B90F6E7A22@sma2906.cr.eurocopter.corp>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-class: urn:content-classes:message
Thread-topic: duration of udelay differs with activated realtime-preempt patch?
Thread-index: AcXxx9l3sE4eff9FRc23NuWjK+NFxAACgKIQ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 25 Nov 2005 15:27:09.0939 (UTC)
 FILETIME=[B3A78C30:01C5F1D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > after measuring the duration of the function udelay (with
oscilloscope
> > > at parallel port), I figured out that udelay (5usec) with
activated
> > > realtime- preempt patch lasts a little bit longer. Without the
patch the
> > > time is exact.
> > > All kernel debug switches are turned off at compile time.
> > > Can anyone suggest why this happens?
> > 
> > Well, the -rt patch, has changed the udelay function.  BTW, you are 
> > using the constant udelay, right?  Maybe an example of the code you 
> > used to test might be useful.
> > 
> > Ingo or John?
>
> yes, i found this problem too, a week ago or so. It's due to the GTOD 
> changes to i386's __delay() function. Does it still occur with -rt15 
> [which has the -B11 GTOD patchset] ?

I've done the first measurements only with rt5 and rt13. 
Now with rt15 it looks fine (nice 5usec!)

fine patch, thanks!

christoph
