Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTIDT0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264849AbTIDT0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:26:07 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:55261 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S262004AbTIDT0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:26:04 -0400
Date: Fri, 05 Sep 2003 07:28:52 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: swsusp: revert to 2.6.0-test3 state
In-reply-to: <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1062703732.12025.7.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 03:25, Patrick Mochel wrote:
> No, you have to understand that I don't want to call software_suspend() at 
> all. You've made the choice not to accept the swsusp changes, so we're 
> forking the code. We will have competing implementations of 
> suspend-to-disk in the kernel. 
> 
> You may keep the interfaces that you had to reach software_suspend(), but
> you may not modify the semantics of my code to call it. At some point, you 
> may choose to add hooks to swsusp that abide by the calling semantics of 
> the PM core, so that you may use the same infrastructure.
> 
> Please send a patch that only removes the calls to swsusp_* from 
> pm_{suspend,resume}. That would be a minimal patch. 

Where does this put me? I'm finishing off 1.1 for 2.4 and have a port to
2.6 in process. I want to get it merged, but how do I go about that now?

For the record, it's worth merging, I believe. It has a fully year of
extensive testing, support for saving a full (as opposed to minimal)
image of RAM, support for highmem, swap files, full asynchronous I/O,
aborting cleanly from errors, user tuning and a nice interface. I don't
want to see it thrown away, but neither do I want to have a third
option!

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

