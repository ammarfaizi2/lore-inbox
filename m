Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWITBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWITBE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 21:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWITBE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 21:04:57 -0400
Received: from mga07.intel.com ([143.182.124.22]:49005 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750796AbWITBE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 21:04:57 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,187,1157353200"; 
   d="scan'208"; a="119293661:sNHT988085987"
Message-ID: <451093A5.20800@linux.intel.com>
Date: Wed, 20 Sep 2006 09:04:37 +0800
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Ayaz Abdulla <aabdulla@nvidia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] forcedeth: hardirq lockdep warning
References: <1158670522.3278.13.camel@taijtu> <20060919111448.9274c699.akpm@osdl.org>
In-Reply-To: <20060919111448.9274c699.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's "fix deadlock", not "fix lockdep warning".  However it's often the
> case that it's not really deadlockable because (often) the card's IRQ line
> has been disabled.  That appears to be the case in nv_do_nic_poll()'s call
> to nv_nic_irq_tx, for example.
> 

except when it's a shared irq line, then the game rules changed ;)
