Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269255AbTCBUKy>; Sun, 2 Mar 2003 15:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269286AbTCBUKy>; Sun, 2 Mar 2003 15:10:54 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:52432 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S269255AbTCBUKx>;
	Sun, 2 Mar 2003 15:10:53 -0500
Date: Sun, 2 Mar 2003 21:21:18 +0100
From: bert hubert <ahu@ds9a.nl>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: S4bios support for 2.5.63
Message-ID: <20030302202118.GA2201@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Pavel Machek <pavel@ucw.cz>, Andrew Grover <andrew.grover@intel.com>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046630641.3610.13.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 07:44:03AM +1300, Nigel Cunningham wrote:
> Hi.
> 
> This bug is fixed in Linus tree. If you want swsusp to work in the mean
> time, look for a couple of patches Pavel sent recently.

Ok,

In 2.5.63bk5 I get a BUG on drivers/ide/ide-disk.c:1557:


        BUG_ON (HWGROUP(drive)->handler);


It now says (copied by hand):

	freeing memory: .....................|
(this 'freeing' takes ages, around 30 seconds, while in progress, the disk
 light blinks every once in a while, perhaps each time while a dot is being
printed)
	syncing disks
	suspending devices
	suspending c0418bcc
	suspending devices
	suspending c0418bcc
	suspending: hda ------------------[ cut here
trace back:

device_susp()
drivers_susp()
do_sofware_susp()

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
