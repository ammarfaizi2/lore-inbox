Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbVGORGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbVGORGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVGORGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:06:11 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:777 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S263334AbVGOREc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:04:32 -0400
Message-ID: <1121439115.42d7cd8b3f372@vds.kolivas.org>
Date: Sat, 16 Jul 2005 00:51:55 +1000
From: kernel@kolivas.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121383050.4535.73.camel@mindpipe>  <Pine.LNX.4.58.0507141623490.19183@g5.osdl.org>  <200507151408.39932.kernel@kolivas.org> <1121401043.12420.5.camel@mindpipe>  <Pine.LNX.4.61.0507142254140.16055@montezuma.fsmlabs.com> <1121446794.12420.30.camel@mindpipe>
In-Reply-To: <1121446794.12420.30.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Revell <rlrevell@joe-job.com>:

> On Thu, 2005-07-14 at 22:54 -0600, Zwane Mwaikambo wrote:
> > On Fri, 15 Jul 2005, Lee Revell wrote:
> > 
> > > On Fri, 2005-07-15 at 14:08 +1000, Con Kolivas wrote:
> > > > Audio did show slightly larger max latencies but nothing that would be
> of 
> > > > significance.
> > > > 
> > > > On video, maximum latencies are only slightly larger at HZ 250, all the
> 
> > > > desired cpu was achieved, but the average latency and number of missed
> 
> > > > deadlines was significantly higher.
> > > 
> > > Because audio timing is driven by the soundcard interrupt while video,
> > > like MIDI, relies heavily on timers.
> > 
> > In interbench it's not driven by a soundcard interrupt.
> > 
> > 
> 
> OK.  Con, any idea why video is so much more affected than audio?

In the emulation, video vs audio is 40% cpu vs 5% cpu, 16.7ms frames instead of
50ms frames. When your cpu requirements are higher and your frames are shorter
the likelihood of dropping a frame, especially under load, will skyrocket as
your timing granularity decreases. Clearly 250HZ is not as good as 1000HZ for
this, and I assume your midi example.

Cheers,
Con


