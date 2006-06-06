Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWFFJgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWFFJgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWFFJgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:36:22 -0400
Received: from mailgw3.ericsson.se ([193.180.251.60]:6376 "EHLO
	mailgw3.ericsson.se") by vger.kernel.org with ESMTP id S932139AbWFFJgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:36:21 -0400
Message-ID: <44854C8D.6040707@ericsson.com>
Date: Tue, 06 Jun 2006 11:36:13 +0200
From: Preben Traerup <Preben.Trarup@ericsson.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>	<20060530145658.GC6536@in.ibm.com>	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>	<20060531154322.GA8475@in.ibm.com>	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>	<20060601151605.GA7380@in.ibm.com>	<20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>	<44800E1A.1080306@ericsson.com>	<m1fyin6agv.fsf@ebiederm.dsl.xmission.com>	<44803B1F.8070302@ericsson.com> <m13ben60tn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13ben60tn.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2006 09:36:19.0648 (UTC) FILETIME=[AA6DCC00:01C6894C]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>Preben Traerup <Preben.Trarup@ericsson.com> writes:
>
>  
>
>  
>
>>Since I'm apperantly not the only one left with this choice I rather prefer a
>>solution
>>made in public, that is known to be "bad" in some (well known) situations than
>>each and everybody implements their own solution to the same problem.
>>    
>>
>
>It is certainly worth discussing.
>
>Eric
>
>  
>
To handle the contradiction of adding crash notifier to kexec and 
maintaining kexec reliability
I suggest adding a flag to Kconfig
ENABLE_CRASH_NOTIFIER

This removes any code in the critical path for people not needing crash 
notification.

Whatever could/should be implemented under this flag, see elsewhere in 
this thread

./Preben
