Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWBYNf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWBYNf1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWBYNf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:35:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21682 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030250AbWBYNf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:35:26 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] proc cleanup.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<20060225042757.1442ee2c.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 25 Feb 2006 06:34:08 -0700
In-Reply-To: <20060225042757.1442ee2c.akpm@osdl.org> (Andrew Morton's
 message of "Sat, 25 Feb 2006 04:27:57 -0800")
Message-ID: <m1d5hb36lr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> When working on pid namespaces I keep tripping over /proc.
>>  It's hard coded inode numbers and the amount of cruft
>>  accumulated over the years makes it hard to deal with.
>> 
>>  So to put /proc out of my misery here is a series of patches that
>>  removes the worst of the warts.
>
> An additional 2.7k of vmlinux.  A shame.

Yes.  I guess so.

You want me to run the bloat-o-meter and see
if I can see where the size increase comes from?

Looking at the diffstat there was barely a code size
increase.

 fs/exec.c                 |    9
 fs/proc/base.c            | 2374 ++++++++++++++++++++++------------------------
 fs/proc/inode.c           |   11
 fs/proc/internal.h        |   23
 fs/proc/root.c            |   13
 fs/proc/task_mmu.c        |  101 +
 fs/proc/task_nommu.c      |   21
 include/linux/init_task.h |    1
 include/linux/pid.h       |    4
 include/linux/proc_fs.h   |   26
 include/linux/sched.h     |    3
 include/linux/task_ref.h  |   69 +
 kernel/Makefile           |    2
 kernel/exit.c             |   12
 kernel/fork.c             |   10
 kernel/pid.c              |   12
 kernel/task_ref.c         |  131 ++
 mm/mempolicy.c            |    6
 18 files changed, 1533 insertions(+), 1295 deletions(-)


Eric





