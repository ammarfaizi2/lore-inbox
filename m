Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSH0Ctp>; Mon, 26 Aug 2002 22:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSH0Ctp>; Mon, 26 Aug 2002 22:49:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19144 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318355AbSH0Ctp>; Mon, 26 Aug 2002 22:49:45 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: "Bill Hartner" <bhartner@us.ibm.com>, davem@redhat.com,
       jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
       "Mala Anand" <manand@us.ibm.com>, netdev@oss.sgi.com,
       Robert Olsson <Robert.Olsson@data.slu.se>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF815FDA48.08A89D80-ON87256C22.000D9ED4@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 26 Aug 2002 21:53:37 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/26/2002 08:53:39 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robert Olsson wrote..
 >In slab terms you moved part of the destructor to the constructor
 >but the main problem is still there. The skb entered the "wrong" CPU
 >so to be "reused from the slab again" the work has to done regardless
 >if it's in the constructor or destructor.
That is true if it is a uni processor but in smp the initialization,
if happened in two different CPUs, affects performance due to cache
effects.

The problem of object (skb) allocation, usage and deallocation occurring
in multiple CPUs need to be addressed separately. This patch is not
attempting to address that.

 >Eventually if we accept some cache misses a skb could possibly be
re-routed
 >to the proper slab/CPU for this we would need some skb coloring.
You still can do this. I don't see skbinit patch hindering this.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




