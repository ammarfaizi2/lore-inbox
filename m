Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWGLOy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWGLOy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWGLOy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:54:59 -0400
Received: from ns.suse.de ([195.135.220.2]:53944 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751029AbWGLOy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:54:59 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Date: Wed, 12 Jul 2006 16:54:54 +0200
User-Agent: KMail/1.9.3
Cc: "Joachim Deguara" <joachim.deguara@amd.com>,
       "Mark Langsdorf" <mark.langsdorf@amd.com>, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
References: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com> <1152622554.4489.32.camel@lapdog.site> <1152713168.14450.18.camel@lapdog.site>
In-Reply-To: <1152713168.14450.18.camel@lapdog.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607121654.54152.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 16:06, Joachim Deguara wrote:
> On Tue, 2006-07-11 at 14:55 +0200, Joachim Deguara wrote:
> > Here are some initial findings. 
> 
> Here are the further findings after letting the machine toggle between
> 1GHz and 2.2Ghz every two seconds for roughly 24 hours.  Unfortunately
> there is an oops after bringing CPU2 online and CPU3 will not come
> online.  

Perhaps Mark/Jacob can take a look at the oops.

> Still the differences in TSC are not bad: 

Think: any difference you get for 24h will be 10x when the system runs 10 times longer
and 365 times when the system runs for a year (and there are Linux systems
who run much longer than a year) 

Also even small non monotonies between CPUs in gettimeofday can cause big trouble.

-Andi

