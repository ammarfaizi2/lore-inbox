Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRCPMvk>; Fri, 16 Mar 2001 07:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRCPMva>; Fri, 16 Mar 2001 07:51:30 -0500
Received: from ecstasy.ksu.ru ([193.232.252.41]:59048 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S129282AbRCPMvR>;
	Fri, 16 Mar 2001 07:51:17 -0500
X-Pass-Through: Kazan State University network
Message-ID: <3AB20865.2070804@ksu.ru>
Date: Fri, 16 Mar 2001 15:34:45 +0300
From: Art Boulatov <art@ksu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10-pre5-reiserfs-3.6.18-acpi-i2c i686; en-US; 0.7) Gecko/20010203
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: pivot_root & linuxrc problem
In-Reply-To: <Pine.LNX.4.33.0103160822350.1057-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

........

> 
> Aha.. so that's it.  I've never been able to get /linuxrc to execute
> automagically.  I wonder why /linuxrc executes on Art's system, but
> not on mine.  I can call it whatever I want and it doesn't run unless
> I explicitly start it with init=whatever.
> 
> If it does execute though, that explains init complaining.. pid is
> going to be whatever comes after the last thread started (would be
> 8 here).  It looks like you're only supposed to do setup things in
> magic filename /linuxrc and not exec /sbin/init from there.
> 
> In any case, it looks like renaming linuxrc to whatever.sh and booting
> with init=/whatever.sh instead will likely make init happy.
> 
> 	-Mike
> 
> 
Thank you for your answers, Mike and Russell.

They made me sure something weird going on with my setup.
And I think a have figured the problem.
I was using etherboot to boot the kernel and initrd.
I should have told you that before, and I'm sorry I did not.

Bootin' localy, with lilo,  seems to  solve the "PID problem".

I guess that's more of mknbi from etherboot question than kernel-related...
I  have to check more in depth the etherboot documenation/sources.

Art.

