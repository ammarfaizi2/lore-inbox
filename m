Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUAIWGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbUAIWGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:06:23 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:6797 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264602AbUAIWGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:06:21 -0500
Message-ID: <3FFF25DC.4070206@comcast.net>
Date: Fri, 09 Jan 2004 16:06:20 -0600
From: Ian Pilcher <i.pilcher@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl equivalent of "idle=poll"
References: <3FFBA98D.1080901@comcast.net> <20040109133518.59c44790.rddunlap@osdl.org>
In-Reply-To: <20040109133518.59c44790.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> I don't see any problems with this patch itself, other than its
> justification.
> 
> Why is a sysctl needed instead of using idle=X as a boot parameter?
> 
> Does this fix a bug/oops that you were having?
> Or does it cover up a bug somewhere?

Using "idle=poll" allows me to boot 2.4.x on my Abit VP6 with ACPI
turned on.  (Remember the "Plea for help" thread on acpi-devel?)  I
need ACPI-based IRQ routing to get the built-in USB controllers working.

Once the system is booted, however, I have no desire to cook my CPUs.
This allows me to set polling back to regular mode.  (I just add an
entry to /etc/sysctl.conf.)  I have no idea if any other hardware will
benefit from this, but it's always possible.

So that's why I'm interested in it.

More generally, if people are booting with "idle=poll" for performance
reasons, many of them probably don't need it turned on all the time.
This would allow a simple user-level program to turn on idle polling
when the load is high and turn it off the rest of the time, saving
power and possibly extending the life of the hardware.

So if there's value in having it as a boot parameter, I think there's
value in having it tunable at runtime.

BTW, although I don't need "idle=poll" to boot 2.6 with ACPI, I will
create a 2.6 version of this patch if its accepted into 2.4.

> MOTD:  Always include version info.

Should I have generated the patch differently?

Thanks for the feedback!

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

