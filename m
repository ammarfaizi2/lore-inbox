Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVBORPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVBORPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVBORLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:11:39 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:52878 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261797AbVBORJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:09:23 -0500
Date: Tue, 15 Feb 2005 18:08:37 +0100
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42121EC5.8000004@gmx.net>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 15 Feb 2005, Carl-Daniel Hailfinger wrote:
> To suspend and resume properly, call the following script as root:

Success. 

After deactivating DRI in the X config file and saving the states with
your script (thanks) and turning off various stuff I get X running
again.

Questions:
- DRI must be disabled I guess?! Even with newer X server (x.org)?
- I dont have to restore the font, it is back without any problem
  (I have vga console)
- Sometimes I have to make a Sysrq-s (sync) to get some stuff running
  (eg logging in from the console hangs after input of passwd, calling
  sysrq-s makes it continue). I had a similar effect when logging in
  AFTER resuming (for the resume I had only gdm running but wasn't
  logged in) the GNOME starting screen stayed there indefinitely, no
  change. Even after restarting the X server and retrying.
  Logging in with twm session DID work without any problem.
  Do you have any idea what this could be?
- My script is a bit more complicated: stopping: hotplug, mysql,
  ifplugd, waproamd, cpufreqd, acpid, ifdown eth0, eth1, rmmod acerhk
  echo "performance" onto governor, then going to sleepand doing
  more or less the reverse stuff after waking up.
  DO you have any experience with hotplug network etc stuff, working
  even without stopping?

Thanks a lot.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CROMARTY (n.)
The brittle sludge which clings to the top of ketchup bottles and
plastic tomatoes in nasty cafes.
			--- Douglas Adams, The Meaning of Liff
