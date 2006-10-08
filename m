Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWJIOZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWJIOZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWJIOZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:25:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7172 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751876AbWJIOZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:25:58 -0400
Date: Sun, 8 Oct 2006 18:51:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine reboot
Message-ID: <20061008185125.GE4033@ucw.cz>
References: <20061005105250.GI2923@mail.muni.cz> <aec7e5c30610050458x1fbe52bex851779d73c004350@mail.gmail.com> <20061005160518.GM2923@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005160518.GM2923@mail.muni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-10-06 18:05:18, Lukas Hejtmanek wrote:
> On Thu, Oct 05, 2006 at 08:58:22PM +0900, Magnus Damm wrote:
> > A long shot, but switching to real mode does not work if the cpu is
> > running in VMX root mode ie on hardware with Intel VT extensions
> > enabled. So if you are using some kind of kernel virtualization module
> > on rather new hardware, consider rmmod:ing the module before
> > rebooting.
> > 
> > I'm about to post patches for kexec that fixes this problem, but I'm
> > not sure about the current reboot status.
> 
> You are right, I'm using Intel Core 2 Duo processor with DP965LT board that is
> capable of VT extensions. However, I'm using vanilla 2.6.18 kernel in X86_64,
> no additional patches, nor XEN or VMWARE is running (even their modules are
> not loaded). Moreover, SYSRQ-B (emergency reboot) works fine. System graceful
> reboot does not work.

Of course... copy/paste pieces of sysrq-b sequence into regular
sequence to find out what the critical difference is... no, it will
not be easy.

Perhaps your box *likes* to reboot with apic on or something? Perhaps
device_shutdown() breaks your ability to reboot?

-- 
Thanks for all the (sleeping) penguins.
