Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTJAUQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTJAUQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:16:37 -0400
Received: from main.gmane.org ([80.91.224.249]:45225 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262351AbTJAUQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:16:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: PCI woes on an old Intel AltServer
Date: Wed, 01 Oct 2003 14:16:30 -0600
Message-ID: <blfcmv$q02$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to get linux (redhat 9) to recognize the AIC-7870 scsi controller 
on an old Intel AltServer but it doesn't load the module.  The PCI info 
seems screwed up.  Any suggestions?  aic7xxx=versbose doesn't seem to 
generate any output.

[root@install proc]# cat pci
PCI devices found:
   Bus  0, device   0, function  0:
     Class ffff: Intel Corp. 82434LX [Mercury/Neptune] (rev 255).
       Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
   Bus  0, device   2, function  0:
     Class ffff: Intel Corp. 82375EB (rev 255).
       Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
   Bus  0, device   9, function  0:
     Class ffff: Cirrus Logic GD 5430/40 [Alpine] (rev 255).
       IRQ 11.
       Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
       Prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
   Bus  0, device  10, function  0:
     Class ffff: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 255).
       IRQ 9.
       Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
       Non-prefetchable 32 bit memory at 0xffe7e000 [0xffe7efff].
       I/O at 0xff00 [0xff3f].
       Non-prefetchable 32 bit memory at 0xffc00000 [0xffcfffff].
   Bus  0, device  11, function  0:
     Class ffff: Adaptec AHA-294x / AIC-7870 (rev 255).
       IRQ 10.
       Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
       I/O at 0xfc00 [0xfcff].
       Non-prefetchable 32 bit memory at 0xffe7f000 [0xffe7ffff].
[root@install proc]# lspci -vv
00:00.0 Class ffff: Intel Corp. 82434LX [Mercury/Neptune] (rev ff) 
(prog-if ff)
         !!! Unknown header type 7f

00:02.0 Class ffff: Intel Corp. 82375EB (rev ff) (prog-if ff)
         !!! Unknown header type 7f

00:09.0 Class ffff: Cirrus Logic GD 5430/40 [Alpine] (rev ff) (prog-if ff)
         !!! Unknown header type 7f

00:0a.0 Class ffff: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev ff) 
(prog-if ff)
         !!! Unknown header type 7f

00:0b.0 Class ffff: Adaptec AHA-294x / AIC-7870 (rev ff) (prog-if ff)
         !!! Unknown header type 7f


