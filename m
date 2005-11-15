Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVKOD2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVKOD2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKOD2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:28:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43475 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932303AbVKOD23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:28:29 -0500
Date: Mon, 14 Nov 2005 22:28:19 -0500
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051115032819.GA5620@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>,
	Robert Hancock <hancockr@shaw.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it> <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it> <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca> <1132020468.27215.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132020468.27215.25.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 09:07:48PM -0500, Lee Revell wrote:
 > On Mon, 2005-11-14 at 19:02 -0600, Robert Hancock wrote:
 > > Giridhar Pemmasani wrote:
 > > > Shouldn't I have to prevent scheduler from changing the tasks when executing
 > > > Windows code? Otherwise, kernel gets wrong current thread information,
 > > > which is based on stack pointer. This is the stumbling block for implementing
 > > > private stacks.
 > > 
 > > As long as preemption is disabled when the driver code is executing
 > 
 > Um, but it's really really bad for drivers to do that.

And loading Windows drivers into the kernel isn't ?
I think we're already in no-mans land here.

Remember, we have no clue what those drivers are even doing.
Preemption is the least of its problems.

		Dave

