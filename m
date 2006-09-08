Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWIHWV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWIHWV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWIHWV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:21:56 -0400
Received: from jaguar.it.wsu.edu ([134.121.0.73]:25295 "EHLO jaguar.it.wsu.edu")
	by vger.kernel.org with ESMTP id S1750843AbWIHWVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:21:55 -0400
Message-ID: <4501EDA5.5020406@sandall.us>
Date: Fri, 08 Sep 2006 15:24:37 -0700
From: Eric Sandall <eric@sandall.us>
Organization: Source Mage GNU/Linux
User-Agent: Mail/News 1.5.0.4 (X11/20060905)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to ram with 2.6 kernels
References: <44FF8586.8090800@sandall.us> <20060907193333.GI8793@ucw.cz>
In-Reply-To: <20060907193333.GI8793@ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Wed 06-09-06 19:35:50, Eric Sandall wrote:
>> Hello LKML,
>>
>> I am having a problem with suspend-to-ram (have been for a while, but
>> suspend-to-disk has been working fine for me, so I never really bothered
>> to report it until now).
>>
>> Suspend-to-disk and resuming from it works fine (using `echo -n disk >
>> /sys/power/state`).
>>
>> Suspend-to-ram works fine (using `echo -n mem > /sys/power/state`), but
>> resuming does not. When I lift up the lid of my laptop (Dell Inspiron
>> 5100) it seems to power back up (the power light changes from blinking
>> to solid), but my screen stays blank and keys such as capslock do not
>> toggle their LED.
> 
> See suspend.sf.net, use provided s2ram program.

Thanks! The key (mentioned in the documentation there) is to disable
framebuffer (ATI video card). First time I've had suspend-to-RAM working
on this machine. ;)

Suspending works with `s2ram -f`, no other options needed, from X.

# s2ram -i
This machine can be identified by:
    sys_vendor   = "Dell Computer Corporation"
    sys_product  = "Inspiron 5100                   "
    sys_version  = ""
    bios_version = "A23"

Though you may want to rename the /usr/sbin/suspend command to something
other than 'suspend' as, at least for me, it is a shell command which
puts the current shell in the background.

The HOWTO *does* mention:
[Warning: some shells have "suspend" built in command, so specifing
exact path like ./suspend is more important than usual.]

Though I still believe it'd be a good idea to pick a non-conflicting name.

-sandalle

-- 
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/


