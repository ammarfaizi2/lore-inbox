Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161450AbWI2VeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161450AbWI2VeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbWI2VeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:34:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35043 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161450AbWI2VeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:34:14 -0400
Date: Fri, 29 Sep 2006 17:34:11 -0400
From: Dave Jones <davej@redhat.com>
To: Larry Woodman <lwoodman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oom kill oddness.
Message-ID: <20060929213411.GG22014@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Larry Woodman <lwoodman@redhat.com>, linux-kernel@vger.kernel.org
References: <451D7C02.2090907@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451D7C02.2090907@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 04:03:14PM -0400, Larry Woodman wrote:
 
 > Dave, this has been a problem since the out_of_memory() function was 
 > changed
 > between 2.6.10 and 2.6.11.  Before this change out_of_memory() required 
 > multiple
 > calls within 5 seconds before actually OOM killed a process.  After the 
 > change(in 2.6.11)
 > a single call to out_of_memory() results in OOM killing a process.  The 
 > following patch
 > allows the 2.6.18 system to run under much more memory pressure before 
 > it OOM kills.

Some of these tests do seem to be readded in Linus' current tree.

[PATCH] oom: don't kill current when another OOM in progress

went in earlier today for eg.
I'm curious why these checks were ever removed in the first place though.

	Dave

