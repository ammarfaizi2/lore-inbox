Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbUKKAEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUKKAEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUKKAEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:04:45 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:57271 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262147AbUKKAEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:04:00 -0500
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Paul Mackerras <paulus@samba.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <16786.35271.622222.193502@cargo.ozlabs.ibm.com>
References: <1099346276148@kroah.com> <10993462773570@kroah.com>
	 <20041102223229.A10969@flint.arm.linux.org.uk>
	 <20041107152805.B4009@flint.arm.linux.org.uk>
	 <20041110013700.GF9496@kroah.com>
	 <16785.33677.704803.889900@cargo.ozlabs.ibm.com>
	 <20041110083629.A17555@flint.arm.linux.org.uk>
	 <16786.35271.622222.193502@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1100131216.7402.11.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 11 Nov 2004 11:00:22 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-11 at 08:36, Paul Mackerras wrote:
> Russell King writes:
> However, pci_dev->driver only gets cleared *after* the driver's remove
> method returns.  Thus it would be quite possible for a PCI device to
> have its suspend/resume methods called while another CPU is in its
> remove method.
> 
> I think that what has saved us to some extent is that we only do
> suspend/resume on UP machines so far.

I'm suspending and resuming all the time using HT. FWIW, I think it's
more likely that you're not seeing the issue for two reasons.

1) User space has been frozen when the suspend/resume methods are called
(I'm right in assuming that only swsusp/pmdisk, suspend-to-ram and
suspend2 would be doing suspends, aren't I?).
2) People tend to wait until the machine has powered down before
unplugging things, and plug things in before powering on.

Please excuse me if I'm speaking nonsense :>

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

