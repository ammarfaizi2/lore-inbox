Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271346AbUJVPT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271346AbUJVPT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbUJVPT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:19:26 -0400
Received: from darwin.snarc.org ([81.56.210.228]:54971 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S271346AbUJVPTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:19:11 -0400
Date: Fri, 22 Oct 2004 17:19:07 +0200
To: Fabiano Ramos <fabiano.ramos@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: pid offset into task structre
Message-ID: <20041022151907.GA6209@snarc.org>
References: <5afb2c65041021163441c1e1b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5afb2c65041021163441c1e1b4@mail.gmail.com>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040907i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 09:34:48PM -0200, Fabiano Ramos wrote:
> Hi All. Some newbie question.
>     1) Considering that I provided the correct value in PID_OFFSET, will
> ebx contain the pid of the task that issued the syscall, at the end of the
> fragment?

yes

>    2)  By taking some address arithmetic (&tsk.pid - &tsk) I got 144.  Is this
> offset always the same? Is that an easy way to get it directly from
> assembly code?

Generate it from arch/$ARCH/kernel/asm-offset.c with the same mecanism that
TI_task uses.

something like:

	OFFSET(TASK_pid, task_struct, pid);

-- 
Tab
