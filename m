Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVAFR0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVAFR0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVAFR0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:26:15 -0500
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:58287 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S262921AbVAFR0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:26:05 -0500
Date: Thu, 6 Jan 2005 08:26:11 -0900
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: Kernel freeze: 2.6.10 SMP, Promise TX4, software RAID
Message-ID: <20050106172611.GA22820@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I've recently had the same problem with two different systems while 
trying to upgrade the RAID drives.  Both systems are dual processor 
Pentium machines (one a Dual Xeon, one a dual PIII), and both have new 
Promise TX4 cards to support new SATA drives.  I'm using the 2.6.10 
kernel software RAID-5.

I can create the array, but when I try to put a filesystem on it using 
'mkfs.ext3', the system inevitably hangs and 'ataXX: command timeout' 
appears on the console before it's completely locked up (no 
Ctrl-Alt-SysReq, no caps lock, etc.).  The timeouts do not happen on the 
same ata interface each time, so I don't think it's the controllers or 
the drives.

On one system I finally just replaced the motherboard with a single 
processor K7 board and the whole thing has been running well for about a 
week now.  On the other system (the Xeon box), 'noapic' passed to the 
kernel has allowed me to actually put a filesystem on the newly created 
RAID.  I can't remember if I tried 'noapic' on the first system because 
I was trying so many different things.

Now I'm a bit nervous about both systems and I'm wondering what the 
appropriate solution is (just use 'noapic', get newer motherboards, 
don't use SMP, etc.)?  Is there a patch that's reported to fix this, or 
are these problems due to insufficient support for SATA controllers on 
the older motherboards I've tried?

I'm happy to provide any details, if it might help.

Thanks,

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu (work)
Intl. Arctic Research Center            cswingle@gmail.com (personal)
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

