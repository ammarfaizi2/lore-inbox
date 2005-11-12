Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVKLGkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVKLGkz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 01:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVKLGkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 01:40:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19871 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932176AbVKLGkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 01:40:55 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: i386-vmlinuxldss-distinguish-absolute-symbols.patch added to
 -mm tree
References: <200507292019.j6TKJvXU019348@shell0.pdx.osdl.net>
	<2cd57c900511112203t3ea031ccq@mail.gmail.com>
	<20051111222627.24cf41f7.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 11 Nov 2005 23:40:05 -0700
In-Reply-To: <20051111222627.24cf41f7.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 11 Nov 2005 22:26:27 -0800")
Message-ID: <m1wtjenzcq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Coywolf Qi Hunt <coywolf@gmail.com> wrote:
>>
>> I wonder why this patch
>>  (i386-vmlinuxldss-distinguish-absolute-symbols.patch) isn't merged?
>
> Sam said scary things about it at the time but yes, it seems that things
> ended up OK.
>
> But Eric hasn't come back with the patch (>3 months) so perhaps its not
> very important, or is unneeded?

Mostly this is a piece of making the kernel relocatable, and I
have been holding off on that set of patches until I can get
the rest of the patches I have worked on for kexec on panic
merged.

I can only track so many bug reports at a time :)

This patch stands by itself so it should not be a problem.

One of the things I discovered when working with this patch is
that ld when can't actually cope with absolute symbols in a shared
library and will try and relocate them anyway.  I have code in my
tree that works around that particular ld bug but it is nowhere near
as nice as just specifying -shared when linking.  This patch is indeed
needed for that.

Eric
