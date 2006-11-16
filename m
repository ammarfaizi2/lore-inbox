Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932850AbWKPN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbWKPN3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 08:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWKPN3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 08:29:31 -0500
Received: from zeus.pimb.org ([80.68.88.21]:37391 "EHLO zeus.pimb.org")
	by vger.kernel.org with ESMTP id S932850AbWKPN3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 08:29:31 -0500
Date: Thu, 16 Nov 2006 13:52:10 +0000
From: Jody Belka <lists-lkml@pimb.org>
To: lkml <linux-kernel@vger.kernel.org>,
       suspend-devel <suspend-devel@lists.sourceforge.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>
Subject: problem after s2ram restore with password-protected hdd
Message-ID: <20061116135210.GR2808@pimb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please cc me on any reply, as i'm not subscribed]

I tried to use s2ram today on my Dell Inspiron 6000, but i'm having problems
after wake-up when I have the hard drives internal password enabled (the
normal state for this machine). If i turn the password off, everything works
fine. I note that the password screen doesn't appear during wake-up, although
the bios help text implies that it should do.

Well, works fine as long as I follow the advice at en.opensuse.org/S2ram
and don't include vga=795 on the command-line, as I have an ATI Radeon
graphics chipset. annoying, although I am in X usually anyway. Any news on
that front?


J
-- 
Jody Belka
<knew (at) pimb (dot) org>



uname -a: Linux atlas 2.6.18-rc6-local-evms #1 PREEMPT Tue Sep 12 14:37:12 BST
2006 i686 GNU/Linux


s2ram -i:
=====================
This machine can be identified by:
    sys_vendor   = "Dell Inc."
    sys_product  = "Inspiron 6000                   "
    sys_version  = ""
    bios_version = "A09"
See http://en.opensuse.org/S2ram for details.

If you report a problem, please include the complete output above.
=====================


netconsole log (trimmed, it went on for 8 megs):

[  203.368000] netconsole: network logging started

<<< s2ram >>>

[  217.372000] Stopping tasks: ========================================================|

<<< wake-up >>>

