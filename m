Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbVAQUZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbVAQUZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVAQUZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:25:48 -0500
Received: from opersys.com ([64.40.108.71]:43528 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262870AbVAQUZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:25:39 -0500
Message-ID: <41EC20FB.9030506@opersys.com>
Date: Mon, 17 Jan 2005 15:32:59 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>	 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>	 <41E7A7A6.3060502@opersys.com>	 <Pine.LNX.4.61.0501141626310.6118@scrub.home>	 <41E8358A.4030908@opersys.com>	 <Pine.LNX.4.61.0501150101010.30794@scrub.home>	 <41E899AC.3070705@opersys.com>	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>	 <41EA0307.6020807@opersys.com>	 <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com>	 <1105925842.13265.364.camel@tglx.tec.linutronix.de>	 <41EB21C2.3020608@opersys.com> <1105964417.13265.406.camel@tglx.tec.linutronix.de>
In-Reply-To: <1105964417.13265.406.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner wrote:
> Sorting out disabled events is the filtering you have to do in kernel
> and you should do it in the hot path or remove the unneccecary
> tracepoints at compiletime. 

Do you actually read my replies or do you just grep for something
you can object to? If you care to read my replies you will see that
this has already been answered.

> You are not answering my argument. 8MB/sec is an event frequency of
> 128hz when we assume 64byte/event. It's one event every 8us. So every
> unneccecary computation, every leaving the hotpath for nothing is just
> giving you performance loss.

I have, you just choose not to read. Here's what I said earlier:
> Note, however, that we are thinking of dropping the lockless scheme
> for now. We will pick up this discussion separately further down the
> road.

IOW, we will be using cli/sti. So there is no "leaving the hotpath".

> I said:
> 
>>>Sorting out disabled events in the hot path 
> 
> 
> s/Sorting/Filtering/
> 
> I never said this should not be done.

You're either on crack or I don't know how to read english. Here's what
you said:
> Sorting out disabled events in the hot path and moving the if
> (pid/gid/grp) whatever stuff into userspace postprocessing is not an
> alien request.

Clearly you are suggesting to moving the filtering into user-space.

> Seperating layers as I suggested before is not making it a generic
> debugging tool. It makes parts of those layers available for other usage
> and gives us the chance to reuse the parts for cleaning up already
> available code which has the same hardwired structure.

This has already been answered.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
