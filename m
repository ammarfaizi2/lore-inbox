Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWFBNUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWFBNUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWFBNUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:20:40 -0400
Received: from mailgw4.ericsson.se ([193.180.251.62]:9349 "EHLO
	mailgw4.ericsson.se") by vger.kernel.org with ESMTP
	id S1750755AbWFBNUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:20:40 -0400
Message-ID: <44803B1F.8070302@ericsson.com>
Date: Fri, 02 Jun 2006 15:20:31 +0200
From: Preben Traerup <Preben.Trarup@ericsson.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>	<20060530145658.GC6536@in.ibm.com>	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>	<20060531154322.GA8475@in.ibm.com>	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>	<20060601151605.GA7380@in.ibm.com>	<20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>	<44800E1A.1080306@ericsson.com> <m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2006 13:20:38.0388 (UTC) FILETIME=[56CF8B40:01C68647]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>
>You can put anything you want for crash_kexec to execute.
>
>If the problem is strictly limited to hardware failure and software
>can cope with that then don't panic the kernel and execute an orderly
>transition.
>
>If software cannot cope, and must panic the kernel it clearly cannot
>do something sensible.
>
>Eric
>
>  
>

Something like out of memory and oops-es are enough to deeme the system 
must panic
because it is simply not supposed to happen in a Telco server at any time.

kdump helps debugging these cases, but more importantly another server
must take over the work, and this has and always will have highest priority.

I'm happy about what crash_kexec does today, but the timing issue makes 
it unusable for
notifications to external systems, if I need to wait until properly 
running in next kernel.

That leaves me the choice of doing notification before executing 
crash_kexec ?
Since I'm apperantly not the only one left with this choice I rather 
prefer a solution
made in public, that is known to be "bad" in some (well known) 
situations than
each and everybody implements their own solution to the same problem.

./Preben
