Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270728AbTGNRsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270729AbTGNRsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:48:55 -0400
Received: from www.team3s.com ([208.3.200.134]:11791 "EHLO
	speedracer.speedtoys.com") by vger.kernel.org with ESMTP
	id S270728AbTGNRsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:48:53 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: linux-kernel@vger.kernel.org,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Subject: Hotplug USB mouse bugs in 2.4+swsusp
Date: Fri, 11 Jul 2003 09:16:13 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200307110916.13785.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure if this is a general kernel issue, a hotplug issue, a USB 
issue, or a swsusp issue, so I'm hoping for guidance here.

I'm running 2.4.21 (+ latest ACPI, toshiba ACPI, and swsusp pre14) and 
to get my USB mouse working at all with swsusp I had to use hotplug.  
However, I'm having a number of problems.

1) 
The mouse, under normal operation at times of heavy CPU or disk usage, 
will be spontaneously lost.  No messages are issued.  Physically 
unplugging and re-plugging the mouse restores it.

2) 
No matter what I've tried, after switching to using hotplug 
(previously I had been using the 2.5 kernel w/o the hotplug daemon), 
I have been unable to get the internal pointer multiplexed into 
/dev/input/mice.  USB mouse shows up under /dev/input/mice and 
internal pointer shows up under /dev/psaux only.

3)
After suspend & resume, USB mouse is gone.  Physically replugging it 
doesn't help.  /etc/init.d/hotplug restart  fixes it.


Any ideas?  /proc cats, dmesgs, .configs, etc, available upon request.

Thanks much!

Eric


