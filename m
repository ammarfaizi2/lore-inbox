Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268459AbUHLIL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268459AbUHLIL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 04:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268460AbUHLILZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 04:11:25 -0400
Received: from holomorphy.com ([207.189.100.168]:24970 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268459AbUHLILM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 04:11:12 -0400
Date: Thu, 12 Aug 2004 01:11:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040812081102.GK11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org> <23701.1092268910@ocs3.ocs.com.au> <20040812010115.GY11200@holomorphy.com> <Pine.LNX.4.58.0408112133470.2544@montezuma.fsmlabs.com> <20040812020424.GB11200@holomorphy.com> <20040812072058.GH11200@holomorphy.com> <Pine.LNX.4.58.0408120401010.2544@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408120401010.2544@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, William Lee Irwin III wrote:
>> Okay, the results on 2.6.8-rc4 (COOL had a bit of porting, basically
>> dropping the hunks associated with spin_lock_flags_string or whatever
>> it is). Chose the .config largely to be vaguely deterministic, but had
>> to nuke the "System is too big" check in arch/x86_64/boot/tools/build.c.
>>               text    data     bss     dec     hex filename
>> mainline: 20708323        6603052 1878448 29189823        1bd66bf vmlinux
>> cool:     20619594        6588166 1878448 29086208        1bbd200 vmlinux
>> C-func:   19969264        6583128 1878384 28430776        1b1d1b8 vmlinux

On Thu, Aug 12, 2004 at 04:12:55AM -0400, Zwane Mwaikambo wrote:
> Shit that's quite the variance, which compiler are you using?

$ gcc --version
gcc (GCC) 3.3.3 (SuSE Linux)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

It's the compiler on residue; you (zwane) should be able to log in and
take a closer look if need be.

-- wli
