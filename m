Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVISHKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVISHKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVISHKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:10:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40072 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932344AbVISHKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:10:10 -0400
Date: Mon, 19 Sep 2005 12:39:35 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919070935.GA9994@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406> <20050919051024.GA8653@in.ibm.com> <1127107887.3958.9.camel@linux-hp.sh.intel.com> <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost> <20050919062336.GA9466@in.ibm.com> <1127111495.9696.102.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127111495.9696.102.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 04:31:36PM +1000, Nigel Cunningham wrote:
> > -		} while (!need_resched());
> > +		} while (!need_resched() || !cpu_is_offline(cpu));
> 
> Shouldn't this be !need_resched() && !cpu_is_offline(cpu)?

Yes!


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
