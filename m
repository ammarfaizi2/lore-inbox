Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVFHOPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVFHOPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFHOPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:15:41 -0400
Received: from dvhart.com ([64.146.134.43]:30376 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261242AbVFHOPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:15:25 -0400
Date: Wed, 08 Jun 2005 07:15:25 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <528220000.1118240125@[10.10.2.4]>
In-Reply-To: <20050607170853.3f81007a.akpm@osdl.org>
References: <1004450000.1118188239@flay><20050607165656.2517b417.akpm@osdl.org><Pine.LNX.4.62.0506071659580.30849@schroedinger.engr.sgi.com> <20050607170853.3f81007a.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Tuesday, June 07, 2005 17:08:53 -0700):

> Christoph Lameter <clameter@engr.sgi.com> wrote:
>> 
>> On Tue, 7 Jun 2005, Andrew Morton wrote:
>> 
>> > > Diffprofile is wacko (HZ seems to be defaulting to 250 in -mm).
>> > 
>> > Oh crap, so it does.  That's wrong.
>> 
>> Email by you and Linus indicated that 250 should be the default.
> 
> Oh, OK. hrm.
> 
> Martin, it would be useful if you could determine whether the kernbench
> slowdown was due to the 1000Hz->250Hz change, thanks.
> 
> I'm assuming it was the CPU scheduler patches.  There are 36 of them ;)

Is actually worse with HZ=1000 ... so I think we still have another problem,
probably with scheduler patches. (the one marked -mm1+p4947 in blue is the
patched one)

http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/perf/kernbench.moe.png

I can back out various patches ... are all the scheduler patches starting
in sched.* or something equally obvious? if not, a list of what to blat 
would help me ... or I'll do a crapshoot, and see what falls out ;-)

M.

