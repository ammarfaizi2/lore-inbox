Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUJKUGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUJKUGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269217AbUJKUGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:06:17 -0400
Received: from hacksaw.org ([66.92.70.107]:61361 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S269214AbUJKUGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:06:10 -0400
Message-Id: <200410112006.i9BK62Xn006966@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ? 
In-reply-to: Your message of "Mon, 11 Oct 2004 14:04:19 +0200."
             <AE30E0FE-1B7D-11D9-96AD-000D9352858E@linuxmail.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Oct 2004 16:06:02 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If the initrd gets corrupted, are we just hosed?
>
>In some way, the answer is yes... I think the best is having a real, 
>on-disk, full "/dev" hierarchy in case the INITRD gets lost or 
>corrupted, which will still allow booting. Now, the INITRD can mount 
>tmpfs over "/dev" and use udev to create needed device nodes.

And see, this is where I say, what if /dev is hosed too? If the kernel at this 
point gives up, then the user has to dig up a boot CD or something worse and 
start trying to fix the system.

If, however, the kernel just made /dev/console and maybe /dev/null, it could 
start a shell and say "/dev missing /console device, initrd corrupted. Hit 
enter for a shell or ctrl-alt-del to reboot."

As a sys-admin, I'd like that. Get me into single user mode the best you can. 
If a shell can be found, that's good enough.
-- 
The best is the enemy of the good  -- Voltaire
The Good Enough is the enemy of the Great -- Me
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


