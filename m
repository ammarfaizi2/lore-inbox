Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTIDOzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTIDOzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:55:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:2504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265200AbTIDOzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:55:09 -0400
Date: Thu, 4 Sep 2003 07:52:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Bill Davidsen <davidsen@tmr.com>
cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <Pine.LNX.3.96.1030904000316.12166A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33.0309040746590.940-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not sure trying to suspect during boot is a good thing to do, either.
> Maybe that should wait and be enabled at user option at the end of boot.
> In any case, I think avoiding data damage is higher priority than
> efficiency, elegance, modularity, etc.
> 
> Beyond that I'll let you guys fight it out, I'm just worried that the new
> pm is going to bite me even if I don't use suspend.

Your paranoia is understood, but completely unfounded. As Pavel said, we
do not support such a feature. When/if we do, only the mechanism for
detecting a low battery state and transitioning to a suspend sequence 
would be in the kernel. The policy that stated what the watermark on the 
battery charge was to do that would live in userspace, and set on boot 
(long after the kernel was done booting). The default would obviously be 
OFF until it was set by userspace. 

Patches to implement this would be greatly appreciated. 



	Pat

