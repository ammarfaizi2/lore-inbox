Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWHNULd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWHNULd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWHNULd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:11:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55194 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932689AbWHNULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:11:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: vgoyal@in.ibm.com, Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060809200642.GD7861@redhat.com>
	<m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
	<20060810131323.GB9888@in.ibm.com>
	<m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
	<20060810181825.GD14732@in.ibm.com>
	<m1irl01hex.fsf@ebiederm.dsl.xmission.com>
	<20060814165150.GA2519@in.ibm.com> <44E0AD1D.1040408@zytor.com>
	<20060814181118.GB2519@in.ibm.com> <44E0CFD0.3060506@zytor.com>
	<20060814194252.GC2519@in.ibm.com> <44E0D2DB.7030003@zytor.com>
Date: Mon, 14 Aug 2006 14:10:51 -0600
In-Reply-To: <44E0D2DB.7030003@zytor.com> (H. Peter Anvin's message of "Mon,
	14 Aug 2006 12:45:31 -0700")
Message-ID: <m18xlrt6wk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Vivek Goyal wrote:
>>>>
>>> What about once the kernel is booted?
>> Sorry did not understand the question. Few more lines will help.
>>
>
> Is this field intended to protect any kind of memory during the early boot phase
> of the kernel proper, or only the decompressor?

Yes, the field should account for memory usage until the kernel starts
doing the accounting at run time.

I'm actually surprised that taking into account the .bss was not enough to
cover up anything the decompressor was doing.  Usually the kernel's .bss
is more than the extra 32K or so that the decompressor uses.

Eric
