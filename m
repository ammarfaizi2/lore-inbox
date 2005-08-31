Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVHaLRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVHaLRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVHaLRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:17:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:145 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932318AbVHaLRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:17:24 -0400
Date: Wed, 31 Aug 2005 16:47:05 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tony Lindgren <tony@atomide.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <kernel@kolivas.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Christopher Friesen <cfriesen@nortel.com>,
       Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Renninger <trenn@suse.de>
Subject: Re: Dynamic tick for 2.6.14 - what's the plan?
Message-ID: <20050831111705.GC10307@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1125354385.4598.79.camel@mindpipe> <200508301348.59357.kernel@kolivas.org> <20050830123132.GH6055@atomide.com> <200508301701.49228.s0348365@sms.ed.ac.uk> <20050831074419.GA1029@atomide.com> <1125477566.3213.6.camel@laptopd505.fenrus.org> <20050831103402.GA6496@atomide.com> <1125486186.3213.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125486186.3213.8.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 01:03:05PM +0200, Arjan van de Ven wrote:
> that sounds like a fundamental issue that really needs to be fixed
> first!

It should be fixed by the patch here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111556608901657&w=2

Tony,
	I don't see any slow bootups on x86 because of dyn-tick.
If you still see them in your env, can you test with the patch above?

Recovering time after sleep is the single biggest problem that I seem
to have, even while using ACPI PM timer (forget TSC). Time can
drift by couple of seconds after few hours. I have made
some changes to the lost tick calculation in timer_pm.c after which
it seems to be stable on some machines, but I cant repeat that
on other (maybe newer) machines. Will post out all the changes I have
pretty soon.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
