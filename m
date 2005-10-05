Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVJEUCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVJEUCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVJEUCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:02:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17901 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030356AbVJEUCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:02:16 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
References: <m1k6gt8gvt.fsf@ebiederm.dsl.xmission.com>
	<43442E8E.1090301@tmr.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 05 Oct 2005 14:00:48 -0600
In-Reply-To: <43442E8E.1090301@tmr.com> (Bill Davidsen's message of "Wed, 05
 Oct 2005 15:50:38 -0400")
Message-ID: <m164sb7mz3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> Eric W. Biederman wrote:
>> The per cpu nmi watchdog timer is based on an event counter.  idle cpus don't
>> generate events so the NMI watchdog doesn't fire
>> and the test to see if the watchdog is working fails.
>
> Question: given all the concern about reducing clocks and all, do we actually
> need nmi on more than one CPU? Are there cases where a single CPU hangs in idle
> on an SMP system?

I really don't know, but the normal interrupt rate is once per second or slower
if the cpu is idle.  I was just working in the vicinity and discovered when
I enabled the nmi watchdog it failed to come on because it didn't handled it's
initialization test properly, and x86_64 had already fixed it.

Eric
