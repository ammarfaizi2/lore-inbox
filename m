Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWDKHhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWDKHhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWDKHhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:37:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7555 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932138AbWDKHhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:37:37 -0400
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
References: <20060406220403.GA205@oleg>
	<200604110152.38861.ioe-lkml@rameria.de> <20060411101923.GB112@oleg>
	<200604110925.08685.ioe-lkml@rameria.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 11 Apr 2006 01:36:13 -0600
In-Reply-To: <200604110925.08685.ioe-lkml@rameria.de> (Ingo Oeser's message
 of "Tue, 11 Apr 2006 09:25:07 +0200")
Message-ID: <m11ww4d0nm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> writes:

> On Tuesday, 11. April 2006 12:19, Oleg Nesterov wrote:
>> On 04/11, Ingo Oeser wrote:
>> >
>> > While you are at it: Could you please avoid calculating current over 
>> > and over again? 
>> > 
>> > Just calculate it once and use the task_struct pointer.
>> 
>> Ironically, de_thread() has 'tsk' parameter which is equal to 'current'.
>
> That's the thing that made me doubt :-)
>
> But thinking more about it: current cannot change within one thread, 
> right? So all of this can be cleaned up.
>
> I'll clean them up tonight and sent out a patch against current -mm.

Please skip de_thread.  I will catch that one, in a minute.  There is
enough churn on that function that you are likely to patch the wrong
version.

Eric
