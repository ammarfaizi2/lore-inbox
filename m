Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVBXTqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVBXTqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVBXTqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:46:55 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:39101 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261899AbVBXTqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:46:52 -0500
Message-ID: <421E2EF9.9010209@nortel.com>
Date: Thu, 24 Feb 2005 13:46:01 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chad N. Tindel" <chad@tindel.net>
CC: Paulo Marques <pmarques@grupopie.com>, Mike Galbraith <EFAULT@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com> <421E2528.8060305@grupopie.com> <20050224192237.GA31894@calma.pair.com>
In-Reply-To: <20050224192237.GA31894@calma.pair.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad N. Tindel wrote:

>>I personally like the linux way: "root has the ability to shoot himself 
>>in the foot if he wants to". This is my computer, damn it, I am the one 
>>who tells it what to do.

> I'm all for allowing people to shoot themselves in the foot.  That doesn't
> mean that it is OK for a single userspace thread to mess up a 64-way box.

If root has explicitly stated that the thread in question is the highest 
priority thing on the entire machine, why would it not be okay.  The 
fact that root made a mistake is the issue here, not that the system 
didn't protect itself.

>>This is much, much better than the "users are stupid, we must protect 
>>them from themselves" kind of way that other OS'es use.

> Isn't this what the kernel attempts to do in many other places?  What else
> could possibly be the point of sending SIGSEGV and causing applications
> to dump core when they make a mistake referencing memory?  Isn't it the
> kernel's job to protect one application from another?

Yes.  But at the same time, if root wants to do something, the kernel 
should let them.  There are many, many ways that root could trash the 
system.  "cat /dev/urandom > /dev/kcore"  would do quite nicely.

> I see what you're saying about the swap daemon.  How about if I make my
> statement less black and white.  Some kernel threads should always have 
> priority over userspace.

Not necessarily.  The latest latency-reduction patches allow root to 
specify exactly what the priorities should be.

> I believe the mindset required for a home system that is doing audio recordings
> is different than the one for enterprise-level systems.  How do we unify
> the two?

There are professionals who use linux for audio as well, it's not just 
home systems.  That said, you unify them with reasonable defaults, and 
the ability for root to override them.

Chris

