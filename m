Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbTEHNnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTEHNnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:43:45 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:26922 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261446AbTEHNno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:43:44 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030507152856.2a71601d.akpm@digeo.com>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos>  <20030507152856.2a71601d.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052402187.1995.13.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 May 2003 08:56:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 17:28, Andrew Morton wrote:
> Paul Fulghum <paulkf@microgate.com> wrote:
> >
> > 2.5.69
> > Latency 100-110usec (5x increase)
> > Spikes from 5-10 milliseconds
> > 

> If you can describe what drivers are in use, and what workload triggers the
> problem then it may be locatable by inspection.

After inspecting both machines, there is no common
hardware other than the net device. Both machines
use the e100 driver.

After removing the e100 driver altogether,
the increased latency and latency spikes persist.

So it looks like this problem is not specific to a
particular hardware driver, but is a result of a
more fundemental, system wide change.

I'm going to try your suggestion of doing a stack dump
when the driver encounters the large spikes in IRQ latency,
to determine if something is leaving interrupts disabled.

That will not address the fact that the minimum
latency has jumped from 20usec (2.4.20 - 2.5.68) to 100usec
(2.5.69). This may actually be two separate problems
introduced with 2.5.69

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