[  231.680000] ata2.00: configured for UDMA/33
[  231.712000] ata1.00: configured for UDMA/100
[  231.712000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[  231.712000] sda: Write Protect is off
[  231.712000] SCSI device sda: drive cache: write back
[  233.200000] b44: eth0: Link is up at 100 Mbps, full duplex.
[  233.200000] b44: eth0: Flow control is off for TX and off for RX.

<<< at this point I triggered some disk activity with a 'ls /' >>>

[  243.412000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.412000] ata1.00: (BMDMA stat 0x0)
[  243.412000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.416000] ata1: EH complete
[  243.416000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.416000] ata1.00: (BMDMA stat 0x0)
[  243.416000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.416000] ata1: EH complete
[  243.416000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.416000] ata1.00: (BMDMA stat 0x0)
[  243.416000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.416000] ata1: EH complete
[  243.420000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.420000] ata1.00: (BMDMA stat 0x0)
[  243.420000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.420000] ata1: EH complete
[  243.420000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.420000] ata1.00: (BMDMA stat 0x0)
[  243.420000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.420000] ata1: EH complete
[  243.420000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.420000] ata1.00: (BMDMA stat 0x0)
[  243.420000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.424000] sd 0:0:0:0: SCSI error: return code = 0x08000002
[  243.424000] sda: Current: sense key: Aborted Command
[  243.424000]     Additional sense: No additional sense information
[  243.424000] end_request: I/O error, dev sda, sector 39892208
[  243.424000] device-mapper: bbr: dm-bbr: device 254:0: I/O failure on sector 39619103. Scheduling for retry.
[  243.424000] ata1: EH complete
[  243.424000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[  243.424000] sda: Write Protect is off
[  243.428000] SCSI device sda: drive cache: write back
[  243.428000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[  243.428000] sda: Write Protect is off
[  243.428000] SCSI device sda: drive cache: write back
[  243.436000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.436000] ata1.00: (BMDMA stat 0x0)
[  243.436000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.436000] ata1: EH complete
[  243.436000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.436000] ata1.00: (BMDMA stat 0x0)
[  243.436000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.436000] ata1: EH complete
[  243.436000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.436000] ata1.00: (BMDMA stat 0x0)
[  243.436000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.440000] ata1: EH complete
[  243.440000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  243.440000] ata1.00: (BMDMA stat 0x0)
[  243.440000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.440000] ata1: EH complete
[  243.440000] ata1.00: limiting speed to UDMA/66
[  243.440000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  243.440000] ata1.00: (BMDMA stat 0x0)
[  243.440000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.440000] ata1: soft resetting port
[  243.596000] ata1.00: configured for UDMA/66
[  243.596000] ata1: EH complete
[  243.596000] ata1.00: limiting speed to UDMA/44
[  243.596000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  243.596000] ata1.00: (BMDMA stat 0x0)
[  243.596000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.600000] ata1: soft resetting port
[  243.756000] ata1.00: configured for UDMA/44
[  243.756000] sd 0:0:0:0: SCSI error: return code = 0x08000002
[  243.756000] sda: Current: sense key: Aborted Command
[  243.756000]     Additional sense: No additional sense information
[  243.756000] end_request: I/O error, dev sda, sector 39892208
[  243.756000] ata1: EH complete
[  243.760000] ata1.00: limiting speed to UDMA/33
[  243.760000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  243.760000] ata1.00: (BMDMA stat 0x0)
[  243.760000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.760000] ata1: soft resetting port
[  243.916000] ata1.00: configured for UDMA/33
[  243.916000] ata1: EH complete
[  243.916000] ata1.00: limiting speed to UDMA/25
[  243.916000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  243.916000] ata1.00: (BMDMA stat 0x0)
[  243.916000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  243.916000] ata1: soft resetting port
[  244.072000] ata1.00: configured for UDMA/25
[  244.072000] ata1: EH complete
[  244.072000] ata1.00: limiting speed to UDMA/16
[  244.072000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  244.072000] ata1.00: (BMDMA stat 0x0)
[  244.072000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  244.076000] ata1: soft resetting port
[  244.232000] ata1.00: configured for UDMA/16
[  244.232000] ata1: EH complete
[  244.232000] ata1.00: limiting speed to PIO4
[  244.232000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  244.232000] ata1.00: (BMDMA stat 0x0)
[  244.232000] ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 0x51 err 0x4 (device error)
[  244.232000] ata1: soft resetting port
[  244.388000] ata1.00: configured for PIO4
[  244.388000] ata1: EH complete
[  244.392000] ata1.00: limiting speed to PIO3
[  244.392000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  244.392000] ata1.00: tag 0 cmd 0x20 Emask 0x1 stat 0x51 err 0x4 (device error)
[  244.392000] ata1: soft resetting port
[  244.548000] ata1.00: configured for PIO3
[  244.548000] ata1: EH complete
[  244.548000] ata1.00: limiting speed to PIO2
[  244.548000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  244.548000] ata1.00: tag 0 cmd 0x20 Emask 0x1 stat 0x51 err 0x4 (device error)
[  244.548000] ata1: soft resetting port
[  244.708000] ata1.00: configured for PIO2
[  244.708000] sd 0:0:0:0: SCSI error: return code = 0x08000002
[  244.708000] sda: Current: sense key: Aborted Command
[  244.708000]     Additional sense: No additional sense information
[  244.708000] end_request: I/O error, dev sda, sector 39892208
[  244.708000] ata1: EH complete
[  244.708000] device-mapper: bbr: dm-bbr: device 254:0: Trying to remap bad sector 39619103 to sector 137
[  244.708000] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[  244.712000] ata1.00: limiting speed to PIO1
[  244.712000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  244.712000] ata1.00: tag 0 cmd 0x20 Emask 0x1 stat 0x51 err 0x4 (device error)
[  244.712000] ata1: soft resetting port
[  244.868000] ata1.00: configured for PIO1
[  244.868000] ata1: EH complete
[  244.868000] ata1.00: limiting speed to PIO0
[  244.868000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  244.868000] ata1.00: tag 0 cmd 0x20 Emask 0x1 stat 0x51 err 0x4 (device error)
[  244.872000] ata1: soft resetting port
[  245.028000] ata1.00: configured for PIO0
[  245.028000] ata1: EH complete
[  245.032000] ata1.00: speed down requested but no transfer mode left
[  245.032000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  245.032000] ata1.00: tag 0 cmd 0x20 Emask 0x1 stat 0x51 err 0x4 (device error)
[  245.032000] ata1: EH complete
[  245.032000] ata1.00: speed down requested but no transfer mode left
[  245.032000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  245.032000] ata1.00: tag 0 cmd 0x20 Emask 0x1 stat 0x51 err 0x4 (device error)
[  245.032000] ata1: EH complete
[  245.032000] ata1.00: speed down requested but no transfer mode left
[  245.032000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  245.032000] ata1.00: tag 0 cmd 0x20 Emask 0x1 stat 0x51 err 0x4 (device error)
[  245.036000] ata1: EH complete
[  245.036000] ata1.00: speed down requested but no transfer mode left
[  245.036000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[  245.036000] ata1.00: tag 0 cmd 0x20 Emask 0x1 stat 0x51 err 0x4 (device error)
[  245.036000] sd 0:0:0:0: SCSI error: return code = 0x08000002
[  245.036000] sda: Current: sense key: Aborted Command
[  245.036000]     Additional sense: No additional sense information
[  245.036000] end_request: I/O error, dev sda, sector 273242
[  245.036000] ata1: EH complete

