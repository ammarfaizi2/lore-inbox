Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUABXrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbUABXrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:47:06 -0500
Received: from firewall.conet.cz ([213.175.54.250]:61340 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262078AbUABXrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:47:03 -0500
Message-ID: <3FF602C9.4080100@conet.cz>
Date: Sat, 03 Jan 2004 00:46:17 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
References: <3FF56B1C.1040308@conet.cz> <20040102233542.GW28023@krispykreme>
In-Reply-To: <20040102233542.GW28023@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I'm writing some project which needs to hijack some syscalls in VFS 
>>layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
>>some very nasty ways of doing it - see 
>>http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )
> 
> 
> And it will fail miserably on many non x86 architectures for
> various reasons:
> 
> 1. ppc64 and ia64 use function descriptors
> 2. sparc64 uses a 32bit call out table
> 
> In short its not only an awful hack, its horribly non portable :)

But in short you always get some syscall from userspace and have some table with function vectors assigned to each syscall, don't you?

So you can have something like "append_this_function_before_syscall_sys_open" and "append_this_function_after_syscall_sys_open" which would be platform independent but will have platform dependent implementation.


-- 

Libor Vanek

