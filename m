Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUBVRVy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUBVRVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:21:50 -0500
Received: from dns.communicationvalley.it ([212.239.58.133]:10886 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S261705AbUBVRVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:21:48 -0500
From: Silla Rizzoli <silla@netvalley.it>
Organization: Communication Valley spa
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.4.25 yenta problem and small fix/workaround
Date: Sun, 22 Feb 2004 18:20:46 +0100
User-Agent: KMail/1.6
Cc: daniel.ritz@gmx.ch, linux-kernel <linux-kernel@vger.kernel.org>
References: <200402202331.45218.daniel.ritz@gmx.ch> <200402221703.55235.silla@netvalley.it> <20040222163038.A23746@flint.arm.linux.org.uk>
In-Reply-To: <20040222163038.A23746@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402221820.49206.silla@netvalley.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This probably occurs because starting X caused AGP to be initialised,
> which caused an interrupt on IRQ11.  Since the cardbus bridge is also
> using IRQ11 to report status changes, we notice the status change.
>
> So, the reason this went wrong _appears_ to be because we never received
> the interrupt from the cardbus bridge, although the cardbus status
> correctly indicated there was work to be done.
>
> Also, you seem to have some proprietary modules loaded - have you tried
> running without these modules loaded?  (See below.)

> This seems to be a closed source modem driver, which seems to be using
> IRQ11.  This is definitely one thing to try removing and seeing if the
> problem goes away.  (By "removing" here I mean _never_ having been
> loaded since boot - any other type of "removing" will not give the
> desired test conditions required to correctly isolate the problem.)

I erased the driver, rebooted and nothing changed.
I'm sorry it didn't solve the problem, but I'm also relieved that I'm not 
wasting your time! :D

Regards,
Silla
