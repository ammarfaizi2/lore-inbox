Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWCSGeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWCSGeD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 01:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWCSGeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 01:34:03 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:24708 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751422AbWCSGeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 01:34:01 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Date: Sun, 19 Mar 2006 01:34:01 -0500
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com, davej@redhat.com
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
In-Reply-To: <20060318165302.62851448.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603190134.01833.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 19:53, Andrew Morton wrote:
> I might stick a once-off WARN_ON() in there so someone gets in
> and works out why we keep on having to graft mysterious null-pointer
> avoidances into cpufreq.
cpufreq_conservative should be marked broken on SMP - I have used it on UP 
boxes without trouble but I can't even safely modprobe it on SMP - it nearly 
ate my filesystem.  

And there seem to be multiple different problems with it - I get different 
oopses depending upon whether or not I have loaded it before or after the 
ondemand module.  Weird enough - cpufreq_conservative shares much of it's 
code with cpufreq_ondemand, which works without any problem. 

Let me know if anyone has objection to marking cpufreq_conservative 
depends !SMP - I am planning to submit  a patch soon.

Parag
