Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUHRAMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUHRAMS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268530AbUHRAMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:12:17 -0400
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:15082 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S268527AbUHRAMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:12:12 -0400
Message-ID: <41229ED8.3050304@bigpond.net.au>
Date: Wed, 18 Aug 2004 10:12:08 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spaminos-ker@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
 others)
References: <20040817231942.95635.qmail@web13903.mail.yahoo.com>
In-Reply-To: <20040817231942.95635.qmail@web13903.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spaminos-ker@yahoo.com wrote:
> I tried the actual server with a stress test, and I do eventually get timeouts.
> 
> I tried with what seemed to be the best setup earlier:
> pb mode
> max_ia_bonus set to 0
> 
> I tried several values for base_promotion_interval but the system eventually
> times out after a few hours (it's still better than it used to be, with a stock
> kernel, it timeouts in less than an hour).

Could you try it in "pb" mode with both max_ia_bonus and max_tpt_bonus 
set to zero?  That will disable all "priority" fiddling and tasks should 
just round robin at a priority determined solely by their "nice" value 
and since (according to your earlier mail) all the daemons have the same 
"nice" value they should just round robin with each other.

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

