Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSJURZg>; Mon, 21 Oct 2002 13:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSJURZg>; Mon, 21 Oct 2002 13:25:36 -0400
Received: from 24-216-100-96.charter.com ([24.216.100.96]:35508 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S261524AbSJURZe>;
	Mon, 21 Oct 2002 13:25:34 -0400
Date: Mon, 21 Oct 2002 13:31:41 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: PoorMan's San
Message-ID: <20021021173141.GA22824@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Back on the Kernel list after a long hiatis.  Need some experienced
optinions.

Current Setup:

Linux Legato Backup server  (E1000 nic)   Linux-2.4.19-pre4
5xLinux NFS servers         (E1000 nic)   Linux-2.4.19-pre4

Legato mounts the NFS shares over a Gig ether and uses them as backup
media for non-offsite/non-longterm.  This works very well when NFS
behaves.

The probems is that every now and then the network/nfs just hang up for
a while and gets VERY slow.  Some research has been done and it seems
that the PCI latency is part of the problem, especially when IDE Raid
hits the disks hard, this can overrun the buffers on the GigE card.

I've got a test NFS server coming in and will look at upgrading the
kernel to 2.4.19-pre11 as there were some bugs associated with E1000 and
NFS I saw in pre-[7-9] area. I'm also considering trying to use
Network Block Device instead of NFS.  Has anyone tried this?

Any suggestions that doesn't involve hitting up a non-existant budget?


Robert



:wq!
---------------------------------------------------------------------------
Robert L. Harris                
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

