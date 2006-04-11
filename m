Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWDKGTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWDKGTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 02:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWDKGTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 02:19:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23938 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932218AbWDKGTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 02:19:20 -0400
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
References: <20060406220403.GA205@oleg>
	<m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u091dnry.fsf@ebiederm.dsl.xmission.com>
	<200604110152.38861.ioe-lkml@rameria.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 11 Apr 2006 00:18:00 -0600
In-Reply-To: <200604110152.38861.ioe-lkml@rameria.de> (Ingo Oeser's message
 of "Tue, 11 Apr 2006 01:52:37 +0200")
Message-ID: <m1d5foeiuf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

> Hi Eric,
>
> On Tuesday, 11. April 2006 01:16, you wrote:
>> I can't seem to send out a correct patch out today with out
>> sending it twice.  I accidently grabbed my old version
>> that sent to many arguments to detach_pid and so would not
>> compile.  Oops.
>
> While you are at it: Could you please avoid calculating current over 
> and over again? 
>
> Just calculate it once and use the task_struct pointer.
>
> If I do this for some random occurances of "current" in fs/exec.c I get this
> on Linus' latest git tree:
>
>    text    data     bss     dec     hex filename
>    9501      84      12    9597    257d old/fs/exec.o
>    9386      84      12    9482    250a new/fs/exec.o
>
> Do you see any side effects, except reduced size 
> and increased performance here?

Not that I know of.  I was cleaning up pids and signaling and wound
up in fixing de_thread.  It is just an ugly beast.

> Is a patch doing this for the whole file welcome, if you are too busy?

I could probably spare a couple of minutes to help review such a patch.
Beyond de_thread I'm to busy to write such a patch.

Eric
