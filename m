Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263321AbUJ2NpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbUJ2NpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbUJ2NpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:45:08 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:29835 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S263321AbUJ2No7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:44:59 -0400
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Configurable Magic Sysrq
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
	<20041029024651.1ebadf82.akpm@osdl.org>
	<yw1xu0sdiwr2.fsf@inprovide.com>
	<20041029133527.GA25172@atrey.karlin.mff.cuni.cz>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 29 Oct 2004 15:44:38 +0200
In-Reply-To: <20041029133527.GA25172@atrey.karlin.mff.cuni.cz> (Jan Kara's
 message of "Fri, 29 Oct 2004 15:35:27 +0200")
Message-ID: <yw1xlldpiqpl.fsf@inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

>> Andrew Morton <akpm@osdl.org> writes:
>> 
>> > Jan Kara <jack@suse.cz> wrote:
>> >>
>> >>    I know about a few people who would like to use some functionality of
>> >>  the Magic Sysrq but don't want to enable all the functions it provides.
>> >
>> > That's a new one.  Can you tell us more about why people want to do such a
>> > thing?
>> >
>> >>  So I wrote a patch which should allow them to do so. It allows to
>> >>  configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
>> >>  interface is backward compatible). If you think it's useful then use it :)
>> >>  Andrew, do you think it can go into mainline or it's just an overdesign?
>> >
>> > Patch looks reasonable - we just need to decide whether the requirement
>> > warrants its inclusion.
>> >
>> > There have been a few changes in the sysrq code since 2.6.9 and there are
>> > more changes queued up in -mm.  The patch applies OK, but it'll need
>> > checking and redoing.  There's a new `sysrq-f' command in the pipeline
>> > which causes a manual oom-killer call.
>> 
>> See also the patch I just posted to lkml.
>   OK, Andrew, are you accepting the patch? The sysrq should probably go
> into SYSRQ_ENABLE_SIGNAL group...

Don't miss the update I posted a few minutes later.

>> I also thought of an improved way of selecting keys to enable.
>> Instead of an arbitrary bitmask, would it be possible to simply list
>> the keys you want to enable, such as "echo sku > /proc/sys/kernel/sysrq"?
>   That would be possible of course but you'd have to do your own
> parsing in kernel and you are not supposed to change the sysrq
> setting often - usually just compute your favourite number, put it
> into boot scripts and you're done. So I'm not convinced it's useful
> very much.

I'm not likely to use either of them, so I'll leave it to you.

-- 
Måns Rullgård
mru@inprovide.com
