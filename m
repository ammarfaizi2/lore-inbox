Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272528AbTHKMuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272536AbTHKMux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:50:53 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:24724 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S272528AbTHKMuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:50:52 -0400
Date: Mon, 11 Aug 2003 22:50:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: unable to suspend (APM)
Message-Id: <20030811225039.75549d0f.sfr@canb.auug.org.au>
In-Reply-To: <20030811101403.GA360@elf.ucw.cz>
References: <20030806231519.H16116@flint.arm.linux.org.uk>
	<20030811101403.GA360@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 12:14:03 +0200 Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > I'm trying to test out APM on my laptop (in order to test some PCMCIA
> > changes), but I'm hitting a brick wall.  I've added the device_suspend()
> > calls for the SAVE_STATE, DISABLE and the corresponding device_resume()
> > calls into apm's suspend() function.  (this is needed so that PCI
> > devices receive their notifications.)
> 
> Can you verify that it is not device "vetoing" the suspend?

The error logged by the apm driver indicates an error from the BIOS. So
the BIOS thinks the machine is in a state that it cannot suspend from.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
