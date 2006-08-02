Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWHBCKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWHBCKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWHBCKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:10:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24276 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751005AbWHBCKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:10:22 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 18/33] x86_64: Kill temp_boot_pmds
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302392378-git-send-email-ebiederm@xmission.com>
	<p73vepc1dqb.fsf@verdi.suse.de>
Date: Tue, 01 Aug 2006 20:08:38 -0600
In-Reply-To: <p73vepc1dqb.fsf@verdi.suse.de> (Andi Kleen's message of "01 Aug
	2006 21:02:20 +0200")
Message-ID: <m1d5bjyjmh.fsf@ebiederm.dsl.xmission.com>
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
> Ok valuable cleanup. I queued that one too.
>
>> The only really silly part left with init_memory_mapping
>> is that find_early_table_space always finds pages below 1M.
>
> I fixed this some time ago - obsolete comment? 

Yes an obsolete comment.  I thought I had rechecked that
but I was skimming to fast.  find_e820_memory certainly
isn't limited to pages below 1M.

Eric
