Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263698AbTCVRFJ>; Sat, 22 Mar 2003 12:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263699AbTCVRFJ>; Sat, 22 Mar 2003 12:05:09 -0500
Received: from holomorphy.com ([66.224.33.161]:63635 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263698AbTCVRFI>;
	Sat, 22 Mar 2003 12:05:08 -0500
Date: Sat, 22 Mar 2003 09:15:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: BUG: Use after free in detach_pid
Message-ID: <20030322171526.GE30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>
References: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 11:57:15AM -0500, Zwane Mwaikambo wrote:
> EIP is at detach_pid+0x1c/0xf0
> Call Trace:
>  [<c01232ec>] __unhash_process+0x10c/0x170
>  [<c01233dc>] release_task+0x8c/0x200
>  [<c01251cb>] wait_task_zombie+0x15b/0x1c0
>  [<c0125681>] sys_wait4+0x241/0x290
>  [<c011cb10>] default_wake_function+0x0/0x20
>  [<c011cb10>] default_wake_function+0x0/0x20
>  [<c0109477>] syscall_call+0x7/0xb

This is highly unusual. I know of what I believe to be most of the
outstanding bugs in pgcl and none are of this form.

I'm hoping manfred's analysis will turn up something; I can chase this,
but he seems to have good leads already.


-- wli
