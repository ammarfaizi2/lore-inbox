Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUG3RYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUG3RYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267756AbUG3RYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:24:47 -0400
Received: from web14924.mail.yahoo.com ([216.136.225.8]:45405 "HELO
	web14924.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267759AbUG3RYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:24:34 -0400
Message-ID: <20040730172433.2312.qmail@web14924.mail.yahoo.com>
Date: Fri, 30 Jul 2004 10:24:33 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Torrey Hoffman <thoffman@arnor.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1091207136.2762.181.camel@rohan.arnor.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Torrey Hoffman <thoffman@arnor.net> wrote:
> This sounds interesting, but I'm curious...  why?  That is, what
> problem are you solving by making ROMs exposed?
> 
> Or is this just for fun?  (That's a legitimate reason IMO...)

Secondary video cards need to have code in their ROMs run to reset
them. When an x86 PC boots it only reset the primary video device, the
secondary ones won't work until their ROMs are run.

Another group needing this is laptop suspend/resume. Some cards won't
come back from suspend until their ROM is run to reinitialize them.

A third group is undocumented video hotware where the only way to set
the screen mode is by calling INT10 in the video ROMs. (Intel
i810,830,915 for example).

Small apps are attached to the hotplug events. These apps then use vm86
or emu86 to run the ROMs. emu86 is needed for ia64 or ppc when running
x86 ROMs on them.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail
