Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263086AbVF3U4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbVF3U4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbVF3U4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:56:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50586 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263088AbVF3Uz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:55:29 -0400
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: linux-kernel@vger.kernel.org, YhLu <YhLu@tyan.com>,
       Andi Kleen <ak@suse.de>, Peter Buckingham <peter@pantasys.com>
Subject: Re: 2.6.12 with dual way dual core ck804 MB
References: <20050630185418.GD7226@plap.qlogic.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 30 Jun 2005 14:54:49 -0600
In-Reply-To: <20050630185418.GD7226@plap.qlogic.org> (Andrew Vasquez's
 message of "Thu, 30 Jun 2005 11:54:18 -0700")
Message-ID: <m1oe9nlg4m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Vasquez <andrew.vasquez@qlogic.com> writes:

>> A couple more tidbits of information on this problem.
>>
>> 1) I have seen this on two different boards
>> a Tyan S4882 and a Arima HDAMA, with and without linuxbios.
>> In just messing around adding "debug" on the kernel command line
>> or changing Dprintk in smpboot.c:smp_callin() to printk,
>> avoids this boot lock up for me.
>
> All,
>
> Has there been any resolution to this problem.  I've just tried
> 2.6.13-rc1 on a Dell PowerEdge 2850 (dual-proc em64t) and am running
> into what appears to be a similar case where cpu initialization never
> completes.  I'll attach my .config, boot-up messages, and the output
> of lspci.
>
> I've also tried the s/Dprintk/printk/ hack with no success.

I can confirm that I am seeing this on Xeons as well with my problem
2.6.12 kernel.  And specifying debug does cause it to go away, for me.

As for which debug messages cause the bug not to be trigger I am
logging to the serial console which may be part of the difference.

Eric
