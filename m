Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVC1UKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVC1UKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVC1UKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:10:45 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:61562 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262056AbVC1UKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:10:18 -0500
X-ME-UUID: 20050328201015762.BA1C41C00CAC@mwinf0304.wanadoo.fr
Subject: Re: Various issues after rebooting
From: Olivier Fourdan <fourdan@xfce.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050328193921.GW30052@alpha.home.local>
References: <1112039799.6106.16.camel@shuttle>
	 <20050328192054.GV30052@alpha.home.local> <1112038226.6626.3.camel@shuttle>
	 <20050328193921.GW30052@alpha.home.local>
Content-Type: text/plain
Organization: http://www.xfce.org
Date: Mon, 28 Mar 2005 22:10:14 +0200
Message-Id: <1112040614.6626.24.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Mon, 2005-03-28 at 21:39 +0200, Willy Tarreau wrote:
> Sorry, at first I only noticed ACPI in your mail, but after reading it
> again, I also noticed APIC. So now, you can only try not to initialize
> some peripherals (IDE, network, display, etc...) by removing their drivers
> from the kernel. You may end up with a kernel panic, but that does not
> matter is you boot it with "panic=5" so that it automatically reboots
> 5 seconds after the panic. You should then finally identify the subsystem
> which is responsible for your problems. Perhaps you'll even need to remove
> PCI support :-(

Well, actually, the system runs (at least) unless I try to load
"ndiswrapper" which leads to a kernel panic.

I tried to bring the issue to the ndiswrapper ML but I doubt that
ndiswrapper is faulty.

I can reliably predict the crash. If the clock (and all other time based
events) are too fast, then modprobing ndiswrapper will lead to a system
crash, just like mounting a CDROM will fail.

I think the clock speed and other effects are just signs, not the cause
of the problem. What I'd like to determine is what would need to be done
to avoid the root cause, or maybe if there is anything that can be done
in Linux to avoid that?

I just tried "acpi_fake_ecdt" but that leads to a immediate kernel
panic.

Ps: Given the crash (Machine check exception), the sleep option seems to
have no effect.

Thanks,
Olivier.




