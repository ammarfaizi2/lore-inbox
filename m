Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283244AbRLTKHu>; Thu, 20 Dec 2001 05:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283467AbRLTKHe>; Thu, 20 Dec 2001 05:07:34 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:51205 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S283314AbRLTKHM>;
	Thu, 20 Dec 2001 05:07:12 -0500
Date: Thu, 20 Dec 2001 00:49:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Robert Love <rml@tech9.net>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Anthony DeRobertis <asd@suespammers.org>, root <r6144@263.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make highly niced processes run only when idle
Message-ID: <20011220004907.B120@elf.ucw.cz>
In-Reply-To: <75F30A52-ECF4-11D5-80FE-00039355CFA6@suespammers.org> <1007939114.878.1.camel@phantasy> <20011209181643.A8846@redhat.com> <1007940066.878.7.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007940066.878.7.camel@phantasy>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Even better would be to keep the process at low priority while in userland 
> > and reverts to normal "nice" priority while in kernelspace.
> 
> But the point of a SCHED_IDLE would be to only run them while idle, so
> they can still never even get the CPU.
> 
> Ahh ... wait, do you mean periodically run them, but only give them the
> boost while they are in kernel space?  Very good idea.  Can you see an
> easy way to do this?

This was done before... As I wrote... Make it flag similar to "this is
being ptraced" to get out of fast path, and rest is easy. Unset
"low_priority" on entering of kernel, and set it back on exit from
kernel.

								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
