Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTEPXTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTEPXTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:19:31 -0400
Received: from mail.gmx.net ([213.165.65.60]:36219 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263718AbTEPXT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:19:29 -0400
Message-ID: <3EC574FB.1030500@gmx.net>
Date: Sat, 17 May 2003 01:32:11 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Mark Hindley <mark@hindley.uklinux.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 oops
References: <20030515070555.GA1589@titan.home.hindley.uklinux.net> <3EC3C6E0.6000300@gmx.net> <20030515201649.GA8661@hindley.uklinux.net>
In-Reply-To: <20030515201649.GA8661@hindley.uklinux.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hindley wrote:
> On Thu, May 15, 2003 at 06:57:04PM +0200, Carl-Daniel Hailfinger wrote:
> 
>>Yes. Do you have APM/ACPI enabled in the kernel? Could you supply your
>>.config? Have you tried with 2.4.21-rc2?
>>
> 
> No APM or ACPI. config is below. I haven't tried the latest rc2 - is this something you think has been fixed?

Not necessarily. But you could be lucky. If we know that you are
triggering a genuine bug (not faulty hardware or NVidia driver) in a
Release Candidate kernel, you might get some more attention on the list.
If you manage to reproduce the bug with 2.4.21-rc2, please change the
subject to reflect that.

>>>May 14 18:22:23 titan kernel: EIP:    0010:[kfree+63/180]    Tainted: P 
>>
>>Do you have any proprietary modules loaded, and if so, which ones? Can
>>you reproduce the hang without this module loaded?
>>
> 
> Sorry -- should have mentioned this. nVidia module version 1.0.3123.
> Built on the same system. Still get random crashes without it, but less
> often (? lower load without X runing)

Did I understand you correctly that the crashes also happen when the
module is not loaded at all? (Even loading a module once can wreak
havoc, even if you remove it subsequently.) If so, could you please post
another Oops of an untainted kernel? (Most developers here will simply
ignore Oopsen with a tainted kernel.)

Do the crashes happen when the machine has high load or when it's idle
or are they not related to load at all? Does it happen more often at
night, when your room is hot, when somebody starts the washing machine,
etc... Do you see any pattern at all?
Depending on the pattern, we might be able to make an educated guess
what the problem is. Don't laugh, I've fixed quite a few bugs once the
pattern was clear (most of them hardware related, though).

> Thanks for your help
> 
> Mark
> 
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SPINLOCK is not set
> CONFIG_FRAME_POINTER=y

Could you please enable all debugging options in the "Kernel hacking"
menu? The machine may run slower, but if it helps us getting your
problem fixed, it is worth it. Enabling software watchdog might also
help, but I'm not so sure about that.


HTH,
Carl-Daniel
-- 
http://www.hailfinger.org/

