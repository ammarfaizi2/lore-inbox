Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266580AbUG2H7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUG2H7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUG2H7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:59:34 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:16298 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266580AbUG2H7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:59:30 -0400
Subject: Re: -mm swsusp: do not default to platform/firmware
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040729073929.GB828@elf.ucw.cz>
References: <20040728222445.GA18210@elf.ucw.cz>
	 <20040728161448.336183e2.akpm@osdl.org> <20040728233929.GD16494@elf.ucw.cz>
	 <20040728234352.GA14319@elf.ucw.cz>
	 <1091061026.8873.78.camel@laptop.cunninghams>
	 <20040729073929.GB828@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1091087563.8873.132.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 17:52:44 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Sorry to do this to you - there are still a couple of errors.

On Thu, 2004-07-29 at 17:39, Pavel Machek wrote:
> Thanks, text is now:
> 
> Q: Kernel thread must voluntarily freeze itself (call 'refrigerator'). But

Q: A kernel thread ... 'refrigerator') but ...

(Sentences shouldn't begin with 'But').

> I found some kernel threads that don't do it, and they don't freeze, and

the last ', and' should probably go.

> so the system can't sleep. Is this a known behavior?

American spelling. I'll resist the temptation!

> A: All such kernel threads need to be fixed, one by one. Select place

Select the place

> where it is safe to be frozen (no kernel semaphores should be held at

it -> the thread (the previous subject was plural).

> that point and it must be safe to sleep there), and add:
> 
>             if (current->flags & PF_FREEZE)
>                     refrigerator(PF_FREEZE);
> 
> If the thread is needed for writing the image to storage, you should
> instead set the PF_NOFREEZE process flag when creating the thread.
> 
> I'll eventually push it, too.

Thanks!

Nigel

