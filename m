Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWKEGwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWKEGwq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWKEGwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:52:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44473 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161166AbWKEGwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:52:45 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@suse.de>, Horms <horms@verge.net.au>,
       "Jan Kratochvil" <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, "Magnus Damm" <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/33] x86_64: Relocatable kernel support
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302483667-git-send-email-ebiederm@xmission.com>
	<p73d5bk1dat.fsf@verdi.suse.de>
	<m1vepbx4aj.fsf@ebiederm.dsl.xmission.com>
	<86802c440611042202l703de80i26931090f2809e74@mail.gmail.com>
Date: Sat, 04 Nov 2006 23:52:03 -0700
In-Reply-To: <86802c440611042202l703de80i26931090f2809e74@mail.gmail.com>
	(Yinghai Lu's message of "Sat, 4 Nov 2006 22:02:14 -0800")
Message-ID: <m1zmb6per0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> On 8/1/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> I guess I could take this in some slightly smaller steps.
>> But this does wind up with decompressor being 64bit code.
>
> Sorry to bring out the old mail.
>
> except reusing the uncompressor in 32bit, is there any reason that you
> removed startup_32 for vmlinux but keep startup_32 for bzImage?
>
> that will make vmlinux use 64bit boot loader only.

If you are booting a vmlinux you read the ELF header.  The ELF header
only describes the native mode.  Therefore no 32bit entry makes much sense.

bzImage is something else entirely.

Eric

