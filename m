Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbTIRHnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbTIRHnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:43:45 -0400
Received: from gprs145-63.eurotel.cz ([160.218.145.63]:28288 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263005AbTIRHno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:43:44 -0400
Date: Thu, 18 Sep 2003 09:43:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: richard.brunner@amd.com
Cc: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030918074331.GA386@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think Alan brought up a very good point. Even if you
> use a generic kernel that avoids prefetch use on Athlon
> (which I am opposed to), it doesn't solve the problem
> of user space programs detecting that the ISA supports
> prefetch and using prefetch instructions and hitting the
> errata on Athlon.
> 
> The user space problem worries me more, because the expectation
> is that if CPUID says the program can use perfetch, it could
> and should regardless of what the kernel decided to do here.

User programs should not rely on cpuid; they should read /proc/cpuinfo
exactly because this kind of errata.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
