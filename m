Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVHYQEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVHYQEB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHYQEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:04:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63879 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932225AbVHYQEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:04:00 -0400
Date: Thu, 25 Aug 2005 08:20:04 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, paulus@samba.org, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, hawkes@sgi.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix
Message-Id: <20050825082004.118554de.pj@sgi.com>
In-Reply-To: <20050825144156.GA5194@in.ibm.com>
References: <20050824111510.11478.49764.sendpatchset@jackhammer.engr.sgi.com>
	<20050824112640.GB5197@in.ibm.com>
	<20050824044648.66f7e25a.pj@sgi.com>
	<430C617E.8080002@yahoo.com.au>
	<20050824133107.2ca733c3.pj@sgi.com>
	<20050825144156.GA5194@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> I'll ack this for now until I fix the problems that I am seeing
> on ppc64

Thanks, Dinakar.

Linus - do *NOT* actually apply the literal patch that Dinakar ack'd.

 1) It's logic is backwards - arrgh.
 2) It doesn't undo the other attempt to partially disable this.
 3) It's not a formally submitted and signed off patch from me, but
    just a (useful) topic of discussion.

I have a pair of patches running through crosstool on several arch's now.

    The first patch undoes the partial disable of the cpuset to sched
    domain connection that is in 2.6.13-rc7 now.

    The second patch does what Nick and Dinakar now agree is right -
    totally disabling the ability for exclusive cpusets to define
    sched domains in 2.6.13.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
