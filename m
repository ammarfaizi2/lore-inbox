Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVBOSzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVBOSzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVBOSzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:55:51 -0500
Received: from imap.gmx.net ([213.165.64.20]:42946 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261821AbVBOSzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:55:36 -0500
X-Authenticated: #26200865
Message-ID: <4212460A.4000100@gmx.net>
Date: Tue, 15 Feb 2005 19:57:14 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Norbert Preining <preining@logic.at>
CC: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
In-Reply-To: <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining schrieb:
> On Die, 15 Feb 2005, Carl-Daniel Hailfinger wrote:
> 
>>To suspend and resume properly, call the following script as root:
> 
> 
> Success. 

Great!


> After deactivating DRI in the X config file and saving the states with
> your script (thanks) and turning off various stuff I get X running
> again.
> 
> Questions:
> - DRI must be disabled I guess?! Even with newer X server (x.org)?

I never disabled it.

> - I dont have to restore the font, it is back without any problem
>   (I have vga console)

Good. I guess that's highly chipset-specific.

> - Sometimes I have to make a Sysrq-s (sync) to get some stuff running
>   (eg logging in from the console hangs after input of passwd, calling
>   sysrq-s makes it continue). I had a similar effect when logging in
>   AFTER resuming (for the resume I had only gdm running but wasn't
>   logged in) the GNOME starting screen stayed there indefinitely, no
>   change. Even after restarting the X server and retrying.
>   Logging in with twm session DID work without any problem.
>   Do you have any idea what this could be?

Pavel?

> - My script is a bit more complicated: stopping: hotplug, mysql,
>   ifplugd, waproamd, cpufreqd, acpid, ifdown eth0, eth1, rmmod acerhk
>   echo "performance" onto governor, then going to sleepand doing
>   more or less the reverse stuff after waking up.
>   DO you have any experience with hotplug network etc stuff, working
>   even without stopping?

I used to unload modules, shutdown network interfaces etc. until I
tried without all that stuff and it still worked. So I concluded
that stopping things before suspend was a thing only needed with
older kernels. Granted, mounted volumes on USB or IEEE1394 still
have problems because the kernel doesn't expect them to disappear
for a few moments, but that's nothing a module unload would fix.
Simply umount all external drives and use my script. Drivers which
still need to be unloaded and reloaded are buggy and have to be
fixed.

I'll prepare a web page with detailed S3/S4 suspend/resume
information for ATI graphics card owners including step-by-step
howtos for smooth suspend/resume cycles.

Kendall Bennett is working with me to get suspend/resume working
even with framebuffers. Once we have results, I'll post them here.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
