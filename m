Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934218AbWKYXJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934218AbWKYXJl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 18:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934641AbWKYXJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 18:09:41 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:55459 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S934218AbWKYXJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 18:09:40 -0500
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
X-Message-Flag: Warning: May contain useful information
References: <adazmag5bk1.fsf@cisco.com>
	<20061124.220746.57445336.davem@davemloft.net>
	<adaodqv5e5l.fsf@cisco.com>
	<20061125.150500.14841768.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 25 Nov 2006 15:09:38 -0800
In-Reply-To: <20061125.150500.14841768.davem@davemloft.net> (David Miller's message of "Sat, 25 Nov 2006 15:05:00 -0800 (PST)")
Message-ID: <adak61j5djh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Nov 2006 23:09:39.0231 (UTC) FILETIME=[C84C3AF0:01C710E6]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > You would need to also cast the constants with typeof() to.

Why?  I'm not much of a C language lawyer, but I would have thought
that in something like

	(x) + _a - 1

the "1" will be promoted to the type of the rest of the expression
without any explicit cast.  I tested the unsigned long/unsigned int
and u64/int cases of ALIGN(), and my macro with typeof() works for
both of those cases at least.

 > But yes, given the array sizing case in the neighbour code,
 > perhaps we can use your original patch for now.  Feel free
 > to push that to Linus.

akpm is CC'ed on this thread.  Andrew, are you going to pick this up?

Thanks,
  Roland
