Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUKUXkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUKUXkR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbUKUXkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:40:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:52387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261860AbUKUXkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:40:05 -0500
Date: Sun, 21 Nov 2004 15:39:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: help: sysrq and X
Message-Id: <20041121153940.035ffc08.akpm@osdl.org>
In-Reply-To: <41A122E0.8070307@eyal.emu.id.au>
References: <41A122E0.8070307@eyal.emu.id.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>
> I am trying to diagnose a hard lockup. The only way I can reproduce it is
>  with mythtv. When the system locks up (no mouse, no activity in X, no message
>  logged) I can use magic sysrq, but I cannot see the output.
> 
>  Using 'r' does not enable console switching. However 'b' will boot the
>  system, and I hope 's' and 'u' did something blindly.
> 
>  I there a way to regain a text console in order to inspect the kernel?
> 
>  I can connect a machine to the serial port if this will help - does
>  sysrq work though the serial port? Which software should I use on
>  the serial port (on the 'other' machine) for this purpose then?

Yes, serial console is the best way to do this.  Add `console=ttyS0' to the
kernel boot command line and use `<break>t' to get an all-task backtrace.

If you're using minicom (spit) on the other end, Control-A F t is the
combination to use.

