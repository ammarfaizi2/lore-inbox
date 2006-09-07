Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWIGGzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWIGGzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 02:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWIGGzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 02:55:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25490 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750743AbWIGGzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 02:55:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: piet@bluelane.com
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: [PATCH] x86_64 kexec: Remove experimental mark of kexec
References: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com>
	<m1k64hvsru.fsf@ebiederm.dsl.xmission.com>
	<200609062122.14971.ak@suse.de>
	<m1pse8vjjg.fsf@ebiederm.dsl.xmission.com>
	<1157610028.14930.32.camel@piet2.bluelane.com>
Date: Thu, 07 Sep 2006 00:55:03 -0600
In-Reply-To: <1157610028.14930.32.camel@piet2.bluelane.com> (Piet Delaney's
	message of "Wed, 06 Sep 2006 23:20:27 -0700")
Message-ID: <m1ac5crws8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piet Delaney <piet@bluelane.com> writes:

> On Wed, 2006-09-06 at 14:15 -0600, Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>> 
>> > On Wednesday 06 September 2006 18:55, Eric W. Biederman wrote:
>> >> 
>> >> kexec has been marked experimental for a year now and all
>> >> of the serious problems have been worked through.  So it
>> >> is time (if not past time) to remove the experimental mark.
>> >> 
>> >
>> > Hmm, I personally have some doubts it is really not experimental
>> > (not because of the kexec code itself, but because of all the other drivers
>> > that still break)
>> 
>> That is a reasonable viewpoint.  Although by that a lot more of the kernel
>> deserves to be marked experimental. 
>> 
>> On the perverse side of the sentiment taking off experimental may increase
>> our number of testers and get the bugs fixed faster :)
>
> I take it that for using kexec to boot a kdump kernel and then
> rebooting the primary kernel that there are a few drivers in
> the dumping kernel that wouldn't work but they aren't likely
> to be used. Ie: it's "just" a hardware initialization issue
> on kernels booted with kexec.

Yes.  The only place you are likely to observe the driver
initialization problems are kernels booted with kexec.  But there
are other rare scenarios that can yield challenging boot driver
initialization scenarios.   I know soft booting from windows used
to be one of them.

As for the kdump kernel usually you won't load (or build in) any
drivers you don't intend to use.  If the drivers actually get loaded
even if you aren't using them you could have problems.

Eric
