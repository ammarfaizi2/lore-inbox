Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422984AbWJUBdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWJUBdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWJUBdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:33:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:65479 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750934AbWJUBdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:33:44 -0400
Date: Fri, 20 Oct 2006 18:33:24 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061020183324.b29caa37.pj@sgi.com>
In-Reply-To: <20061020135944.B8481@unix-os.sc.intel.com>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<453750AA.1050803@yahoo.com.au>
	<20061019105515.080675fb.pj@sgi.com>
	<4537BEDA.8030005@yahoo.com.au>
	<20061019115652.562054ca.pj@sgi.com>
	<4537CC1E.60204@yahoo.com.au>
	<20061019203744.09b8c800.pj@sgi.com>
	<453882AC.3070500@yahoo.com.au>
	<20061020130141.b5e986dd.pj@sgi.com>
	<20061020135944.B8481@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> Its just a corner case issue that Nick didn't consider while doing a quick
> patch. Nick meant to partition the sched domain at the top
> exclusive cpuset and he probably missed the case where root cpuset is marked
> as exclusive.

This makes no sense.

If P is a partition of S, that means that P is a set of subsets of
S such that the intersection of any two members of P is empty, and
the union of the members of P equals S.

If P is a partition of S, then adding S itself to P as another member
makes P no longer a partion, for then every element of S is in two
elements of P, not one.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
