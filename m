Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbUJZQpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbUJZQpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 12:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbUJZQpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 12:45:34 -0400
Received: from zeus.kernel.org ([204.152.189.113]:25048 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261331AbUJZQpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 12:45:19 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Robin Holt <holt@sgi.com>
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Date: Tue, 26 Oct 2004 09:44:21 -0700
User-Agent: KMail/1.7
Cc: Jesse Barnes <jbarnes@sgi.com>, William Lee Irwin III <wli@holomorphy.com>,
       Christoph Lameter <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <200410251940.30574.jbarnes@sgi.com> <20041026143513.GC28391@lnx-holt.americas.sgi.com>
In-Reply-To: <20041026143513.GC28391@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410260944.22003.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 26, 2004 7:35 am, Robin Holt wrote:
> Sorry for being a stickler here, but the BTE is really part of the
> I/O Interface portion of the shub.  That portion has a seperate clock
> frequency from the memory controller (unfortunately slower).  The BTE
> can zero at a slightly slower speed than the processor.  It does, as
> you pointed out, not trash the CPU cache.

I guess I was getting ahead of myself :).  I knew that it was part of the II 
but didn't know it had a slower clock frequency than the MD.

> One other feature of the BTE is it can operate asynchronously from
> the cpu.  This could be used to, during a clock interrupt, schedule
> additional huge page zero filling on multiple nodes at the same time.
> This could result in a huge speed boost on machines that have multiple
> memory only nodes.  That has not been tested thoroughly.  We have done
> considerable testing of the page zero functionality as well as the
> error handling.

Might be worth some additional testing...

Jesse
