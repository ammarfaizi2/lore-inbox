Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVGLVT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVGLVT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVGLVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:17:59 -0400
Received: from taxbrain.com ([64.162.14.3]:49631 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S262487AbVGLVRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:17:25 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9: serial_core: uart_open
Date: Tue, 12 Jul 2005 14:17:14 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILAEAHCEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20050712220348.D11389@flint.arm.linux.org.uk>
X-Spam-Processed: petzent.com, Tue, 12 Jul 2005 14:13:31 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Tue, 12 Jul 2005 14:13:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Russell King
Sent: Tuesday, July 12, 2005 2:04 PM
To: karl malbrain
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9: serial_core: uart_open


On Tue, Jul 12, 2005 at 11:36:51AM -0700, karl malbrain wrote:
> The uart_open code loops waiting for CD to be asserted (whenever CLOCAL
> is not set).  The bottom of the loop contains the following code:
>
> up(&state->sem);
> schedule();
> down(&state->sem);
>
> if( signal_pending(current) )
>    break;

This does cause the process to sleep - in an interruptible wait.

Please give more details about the problem you're seeing.  Have you
tried getting a process listing from a different virtual console,
xterm or whatever you normally use?  What does that say?

--
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Sorry, but I cannot get anything else to run.  I can barely get XWindows to
kill the process.

What prevents schedule() from returning to the current process w/o any
delay?

Thanks, karl m




