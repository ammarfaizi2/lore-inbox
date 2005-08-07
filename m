Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752766AbVHGVPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbVHGVPL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbVHGVPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:15:11 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:15281 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1752766AbVHGVPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:15:10 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Sun, 7 Aug 2005 23:15:05 +0200
From: Alexander Nyberg <alexn@telia.com>
To: JG <jg@cms.ac>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: sluggish/very slow usb mouse on hp nx6110 notebook => acpi problem
Message-ID: <20050807211505.GA1864@localhost.localdomain>
References: <20050805195243.4e9df3de@x90.0x4a47.net> <20050805205651.2cd22f1b@x90.0x4a47.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805205651.2cd22f1b@x90.0x4a47.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 08:56:51PM +0200 JG wrote:

> hm, i currently have "acpi=off noacpi noapic reboot=b" as kernel
> parameter.
> 
> if i remove the acpi stuff and enable acpi, the usb mouse works fine..
> but after some time (5-10min) the kacpid process goes havoc and eats
> all cpu and the whole system is unresponsive- that's the reason i added
> those acpi=off parameters the first time when installing gentoo..
> 
> i tested with gentoo-2.6.12-r7 and vanilla-2.6.13rc5
> 

Indicates a bug in kacpid or similar. Could you make sure you compile in
"Magic SysRq key" under "Kernel Hacking" and boot the vanilla-2.6.13-rc6
(some recent acpi changes have gone in) and then wait for kacpid
to go nuts and do

Alt+Sysrq+t 4 times and then run 'dmesg -s 100000 > logfile' and
send logfile over here so that we can see what kacpid is up to.

If the box becomes so unresponsive you can't extract the log information
it would be good if you could use either network console 
Documentation/networking/netconsole.txt or serial console at
Documentation/serial-console.txt, both require an extra computer
though...
