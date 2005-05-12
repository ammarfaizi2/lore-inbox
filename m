Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVELBxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVELBxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVELBxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 21:53:41 -0400
Received: from animx.eu.org ([216.98.75.249]:34962 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261264AbVELBxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 21:53:39 -0400
Date: Wed, 11 May 2005 21:52:20 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Bugs in 2.6.12-rc kernels
Message-ID: <20050512015220.GA31634@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) This bug existed in 2.6.10, 2.6.11.x (x >= 0) and 2.6.12-rcx (x >= 2)
The kernel OOPSes when attempting to unload ide-scsi.  At this moment, I do
not have a system using ide-scsi that doesn't load proprietary modules,
however, I don't believe that matters.

2) One key on a PC/AT keyboard port does not function. under 2.6.12-rc
kernels (rc1 not tested).  These keys work when using a 2.6.11 series kernel
or a USB keyboard.

The key, at the console shows it's code as as 0xe0 0x5c (press) 0xe0 0xdc
(release) when used on 2.6.11 or earlier.  Under 2.6.12-rc2 or newer, no key
press is ever reported (using showkey -s.  when using showkey, I see keycode
126)

3) I put together a boot kernel/initrd using 2.6.12-rc2 (also tested
2.6.12-rc4) which seems to work, except that pcmcia does not function
properly.  When pcmcia.ko gets loaded, it is unable to register it's char
dev.  I'm not sure why this is.  2.6.11.8 worked fine with no modifications
to the system.  This is a system designed to boot from floppy minimally,
search for a device which has some files that populates a tmpfs filesystem
which becomes the root filesystem.  This module is loaded from the tmpfs
filesystem.  Module-init-tools version is 3.2-pre (Not sure if this makes a
difference).  I tested this on a notebook that I have.  I also have this
same kernel version installed which works fine.  It could be a different
version of module-init-tools, but I'm unsure at this point (I do not have
access to the notebook at this time.

---
I will have access to the machines above tomorrow (provided I have time for
testing).

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
