Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264811AbTCCM1X>; Mon, 3 Mar 2003 07:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264813AbTCCM1X>; Mon, 3 Mar 2003 07:27:23 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:13285 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264811AbTCCM1U>;
	Mon, 3 Mar 2003 07:27:20 -0500
Date: Mon, 3 Mar 2003 13:37:29 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Pavel Machek <pavel@ucw.cz>
Cc: bert hubert <ahu@ds9a.nl>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
Message-ID: <20030303123729.GB4048@k3.hellgate.ch>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	bert hubert <ahu@ds9a.nl>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Andrew Grover <andrew.grover@intel.com>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030302133138.GA27031@outpost.ds9a.nl> <1046630641.3610.13.camel@laptop-linux.cunninghams> <20030302202118.GA2201@outpost.ds9a.nl> <20030303003940.GA13036@k3.hellgate.ch> <1046657290.8668.33.camel@laptop-linux.cunninghams> <20030303113153.GA18563@outpost.ds9a.nl> <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Mar 2003 13:23:25 +0100, Pavel Machek wrote:
> Well, it does not happen on my machines, but I've already seen it
> happen on computer with two harddrives.

That was my initial suspicion, since I have two of them and typical swsusp
(Laptop) users tend not to have more than one. But I gave up on that theory
when Bert's log showed only one disk:

#        syncing disks
#        suspending devices
#        suspending c0418bcc
#        suspending devices
#        suspending c0418bcc
#        suspending: hda ------------------[ cut here

If he had two disks, his trace should look more like mine:

# Syncing disks before copy
# Suspending devices
# Suspending device c0390e4c
# Suspending device c03911a4
# Suspending devices
# Suspending device c0390e4c
# suspending: had ------------[ cut here ]------------
# kernel BUG at drivers/ide/ide-disk.c:1557!

Roger
