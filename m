Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTJIAVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 20:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTJIAVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 20:21:41 -0400
Received: from gprs147-181.eurotel.cz ([160.218.147.181]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261831AbTJIAVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 20:21:40 -0400
Date: Thu, 9 Oct 2003 02:21:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: pmdisk & oldconfig -- bad interaction
Message-ID: <20031009002126.GA1192@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Theres usability problem with make oldconfig & pmdisk:

  Software Suspend (EXPERIMENTAL) (SOFTWARE_SUSPEND) [Y/n/?] y
  Suspend-to-Disk Support (PM_DISK) [Y/n/?] y
    Default resume partition (PM_DISK_PARTITION) [] (NEW)

Unfortunately at this point I do not know if it should be in /dev/hda1
or hda1 form (I guess its /dev/hda1), so I try to get some help. I
press ? <enter> and bang, partition is set to "?".

I'm not sure how to solve this. Maybe 

  Software Suspend (EXPERIMENTAL) (SOFTWARE_SUSPEND) [Y/n/?] y
  Suspend-to-Disk Support (PM_DISK) [Y/n/?] y
    Default resume partition in /dev/hdXX form (PM_DISK_PARTITION) [] (NEW)

is good idea? Anyway helptexts for text entries are useless in
oldconfig :-(.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
