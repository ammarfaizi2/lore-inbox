Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271126AbUJVAts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271126AbUJVAts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271036AbUJVArq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:47:46 -0400
Received: from fmr06.intel.com ([134.134.136.7]:687 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271165AbUJVAoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:44:30 -0400
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS,
	...)
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nate Lawson <nate@root.org>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20041021103729.GA1088@elf.ucw.cz>
References: <4176FCB8.3060103@root.org>
	 <1098323602.6132.51.camel@sli10-desk.sh.intel.com>
	 <20041021103729.GA1088@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1098405352.28250.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 08:35:52 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 18:37, Pavel Machek wrote:
> Hi!
> 
> > > > :-). Well for some other people it powers up when they unplug AC
> > > > power, and *that* is nasty. I'd like my machine to stay powered down
> > > > when I tell it so.
> > > 
> > > This is likely a similar GPE problem.  The GPE for the EC fires even
> > > in 
> > > S5.  I think the EC GPE should be disabled in the suspend method.
> > It could be the wakeup GPE issue, but must note Pavel's system suffer
> > the problem even with acpi=off. Could you please try boot your system
> > with acpi=off, and then reboot with acpi=off, what's the result? I
> > expected the wakeup GPE is disabled by the BIOS in this case.
> > Anyway, the DSDT can tell us the wakeup GPE info.
> 
> You want me to boot with acpi=off twice and see if machine powers down
> okay in second case?
Yes, indeed.
> 
> Compressed DSDT is attached.
The dmesg shows your system can be waked up by Lid from S4 but not S5.
But there is another device (looks like the LPC bridge) can wakeup your
system from S5.

Thanks,
Shaohua

