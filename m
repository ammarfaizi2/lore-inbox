Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVLIC43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVLIC43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 21:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVLIC43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 21:56:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:54689 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751246AbVLIC42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 21:56:28 -0500
Date: Fri, 9 Dec 2005 08:26:54 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
Message-ID: <20051209025654.GA29806@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <439889FA.BB08E5E1@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439889FA.BB08E5E1@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 10:31:06PM +0300, Oleg Nesterov wrote:
> I think cpu should call cpu_quiet() after adding itself to nohz mask
> to eliminate this race.

That would require rsp->lock to be taken on every idle CPU that wishes to go
tickless. IMO that may not be a good idea.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
