Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWBGPSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWBGPSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWBGPSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:18:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16013 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751116AbWBGPSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:18:21 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 03/20] pid: Introduce a generic helper to test for
 init.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.62.0602071607220.17769@pademelon.sonytel.be>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 08:17:28 -0700
In-Reply-To: <Pine.LNX.4.62.0602071607220.17769@pademelon.sonytel.be> (Geert
 Uytterhoeven's message of "Tue, 7 Feb 2006 16:08:00 +0100 (CET)")
Message-ID: <m1r76ffbav.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Mon, 6 Feb 2006, Eric W. Biederman wrote:
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -894,6 +894,19 @@ static inline int pid_alive(struct task_
>>  	return p->pids[PIDTYPE_PID].nr != 0;
>>  }
>>  
>> +/**
>> + * is_init - check if a task structure is the first user space
>> + *	     task the kernel created.
>> + * @p: Task structure to be checked.
>        ^
>> + */
>> +static inline int is_init(struct task_struct *tsk)
>                                                  ^^^

Thanks.  The perils of cut & past documentation!

Eric
