Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTAIS1l>; Thu, 9 Jan 2003 13:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbTAIS1l>; Thu, 9 Jan 2003 13:27:41 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:38094 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S266932AbTAIS1k>; Thu, 9 Jan 2003 13:27:40 -0500
Date: Thu, 9 Jan 2003 13:36:14 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: USB-storage/SCSI panic/error writing CF card
Message-ID: <20030109183614.GA1167@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.5.55
USB support & OHCI-HCD compiled in
scsi support compiled in
scsi disk support as a module
usb-storage as a module
no devfs

ASUS P4S533 (SiS645DX chipset)
P4 2GHz
1G PC2700 RAM
SanDisk SDDR-77 ImageMate Dual Card Reader (using only CF)

Writing to the card sometimes hangs the process when unmounting 

Sometimes the data IS written to the card first, then it hangs the process.

Sometimes the card is corrupt (cannot cd to the mountpoint -I/O error)
  /var/log/messages has several lines like:
  Jan  9 13:08:51 Master kernel: FAT: Filesystem panic (dev sd(8,1))
  Jan  9 13:08:51 Master kernel:     Directory 4: invalid cluster chain
  
Sometimes get kernel panic with ONLY these 2 lines:
  "Error handler thread not present at f7a57000 f7bf0d80 drivers/scsi/scsi-error.c 154"
  "In interrupt handler - not syncing"
  No messages in logs

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker
  #cooker = moderated Mandrake Cooker

