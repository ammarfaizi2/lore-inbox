Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWEERKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWEERKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWEERKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:10:22 -0400
Received: from [65.205.244.70] ([65.205.244.70]:8866 "EHLO
	mail1.dmz.sj.pioneer-pra.com") by vger.kernel.org with ESMTP
	id S1751177AbWEERKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:10:20 -0400
From: Jason Schoonover <jasons@pioneer-pra.com>
To: linux-kernel@vger.kernel.org
Subject: High load average on disk I/O on 2.6.17-rc3
Date: Fri, 5 May 2006 10:10:19 -0700
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605051010.19725.jasons@pioneer-pra.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm not sure if this is the right list to post to, so please direct me to the 
appropriate list if this is the wrong one.

I'm having some problems on the latest 2.6.17-rc3 kernel and SCSI disk I/O.  
Whenever I copy any large file (over 500GB) the load average starts to slowly 
rise and after about a minute it is up to 7.5 and keeps on rising (depending 
on how long the file takes to copy).  When I watch top, the processes at the 
top of the list are cp, pdflush, kjournald and kswapd.

I just recently upgraded the box, it used to run Redhat 9 with kernel 2.4.20 
just fine.  This problem did not show up with 2.4.20.  I just recently 
installed Debian/unstable on it and that's when the problems started showing 
up.

Initially the problem showed up on debian's 2.6.15-1-686-smp kernel pkg, so I 
upgraded to 2.6.16-1-686; same problem, I then downloaded 2.6.16.12 from 
kernel.org and finally ended up downloading and compiling 2.6.17-rc3 and same 
problem occurs.

The hardware is a Dell PowerEdge 2650 Dual Xeon 2.4GHZ/2GB RAM, the hard drive 
controller is (as reported by lspci):

0000:04:08.1 RAID bus controller: Dell PowerEdge Expandable RAID Controller 
3/Di (rev 01)
0000:05:06.0 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)
0000:05:06.1 SCSI storage controller: Adaptec RAID subsystem HBA (rev 01)

The PERC RAID configuration is four 136GB SCSI drives RAID5'd together.

Can anybody help me out here?  Maybe I'm doing something wrong with the 
configuration.  Any help/suggestions would be great.

Thanks,
Jason Schoonover
