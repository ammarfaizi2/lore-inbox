Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTFDTwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbTFDTwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:52:30 -0400
Received: from catfish.lcs.mit.edu ([18.111.0.152]:53481 "EHLO
	catfish.lcs.mit.edu") by vger.kernel.org with ESMTP id S264005AbTFDTw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:52:29 -0400
Date: Wed, 4 Jun 2003 16:04:54 -0400 (EDT)
From: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
To: linux-kernel@vger.kernel.org
cc: acpi-support@lists.sourceforge.net
Subject: sleep forever in ACPI mode S3
Message-ID: <Pine.GSO.4.10.10306041553200.2442-100000@catfish.lcs.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

echo 3 > /proc/acpi/sleep
 appears to work correctly on my IBM Thinkpad X20 -- except that it's
 impossible to wake the machine back up.
echo 1 > /proc/acpi/sleep
 has a similar problem -- ordinary keypresses don't wake the machine --
 but at least in this case the "power button" will bring the machine back.
 [neither the lid nor the sleep button do, though.]

Is this a known problem?  What keypresses are *supposed* to wake the
machine?  I looked through the code, but it looks like we punt off to the
ACPI firmware to do the actual sleep -- can anyone enlighten me on the
intended mechanism behind 'wake-from-sleep'?

[incidentally, i originally had the same problem others report with the
power button not only bringing the machine out of S1 but also rebooting
it: it was in fact acpid doing the reboot due to an easily-overlooked line
in its default.sh.  Previous posters have pointed to powerbtn.sh only.]
  --scott

[cc replies to me; i'm not on the list.]

explosives SEAL Team 6 mustard Pakistan shortwave ammunition immediate 
nuclear class struggle direct action East Timor Legion of Doom NSA 
                         ( http://cscott.net/ )

