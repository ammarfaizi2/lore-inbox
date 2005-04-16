Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVDPSqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVDPSqT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 14:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVDPSqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 14:46:19 -0400
Received: from web50202.mail.yahoo.com ([206.190.38.43]:46991 "HELO
	web50202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261872AbVDPSqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 14:46:13 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=goWTuUe37bnQtB2GMan977QJF1dct/2In+y5qlAq1RmWCvaBSNIULPOKRY6wpEHUFCZ1nsemOjHU/nArcle95PMUzC02zxkOCAMbtEkXPR0TnYsMemEsk7IWlWGqvwyeKuX71+vHFMmKammg/CTf0Az7dl+7H4lUd/FPMMEnJQ4=  ;
Message-ID: <20050416184613.85317.qmail@web50202.mail.yahoo.com>
Date: Sat, 16 Apr 2005 11:46:13 -0700 (PDT)
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: hot-addacpi-hotplug-decouple-slot-power-state-changes-from-physical-hotplug.patch
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Rajesh Shah <rajesh.shah@intel.com> wrote:

> > Is p2p hotplug in your roadmap (for i386) ?
>
> I believe others are already working on it. I expect to free up
> a bit more in a couple of weeks.  If I don't see any patches or
> indication of activity by then, I'll work on adding this support
> too.
> 
> Rajesh

Hi Rajesh,

While waiting for a p2p bridge hotplug support, I give a try to linux-2.6.12rc2-mm3 which include
your patch for powering on and off an ACPIPHP controlled PCI slot without actually remove the pci
card.
I gave it a try on my IBM thinkpad booted in docking station which has an ACPIPHP slot.

An echo 0 > /sys/bus/pci/slots/SOME_NUMBER/power is removing some devices ( verified with cat
/proc/pci ), but gives some kernel errors on console.
An echo 1 > /sys/bus/pci/slots/SOME_NUMBER/power is not activating the devices again ( again
tested with cat /proc/pci) but gives some kernel errors on console + some cpu registers and a
segfault.

In my dock I have a ide controller, 2 yenta pcmcia slots, and a PCI slot where I have a bttv
supported tv card.
All drivers needed were compiled in kernel, no modules needed.

Was this setup supposed to work ?
I can provide more info if needed.

Thanks,
Paul






__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
