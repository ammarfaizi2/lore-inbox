Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbRGFBPg>; Thu, 5 Jul 2001 21:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbRGFBP0>; Thu, 5 Jul 2001 21:15:26 -0400
Received: from vmail1.wmis.net ([216.109.195.1]:59397 "EHLO vmail1.wmis.net")
	by vger.kernel.org with ESMTP id <S265659AbRGFBPS>;
	Thu, 5 Jul 2001 21:15:18 -0400
From: Rick Hayner <rhayner@complink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15173.4373.265455.731576@rhayner.selfhost.com>
Date: Thu, 5 Jul 2001 21:15:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Problems playing audio cds  with ide-scsi installed. 
X-Mailer: VM 6.92 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello to all.

I have the following setup.
tyan s1590s motherboard, 64mb ram, two ide ports on board, amdk63d
processor.

I am running debian linux using kernel 2.2.19.

I have a Ricoh MP7120 cdrw drive.  This is an atapi drive.  Because of
this I need to use the ide-scsi driver along with the sg driver.

I have no trouble at all writing audio or data cds using cdrecord.
The  problem comes when I need to play an audio cd.  If I have just
put the cd in the drive, any audio cd player works fine.  However
after a stop command with either cdcd or cdtool, I must issue two cdcd
play commands in a row, or two cdplay commands in the case of cdtool
in order to get the cd to begin playing again.  

The cdrw drive is on the secondary port and it is a master.

I have the following append command in lilo.conf
append="hdc=ide-scsi"
If I remove  this command, and make /dev/cdrom point to /dev/hdc, the
problem disappears altogether.  I've looked in every log file I can
find on the system and cannot find any error messages anywhere.  The
audio cd players just don't do anything at all on the first play
command after a stop command.  I've read the ide documentation, and
there is very little said about ide-scsi.

Does anyone have any idea as to what on earth is happening here?

Thanks for any help.

Sincerely, 
-- 
Rick Hayner
rhayner@complink.net
Member spebsqsa, Baritone Kalamazoo Mall City Chorus.
Amateur radio station wa8jqv
