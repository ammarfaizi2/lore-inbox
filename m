Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRDEVy5>; Thu, 5 Apr 2001 17:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRDEVyr>; Thu, 5 Apr 2001 17:54:47 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:33990 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S129084AbRDEVyi>; Thu, 5 Apr 2001 17:54:38 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE813@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Trever L. Adams'" <trever_Adams@bigfoot.com>
Cc: linux Kernel <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: 2.4.3 (and possibly 2.4.2) don't enter S5 (ACPI) on shutdown
Date: Thu, 5 Apr 2001 14:52:37 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Trever L. Adams [mailto:trever_Adams@bigfoot.com]
> I do have a question that you might be able to answer.
> 
> Since I left the 2.2.x series of kernels, my harddrives never 
> spin down 
> now.  I do not know what else doesn't sleep.  This is the 
> case with APM 
> (on a box that doesn't crash from it) as well as ACPI.  What could be 
> the cause?  I would like the system to go to sleep as much as 
> possible 
> when it is idle.

Well, I am not an expert on HD spin-down (yet). Under ACPI it's simple - we
don't have the power policy to tell the HDs to standby yet. Under APM, the
BIOS should be telling them to do so (I think) so if they're not spinning
down, then it's because Linux is accessing the disk. If I recall correctly,
syslog and/or atime were involved...?

You might try forcing a HD spindown with hdparm's -y option, and see if it
stays down, or spins back up for something.

> TrevEr Adams
      ^
Yeah, I noticed that right as I hit Send. Sorry. ;-)

Regards -- Andy

