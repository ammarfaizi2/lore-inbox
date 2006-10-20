Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992769AbWJTVrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992769AbWJTVrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992770AbWJTVrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:47:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47285 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S2992769AbWJTVrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:47:12 -0400
Date: Fri, 20 Oct 2006 14:46:53 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061020144653.08ac6061.pj@sgi.com>
In-Reply-To: <20061020203016.GA26421@in.ibm.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<4538F34A.7070703@yahoo.com.au>
	<20061020120005.61239317.pj@sgi.com>
	<20061020203016.GA26421@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> Clearly one issue remains, tasks that are already running at the top cpuset.
> Unless these are manually moved down to the correct cpuset heirarchy they
> will continue to have the problem as before.

I take it you are looking for some reasonable and acceptable
constraints to place on cpusets, sufficient to enable us to
make it impossible (or at least difficult) to botch the
load balancing.

You want to make it difficult to split an active cpuset, so as
to avoid the undesirable limiting of load balancing across such
partition boundaries.

I doubt we can find a way to do that.  We'll have to let our
users make a botch of it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
