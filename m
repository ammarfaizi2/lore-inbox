Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVFMVyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVFMVyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFMVxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 17:53:22 -0400
Received: from opersys.com ([64.40.108.71]:45581 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261436AbVFMVuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:50:05 -0400
Message-ID: <42AE01EA.10905@opersys.com>
Date: Mon, 13 Jun 2005 18:00:10 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: dwalker@mvista.com
CC: paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050610223724.GA20853@nietzsche.lynx.com>	 <20050610225231.GF6564@g5.random>	 <20050610230836.GD21618@nietzsche.lynx.com>	 <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com>	 <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com>	 <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com>	 <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com>	 <42ADE334.4030002@opersys.com>	 <1118693033.2725.21.camel@dhcp153.mvista.com>	 <42ADEC0E.4020907@opersys.com> <1118694495.2725.32.camel@dhcp153.mvista.com>
In-Reply-To: <1118694495.2725.32.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Walker wrote:
> I wouldn't work on RT if mainline integration wasn't on the agenda. 

Mainline integration IS what I'm talking about. It's just not done
the same way.

> There is going to be positive , and negative discussion on this. I think
> in the end the maintainers (Linus, and Andrew) don't want "people" to
> get a patch or modification from the outside. It's best if the community
> is not separated .. If you make a clean integration , and people want
> what you are doing, there is no reason for it to be rejected.

I'm not suggesting the separation of the community, I'm suggesting
a strategy of integration based on the fact that a large portion of
kernel contributors don't necessarily care about RT, and most don't
want to care about it in their day-to-day work (though I think most
would care that Linux could have an additional spade down its
sleeve, and would certainly try to help in as much they can from
time to time.)

I'm not suggesting asking "people" to get patches from the outside.
What I'm saying is that those developing mainstream code shouldn't
need to worry about anything real-time, including modifications to
locking primitives in headers (be they defined out or in).

In essence, what you ask can only hold if all kernel developers
intend for Linux to become QNX. Clearly this isn't going to happen.
Whatever changes are made to such core functionality as locking
primitives and interrupt handling can hardly be "transparent"
simply by wrapping #ifdef CONFIG_X around it in mainstream headers.

>From my point of view, determinism and best overall performance are
conflicting goals. Having separate derectories for something as
fundamentally different from best overall performance as determinism
is not too much to ask.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
