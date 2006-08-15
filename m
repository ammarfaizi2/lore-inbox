Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbWHOTEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbWHOTEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWHOTEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:04:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30180 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030457AbWHOTEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:04:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH 1/7] pid: Implement access helpers for a tacks various process groups.
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<11556661922952-git-send-email-ebiederm@xmission.com>
	<1155667238.12700.58.camel@localhost.localdomain>
Date: Tue, 15 Aug 2006 13:03:50 -0600
In-Reply-To: <1155667238.12700.58.camel@localhost.localdomain> (Dave Hansen's
	message of "Tue, 15 Aug 2006 11:40:38 -0700")
Message-ID: <m1lkpp7re1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Tue, 2006-08-15 at 12:23 -0600, Eric W. Biederman wrote:
>> +static inline struct pid *task_pid(struct task_struct *task)
>> +{
>> +       return task->pids[PIDTYPE_PID].pid;
>> +} 
>
> Does this mean we can start to deprecate the use of tsk->pid?

Good question.  I think there are enough users in the same process
case that it might not make sense to get rid of tsk->pid.  Some
of tsk->pids cousins though like tgid are definitely up for grabs.

I haven't gotten far enough to be able to say for certain.

Eric
