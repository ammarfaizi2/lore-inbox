Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266794AbSKUQP6>; Thu, 21 Nov 2002 11:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbSKUQP6>; Thu, 21 Nov 2002 11:15:58 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:52703 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S266794AbSKUQP5>;
	Thu, 21 Nov 2002 11:15:57 -0500
Date: Thu, 21 Nov 2002 11:23:04 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: MD Raid+devfs?
Message-ID: <20021121162304.GH9163@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Situation:

Built a filesystem, raid5 on a server running devfs with:

/dev/sdb2
/dev/sdc2
/dev/sde2
/dev/sdf2

/dev/sdd2 was out for RMA.  

Devfs remapped the drives at boot time as b-d.  I just had an
unscheduled downtime, unrelated to this, and took the opportunity to
re-install the drive.

Luckily as raid 5 it came back up because it remapped them b-f again
stickingm y disk in sdd.  This pushed the 4th disk back one spot too
many and out of the array, stuck an unformatted disk in the middle.
Figured it was going to completely trash my filesystem since the 3rd
disk was 4th and 4th was gone, but it recovered nicely (nice work MD
guys).

At any rate though I'm looking and wondering how bad it would be to put
in scsi/host0/bus0/target0/lun0/part2 instead of sdb2 for example.

Thoughts, theories, the "best practice" way to do this with devfs?

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

