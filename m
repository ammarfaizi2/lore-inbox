Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270701AbRHKACn>; Fri, 10 Aug 2001 20:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270695AbRHKACd>; Fri, 10 Aug 2001 20:02:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6142 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S270694AbRHKACa>;
	Fri, 10 Aug 2001 20:02:30 -0400
Importance: Normal
Subject: Re: [RFC][PATCH] Scalable Scheduling
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFA4B31174.1617AB16-ON85256AA5.00003B59@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Fri, 10 Aug 2001 20:04:13 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/10/2001 08:02:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris, I looked into the availability of this stuff. The people
here at Watson will put some of their low level stuff together and
hopefully we get some insights in a few weeks.
I keep you posted

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Chris Wedgwood <cw@f00f.org> on 08/10/2001 07:58:27 PM

To:   "David S. Miller" <davem@redhat.com>
cc:   lm@bitmover.com, torvalds@transmeta.com, Hubertus
      Franke/Watson/IBM@IBMUS, mkravetz@beaverton.ibm.com,
      linux-kernel@vger.kernel.org, wscott@bitmover.com
Subject:  Re: [RFC][PATCH] Scalable Scheduling



On Wed, Aug 08, 2001 at 11:53:28AM -0700, David S. Miller wrote:

    1) tell me D-cache misses in user and/or kernel mode
    2) tell me D-cache misses that hit the E-cache
       in user and/or kernel mode
    3) tell me I-cache misses, but only those which actually
       ended up stalling the pipeline
    4) tell me E-cache misses, where the chip was not able
       to get granted to memory bus immediately
    5) Same as #4, but how many total bus cycles were spent
       waiting for bus grant for the E-cache miss

ia32 for PPro and above can do all of that too pretty much (perhaps
not exactly the same metric, but hopefully equally useful).  The only
thing is, you can read them all at once, only a small number of them,
and they are for all kernel/userland states, so you would need to
save/read them on context switches.



  --cw




