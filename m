Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317747AbSGKCoF>; Wed, 10 Jul 2002 22:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSGKCoE>; Wed, 10 Jul 2002 22:44:04 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:2156 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S317747AbSGKCoC>; Wed, 10 Jul 2002 22:44:02 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7F94@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'CaT'" <cat@zip.com.au>, Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: RE: HZ, preferably as small as possible
Date: Wed, 10 Jul 2002 19:46:41 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: CaT [mailto:cat@zip.com.au] 
> On Wed, Jul 10, 2002 at 05:42:51PM -0400, Benjamin LaHaise wrote:
> > On Wed, Jul 10, 2002 at 02:38:32PM -0700, Andrew Morton wrote:
> > > OK, I'll grant that.  Why is this useful?
> > 
> > Think video playback, where you want to queue the frame to 
> be played as 
> > close to the correct 1/60s time as possible.  With HZ=100, 
> the code will 
> 
> Or 1/50 (think PAL), no? (Of course HZ=100 would be sweet for that. ;)

I don't know if I should mention this, but...

Win2k's default timer tick is 10ms (i.e. 100HZ) but it will go as low as 1ms
(1000HZ) if people request timers with that level of granularity. On the
fly.

So, a changing tick *can* be done. If Linux does the same thing, seems like
everyone is happy. What are the obstacles to this for Linux? If code is
based on the assumption of a constant timer tick, I humbly assert that the
code is broken.

Regards -- Andy
