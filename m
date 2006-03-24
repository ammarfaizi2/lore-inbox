Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWCXS3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWCXS3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWCXS3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:29:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751354AbWCXS3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:29:10 -0500
Date: Fri, 24 Mar 2006 10:25:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 grub oddness
Message-Id: <20060324102537.1d426594.akpm@osdl.org>
In-Reply-To: <1143201413.7741.53.camel@homer>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<1143201413.7741.53.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> Greetings,
> 
> I'm seeing strange things with grub with this kernel.  After my box has
> been up for a while, and I reboot, selecting a kernel to restart, upon
> reboot, I sometimes (fairly often) get a blank screen staring at me
> though I see grub doing it's thing.  Poking the power button results in
> an immediate poweroff, not as if the kernel had panicked or whatnot very
> early in boot.  Very odd, and never before seen.
> 

Do you mean that grub is actually proceeding as expected, just that the
display is off?  If so, does it ever come back on?

Would it be reasonable to guess that some piece of code on the reboot path
is now poking the display hardware in a manner which shuts it off?

Are you using an fbdev driver?  If so, which?
