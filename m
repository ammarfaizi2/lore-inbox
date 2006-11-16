Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWKPSaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWKPSaB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162131AbWKPSaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:30:00 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:19089 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1162117AbWKPSaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:30:00 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455CAE0F.1080502@s5r6.in-berlin.de>
Date: Thu, 16 Nov 2006 19:29:35 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mattia Dongili <malattia@linux.it>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home>
In-Reply-To: <20061116171715.GA3645@inferi.kami.home>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili wrote:
> got the following when removing ohci1394 (also happens in -mm1),
...
> ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[080046030227e7bb]
> ieee1394: Node removed: ID:BUS[20754571-38:0391]  GUID[00000000f8eb5067]

Hm, there is garbage in this node data. Moreover, your full logs show
that there was never another node added besides the host node. IOW the
second "Node removed" line shouldn't be there. Very strange.

> BUG: unable to handle kernel NULL pointer dereference at virtual address 000000a4
...
> EIP is at class_device_remove_attrs+0xd/0x34
...

Could you also test one or even better both of:
 - 2.6.19-rc5 plus
http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.19-rc5/2.6.19-rc5_ieee1394_v204_experimental.patch.bz2
(these are the same FireWire drivers as in -rc5-mm2)
and/ or
 - 2.6.19-rc5-mm2 minus
http://www.it.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/git-ieee1394.patch


Thanks so far,
-- 
Stefan Richter
-=====-=-==- =-== =----
http://arcgraph.de/sr/
