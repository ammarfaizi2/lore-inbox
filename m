Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272509AbTHKLbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 07:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272511AbTHKLbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 07:31:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37126 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272509AbTHKLbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 07:31:45 -0400
Date: Mon, 11 Aug 2003 12:31:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2: unable to suspend (APM)
Message-ID: <20030811123141.A20951@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030806231519.H16116@flint.arm.linux.org.uk> <20030811101403.GA360@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030811101403.GA360@elf.ucw.cz>; from pavel@ucw.cz on Mon, Aug 11, 2003 at 12:14:03PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 12:14:03PM +0200, Pavel Machek wrote:
> > I'm trying to test out APM on my laptop (in order to test some PCMCIA
> > changes), but I'm hitting a brick wall.  I've added the device_suspend()
> > calls for the SAVE_STATE, DISABLE and the corresponding device_resume()
> > calls into apm's suspend() function.  (this is needed so that PCI
> > devices receive their notifications.)
> 
> Can you verify that it is not device "vetoing" the suspend?

Well, the pm_send_all(PM_SUSPEND) in suspend() doesn't trigger the "veto"
messages, and I don't see any errors reported from device_suspend().

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

