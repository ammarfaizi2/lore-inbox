Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUATHpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 02:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUATHpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 02:45:43 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:11914 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265168AbUATHpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 02:45:41 -0500
Message-ID: <400CDCA1.5070200@cyberone.com.au>
Date: Tue, 20 Jan 2004 18:45:37 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Rusty Russell <rusty@au1.ibm.com>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com> <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org>
In-Reply-To: <20040120073032.GB12638@hockin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim Hockin wrote:

>On Tue, Jan 20, 2004 at 06:11:49PM +1100, Nick Piggin wrote:
>
>>I thought hotplug is allowed to fail? Thus you can have a hung system.
>>Or what if the hotplug script itself becomes TASK_UNRUNNABLE? What if the
>>process needs a guaranteed scheduling latency?
>>
>
>I guess a hotplug script MAY fail.  I don't think it's a good idea to make
>your CPU hotplug script fail.  May and Misght are different.  It's up to the
>implementor whether the script can get into a failure condition.
>

Sorry bad wording. The script may fail to be executed.

>
>The hotplug script can only become unrunnable if you yank out all the CPUs
>on the system.  I'd assume it would have an affinity of 0xffffffff.
>

OK I guess thats not such a valid concern

>
>What if <which> process needs guaranteed scheduling latency?  Do we really
>_guarantee_ scheduling latency *anywhere*?
>
>

We do guarantee that a realtime task won't be blocked waiting for
a hotplug script to fault in and start it up again (which may not
happen). Not sure how important this issue is.


