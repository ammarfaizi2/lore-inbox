Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTDOTzz (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTDOTzz 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:55:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264057AbTDOTzq 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 15:55:46 -0400
Date: Tue, 15 Apr 2003 13:06:07 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>
Subject: Re: New Software Suspend Patch for testing.
In-Reply-To: <1049454721.2418.33.camel@laptop-linux.cunninghams>
Message-ID: <Pine.LNX.4.44.0304151246400.912-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Brief howto:
> (Assuming you've applied the patch against 2.5.66 - other versions may
> work too).
> 1. Patch, compile as normal.
> 2. Ensure your kernel commandline includes resume=/dev/hdaX where X is a
> swap partition you will be using. More than one swap partition can be
> used. This just specifies which will have its header used to indicate
> that the system is suspended and where to find the data.
> 3. If you want debugging info: echo 1 20 15 31 > /proc/sys/kernel/swsusp
> (See line 201ff of kernel/suspend.c for what the numbers mean).
> 4. echo 4 > /proc/acpi/sleep to start the process. 
> The system should save the image and powerdown.
> If you choose the debugging info, you'll have to press SHIFT at the end
> of each step.
> If you press SHIFT at other times, you can toggle this pausing on and
> off.
> Whether you selected the debugging info or not, you can press ALT to
> cancel the process.
> 5. To resume, reboot with the same kernel. The image should be detected
> and reloaded without you needing to do anything special. Pausing or not
> is state-persistent from when you suspended.
> 6. You should (DV) get your system back to where it was when you started
> the process.

I have a (fairly large) request: 

Would you mind updating Documentation/swsusp.txt (and moving it to 
Documentation/power/swsusp.txt)? 

This will accomplish a few things:

- Make the documentation readable.

- Explain exactly how swsusp works internally.

- Explain how to use it.

- Explain what the current dependencies and bugs are. 

- Explain what the cryptic debug values above are. 


Frankly, the code is a mess and difficult to follow. It's also poorly
commented. I spent the time about a month ago unwinding and deciphering 
it. Unfortunately, my work conflicts heavily with the work that you're 
doing, and the lack of documentation describing the intent of the code 
makes it difficult to make sane judgements of it. 

Thanks,


	-pat

