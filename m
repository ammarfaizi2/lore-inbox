Return-Path: <linux-kernel-owner+w=401wt.eu-S933244AbXAACBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933244AbXAACBi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 21:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933242AbXAACBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 21:01:38 -0500
Received: from mail.tmr.com ([64.65.253.246]:36837 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932861AbXAACBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 21:01:37 -0500
Message-ID: <45986D2D.8090009@tmr.com>
Date: Sun, 31 Dec 2006 21:08:45 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Denis Vlasenko <vda.linux@googlemail.com>,
       Michael Tokarev <mjt@tls.msk.ru>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Raid 0 Swap?
References: <44FB5AAD.7020307@perkel.com> <44FBFFFC.90309@tls.msk.ru>  <Pine.LNX.4.61.0609041242350.17115@yvahk01.tjqt.qr>  <200609181150.23091.vda.linux@googlemail.com> <e1a7ee0c0612272106y5e22dd21uc3f2fde567ab7532@mail.gmail.com> <Pine.LNX.4.61.0612281011530.15825@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612281011530.15825@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Dec 28 2006 00:06, Mike Huber wrote:
>> I would like to point out one key argument against raid0 swap partitions,
>> which is that, should a drive failure occur, the least used programs in
>> memory are most drastically affected.  Unfortunately, in the case of a
>> drastic drive failure in a standalone server, one of the most likely
>> programs to be affected is getty, disallowing you from manually logging in.
> 
> However, the footprint of getty is rather small, so its chance to run is higher
> than an idle bigger task (dbus, resmgr, hal, perhaps cron or X)

RAID-0 swap is not the thing to run if reliability is a must, clearly. 
Interestingly, after a long fight with poor RAID-5 write speed, I moved 
my swap to RAID-10, only to find that recovery disks don't know how to 
use it. Tried Fedora and then a live CD (puppy, I think).

Detail on the RAID-5 performance thing in the linux-raid archives, won't 
rehash here.
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
