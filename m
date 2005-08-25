Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVHYN0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVHYN0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVHYN0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:26:30 -0400
Received: from node1.80686-net.de ([194.54.168.119]:51693 "EHLO
	mx1.80686-net.de") by vger.kernel.org with ESMTP id S964974AbVHYN0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:26:30 -0400
From: Manuel Schneider <root@80686-net.de>
To: linux-kernel@vger.kernel.org
Subject: Question about usb-storage: Sometimes partitions are not recognized.
Date: Thu, 25 Aug 2005 15:26:27 +0200
User-Agent: KMail/1.8
Cc: kristoff.meller@gmx.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508251526.27598.root@80686-net.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

using two different USB memory cardreader I have a problem which I am able to 
reproduce on serveral machines (x86 and x86_64, Kernel 2.6.x) and with 
different memory cards (Compact Flash, SD-Card, Sony Memory-Stick):
When I plug them in, they will be recognized by hotplug (I'm using udev), the 
module usb-storage will be loaded and the device nodes are created.

BUT: There is normally just ONE device node for the disc block device.
Partitions are not available.
I can "solve" this by just starting fdisk (and shutting it down again without 
changing anything) on the given block device - after that, all the partitions 
are available. So it seems to me that on the recognition of the disc block 
device either the partition table will not be read or the USB device (maybe 
it depends on the cardreader) is to slow to come up with the data.
When fdisk is reading the partition table everything works well, but this is 
obviously no option.

Other USB memories (eg. an USB memory stick) work well, I experience these 
problem only on these two cardreaders.

Is there a possibility to tweak unusual_devs.h to get rid of these problems? I 
could insert the maufacturer and product IDs, but I'm not common with the 
available options. Maybe you could give me some pointers about them or other 
solutions on this.

Thanks and greets,

Manuel
-- 
Manuel Schneider
root@80686-net.de
http://www.80686-net.de/

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCM d-- s:- a? C++$ UL++++ P+> L+++>$ E- W+++$ N+ o-- K- w--$ O+ M+ V
PS+ PE- Y+ PGP+ t 5 X R UF++++ !tv b+> DI D+ G+ e> h r y++ 
------END GEEK CODE BLOCK------
