Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTAXSLc>; Fri, 24 Jan 2003 13:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbTAXSLc>; Fri, 24 Jan 2003 13:11:32 -0500
Received: from fmr03.intel.com ([143.183.121.5]:9956 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id <S261398AbTAXSLb>;
	Fri, 24 Jan 2003 13:11:31 -0500
Message-Id: <200301241820.h0OIKZr16376@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: GrandMasterLee <masterlee@digitalroadkill.net>
Subject: Re: Using O(1) scheduler with 600 processes.
Date: Fri, 24 Jan 2003 10:22:17 -0800
X-Mailer: KMail [version 1.3.1]
Cc: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
References: <1043367029.28748.130.camel@UberGeek> <200301240204.h0O24Kr04239@unix-os.sc.intel.com> <1043388479.12855.21.camel@localhost>
In-Reply-To: <1043388479.12855.21.camel@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 January 2003 10:08 pm, GrandMasterLee wrote:
> Well, if I could get a clean patch against 2.4.20, or possibly some help
> fixing the one  I do have, thanks to Ingo, then we'd have a straight
> O(1) sched for 2.4.20. I tried merging the patch that Ingo gave me, and
> everything seems OK, but I don't have any menu selection for O(1) stuff
> in the kernel config.(0 and 100 priority bits)
>
> So I can't tell if it's enabled.

do a ps -aux and see if there are any process migration threads, if you do 
then its running the O(1) scheduler.

>
> > Your milage will vary.
> > 
> > Give it a try.
> > 
> > --mgross
> > 
>
> I agree. In the interest of time, I may have to forego O(1), but maybe
> I'll get lucky. :) *hint*hint* :)

You really should try the O(1) scheduler.  600 process is a lot, we had ~100 
for our benchmarks so it wasn't as big of a overhead for the old scheduler.  
(Running Itanium 2's didn't hurt either ;) 

Your running Xeon's with more processes, you are more likely to see a benefit 
from the O(1) scheduler.

--mgross
