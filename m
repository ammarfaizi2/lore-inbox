Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030680AbVIBEoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030680AbVIBEoW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbVIBEoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:44:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62919 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030680AbVIBEoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:44:21 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: "Pierre Ossman" <drzeus-list@drzeus.cx>, <ncunningham@cyclades.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Meelis Roos" <mroos@linux.ee>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: reboot vs poweroff
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 01 Sep 2005 22:43:17 -0600
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com> (Len
 Brown's message of "Thu, 1 Sep 2005 14:23:31 -0400")
Message-ID: <m1vf1knkpm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

>  
>>Patch tested and works fine here. You should probably make a 
>>note in the bugzilla so we don't get a conflicting merge
>>from the ACPI folks.
>
> One might also consider that it would be a good idea to
> send patches that break ACPI files to the ACPI maintainer
> and acpi-devel@lists.sourceforge.net before sending them
> to Linus...

My apologies, for bug fixes that are not complete and simply move
where the bug is.  My apologies also for not cc'ing you, I didn't
intend to omit you but it never occurred to me.  The patch was
also 2 lines and obviously correct.

For this round I knew you were on the CC list and deliberately included
you.

My goal for the reboot/halt/suspend/kexec path is to fix it so the
generic code is correct and consistent.  Something it hasn't been for
years creating the affect that a correct bug fix in one place would
break something else. 

Until the reboot paths are correct and consistent things will continue
to break, in weird and unpredictable ways, that will keep us all
hunting weird strange bugs for a long time.  I think the S4 suspend
case is the last code path that needs to be fixed.  It is certainly
the last one I am aware of.

Eric

