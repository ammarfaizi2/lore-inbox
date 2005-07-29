Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVG2G17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVG2G17 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 02:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVG2G16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 02:27:58 -0400
Received: from fmr21.intel.com ([143.183.121.13]:30646 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262462AbVG2G15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 02:27:57 -0400
Message-Id: <200507290627.j6T6Rrg06842@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Date: Thu, 28 Jul 2005 23:27:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWT4WnYrq021CGOREqulHpDwY9eTwAI0ZfA
In-Reply-To: <42E98DEA.9090606@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, July 28, 2005 7:01 PM
> Chen, Kenneth W wrote:
> >Well, that's exactly what I'm trying to do: make them not aggressive
> >at all by not performing any load balance :-)  The workload gets maximum
> >benefit with zero aggressiveness.
> 
> Unfortunately we can't forget about other workloads, and we're
> trying to stay away from runtime tunables in the scheduler.


This clearly outlines an issue with the implementation.  Optimize for one
type of workload has detrimental effect on another workload and vice versa.


> If we can get performance to within a couple of tenths of a percent
> of the zero balancing case, then that would be preferable I think.

I won't try to compromise between the two.  If you do so, we would end up
with two half baked raw turkey.  Making less aggressive load balance in the
wake up path would probably reduce performance for the type of workload you
quoted earlier and for db workload, we don't want any of them at all, not
even the code to determine whether it should be balanced or not.

Do you have an example workload you mentioned earlier that depends on
SD_WAKE_BALANCE?  I would like to experiment with it so we can move this
forward instead of paper talk.

- Ken

