Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWHBCNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWHBCNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWHBCNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:13:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27092 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751038AbWHBCNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:13:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 18/33] x86_64: Kill temp_boot_pmds II
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302392378-git-send-email-ebiederm@xmission.com>
	<p73psfk1dnh.fsf_-_@verdi.suse.de>
Date: Tue, 01 Aug 2006 20:11:48 -0600
In-Reply-To: <p73psfk1dnh.fsf_-_@verdi.suse.de> (Andi Kleen's message of "01
	Aug 2006 21:04:02 +0200")
Message-ID: <m18xm7yjh7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>> 
>> I also modify the early page table initialization code
>> to use early_ioreamp and early_iounmap, instead of the
>> special case version of those functions that they are
>> now calling.
>
> Or rather I tried to apply it - it doesn't apply at all
> on its own:
>
> patching file arch/x86_64/mm/init.c
> Hunk #1 FAILED at 167.
> Hunk #2 succeeded at 274 with fuzz 1 (offset 28 lines).
> Hunk #3 FAILED at 286.
> Hunk #4 FAILED at 341.
> 3 out of 4 hunks FAILED -- rejects in file arch/x86_64/mm/init.c

It is probably patch 17:
"x86_64: Separate normal memory map initialization from the hotplug case"

I don't see any other patches that touch arch/x86_64/mm/init.c
before that.  At least not in 2.6.18-rc3, which is the base of
my patchset.

Eric
