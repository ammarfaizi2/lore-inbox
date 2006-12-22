Return-Path: <linux-kernel-owner+w=401wt.eu-S1753130AbWLVWiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbWLVWiK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 17:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbWLVWiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 17:38:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44229 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbWLVWiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 17:38:07 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jean Delvare <khali@linux-fr.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       Alexander van Heukelum <heukelum@fastmail.fm>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221145922.16ee8dd7.khali@linux-fr.org>
	<1166723157.29546.281560884@webmail.messagingengine.com>
	<20061221204408.GA7009@in.ibm.com>
	<20061222090806.3ae56579.khali@linux-fr.org>
	<20061222104056.GB7009@in.ibm.com>
	<20061222232256.f950bfe2.khali@linux-fr.org>
Date: Fri, 22 Dec 2006 15:37:09 -0700
In-Reply-To: <20061222232256.f950bfe2.khali@linux-fr.org> (Jean Delvare's
	message of "Fri, 22 Dec 2006 23:22:56 +0100")
Message-ID: <m1d56blfqi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> Hi Vivek,
>
> On Fri, 22 Dec 2006 16:10:56 +0530, Vivek Goyal wrote:
>> Another odd thing is that "file vmlinux.bin" shows following.
>> 
>> vmlinux.bin: Sendmail frozen configuration - version
> \015\024\322\216\356\222X\2306\032H\220\303\270\006\007\003
>> 
>> I am not sure what does it mean. I had expected it to be a data blob.
>> 
>> "vmlinux.bin: data"
>
> The file command uses heuristics to attempt to identify files. Here a
> random sequence of bytes was simply misinterpreted as something
> completely different. You can tell from the version string which is
> totally broken. So, "file" could be improved to avoid this false
> positive, but that's about it.
>
> Now, what's still relevant is that my vmlinux.bin starts with a
> binary sequence which differs from all other vmlinux.bin files around.
> So it's a hint that it is corrupted, although a deeper analysis will be
> required to figure out how and why.

A simple analysis says vmlinux.bin is created by the linker.  So we
can probably look at why vmlinux.bin gets generated strangely.

I know I touched that path a little bit in my patch.

Eric

