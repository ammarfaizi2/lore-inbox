Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVCXSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVCXSLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVCXSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:11:04 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:827 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262649AbVCXSLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:11:00 -0500
Date: Thu, 24 Mar 2005 10:10:59 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Stefan Seyfried <seife@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050324181059.GA18490@hexapodia.org>
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4242CE43.1020806@suse.de>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 03:27:15PM +0100, Stefan Seyfried wrote:
> Andy Isaacson wrote:
> > Dmesg is attached; hardware is a Vaio r505te.
> > 
> > Unfortunately, the deadlock (?) is nondeterministic; it *sometimes*
> > suspends successfully, maybe one time out of 10.  And thinking back, I
> > *sometimes* saw failures to suspend with 2.6.11-rc3, maybe one failure
> > out of 20 suspends.
> 
> Does it hang hard or is sysrq still working?

Sysrq still prints stuff, so IRQs aren't locked.  But most of the sysrq
commands don't work... S and U don't seem to do anything (not too
suprising I suppose) but B does reboot.

> If sysrq is still working, please try with "i8042.noaux" (this will kill
> your touchpad, which is what i intend :-)

So I added i8042.noaux to my kernel command line, rebooted, insmodded
intel_agp, started X, and verified no touchpad action.  Then I
suspended, and it worked fine.  After restart, I suspended again - also
fine.

So I think that fixed it.  But no touchpad is a bit annoying. :)

-andy
