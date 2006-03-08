Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752003AbWCHESG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbWCHESG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 23:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWCHESG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 23:18:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51168 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752003AbWCHESF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 23:18:05 -0500
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mmlnx@us.ibm.com
Subject: Re: [PATCH] fix kexec asm
References: <200603072135.16116.mason@suse.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Mar 2006 21:16:34 -0700
In-Reply-To: <200603072135.16116.mason@suse.com> (Chris Mason's message of
 "Tue, 7 Mar 2006 21:35:15 -0500")
Message-ID: <m1zmk1y3j1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:

> From: Michael Matz <matz@suse.de>
>
> While testing kexec and kdump we hit problems where the new kernel would
> freeze or instantly reboot.  The easiest way to trigger it was to kexec a
> kernel compiled for CONFIG_M586 on an athlon cpu.  Compiling
> for CONFIG_MK7 instead would work fine.
>
> The patch below fixes a few problems with the kexec inline asm.

Thanks.  Specifying the stomp of %eax in load_segments is definitely
good.  The memory stomp looks excessive and if this was a fast path
I would worry about it.  As it is better safe than sorry.

Acked-By: Eric Biederman <ebiederm@xmission.com>

Eric
