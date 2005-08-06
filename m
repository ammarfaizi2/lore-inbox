Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVHFAbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVHFAbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVHFAbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:31:10 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:29611 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262199AbVHFAan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:30:43 -0400
Subject: Re: [PATCH] netpoll can lock up on low memory.
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>,
       davem@davemloft.net
In-Reply-To: <20050805212610.GA8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
	 <p73ek987gjw.fsf@bragg.suse.de>
	 <1123249743.18332.16.camel@localhost.localdomain>
	 <20050805135551.GQ8266@wotan.suse.de>
	 <1123251013.18332.28.camel@localhost.localdomain>
	 <20050805141426.GU8266@wotan.suse.de>
	 <1123252591.18332.45.camel@localhost.localdomain>
	 <20050805200156.GF7425@waste.org>  <20050805212610.GA8266@wotan.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 20:30:21 -0400
Message-Id: <1123288221.18332.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 23:26 +0200, Andi Kleen wrote:

> I suspect Steven's patch for the e1000 is needed in addition to
> handle different cases too.
> 

I haven't tested it. Someone with a e1000 must see if it works. I
submitted the e100 fix that had the same problem, but I would feel
better if the patch I sent for the e1000 actually got tested.

To test, one would setup a box with the e1000 and netconsole. Run with
something doing several printks (possible using sysrq-t or such), and
then unplug the cable (without Andi's patch) and replug it back in. If
the patch worked, the system would hang while the cable was detached,
but come back shortly after the cable was plugged back in.

-- Steve


