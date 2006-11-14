Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966382AbWKNVix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966382AbWKNVix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966383AbWKNVix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:38:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27820 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S966382AbWKNViw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:38:52 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Pavel Machek <pavel@suse.cz>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org, ak@suse.de,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
References: <20061113162135.GA17429@in.ibm.com>
	<20061113164314.GK17429@in.ibm.com> <20061114163002.GB4445@ucw.cz>
Date: Tue, 14 Nov 2006 14:36:35 -0700
In-Reply-To: <20061114163002.GB4445@ucw.cz> (Pavel Machek's message of "Tue,
	14 Nov 2006 16:30:03 +0000")
Message-ID: <m1fyclk8ws.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> - Killed lots of dead code
>> - Improve the cpu sanity checks to verify long mode
>>   is enabled when we wake up.
>> - Removed the need for modifying any existing kernel page table.
>> - Moved wakeup_level4_pgt into the wakeup routine so we can
>>   run the kernel above 4G.
>> - Increased the size of the wakeup routine to 8K.
>> - Renamed the variables to use the 64bit register names.
>> - Lots of misc cleanups to match trampoline.S
>> 
>> I don't have a configuration I can test this but it compiles cleanly
>
> Ugh, now that's a big patch.. and untested, too :-(.

It was very carefully code reviewed at least the first time,
and the code was put in sync with code that was tested.

But things happens so the lack of testing was noted.

> Why is PGE no longer required, for example?

PGE is never required.  Especially on a temporary page table.
PGE is an optimization, to make context switches faster.

> Can we get it piece-by-piece?


>> Vivek has tested this patch for suspend to memory and it works fine.
>
> Ok, so it was tested on one config. Given that the patch deals with
> detecting CPU oddities... :-(

Read the code.  Given your scorn and the state of that mess when I
started I'm not certain a productive conversation can be had.

Do you understand the code as it is currently written?

Eric
