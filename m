Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbRGPQQF>; Mon, 16 Jul 2001 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267451AbRGPQPz>; Mon, 16 Jul 2001 12:15:55 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:58080 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267449AbRGPQPp>; Mon, 16 Jul 2001 12:15:45 -0400
Date: Mon, 16 Jul 2001 09:14:46 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: CPU affinity & IPI latency
Message-ID: <20010716091446.B1186@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <OFBCDBFC1D.BD7BBF9C-ON85256A89.000F6AC1@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFBCDBFC1D.BD7BBF9C-ON85256A89.000F6AC1@pok.ibm.com>; from frankeh@us.ibm.com on Fri, Jul 13, 2001 at 11:25:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 11:25:21PM -0400, Hubertus Franke wrote:
> 
> Mike, could we utilize the existing mechanism such as has_cpu.
> 

I like it.  Especially the way you eliminated the situation where
we would have multiple tasks waiting for schedule.  Hope this is
not a frequent situation!!!  The only thing I don't like is the
use of has_cpu to prevent the task from being scheduled.  Right
now, I can't think of any problems with it.  However, in the past
I have been bit by using fields for purposes other than what they
were designed for.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
