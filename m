Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVCaJtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVCaJtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVCaJro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:47:44 -0500
Received: from smail4.alcatel.fr ([64.208.49.167]:40603 "EHLO
	smail4.alcatel.fr") by vger.kernel.org with ESMTP id S261265AbVCaJpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:45:09 -0500
Message-ID: <424BC67A.5000001@linux-fr.org>
Date: Thu, 31 Mar 2005 11:44:26 +0200
From: Jean Delvare <khali@linux-fr.org>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.7.6) Gecko/20050325
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.12-rc1-mm3] BUG: atomic counter underflow in smbfs
References: <20050330201818.GA18967@ens-lyon.fr> <20050330124456.3da2a2b8.akpm@osdl.org> <20050330205837.GF10278@ens-lyon.fr>
In-Reply-To: <20050330205837.GF10278@ens-lyon.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Alcanet-MTA-scanned-and-authorized: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benoit,

>>>I had the following BUG with 2.6.12-rc1-mm3:
>>>
>>>remote host is running 2.6.12-rc1-mm1 with samba 3.0.13.
>>>
>>>[23156.357178] smb_lookup: find musique/Pink_Floyd-Dark_Side_of_the_Moon
>>>failed, error=-512
>>>[23157.057501] BUG: atomic counter underflow at:
>>>[23157.057508]  [<c0103c27>] dump_stack+0x17/0x20
>>>[23157.057516]  [<e0ed0f31>] smb_rput+0x51/0x60 [smbfs]
>>>[23157.057530]  [<e0ecd497>] smb_proc_query_cifsunix+0x77/0xa0 [smbfs]
>>>[23157.057538]  [<e0eca14c>] smb_newconn+0x2bc/0x310 [smbfs]
>>>[23157.057546]  [<e0ed05ac>] smb_ioctl+0xfc/0x100 [smbfs]
>>>[23157.057554]  [<c0162188>] do_ioctl+0x48/0x70
>>>[23157.057559]  [<c01622f9>] vfs_ioctl+0x59/0x1b0
>>>[23157.057563]  [<c0162489>] sys_ioctl+0x39/0x60
>>>[23157.057582]  [<c0102d8f>] sysenter_past_esp+0x54/0x75
>>
>>Oh dear.  That warning is not necessarily telling us that there's a serious
>>problem - often it's fairly harmless.  Did the filesytem misbehave in any
>>other manner?
>>
> 
> It was stucked (couldn't do anything inside) but i was able to umount
> it.

Already reported, discussed and fixed.

http://bugme.osdl.org/show_bug.cgi?id=4403
http://marc.theaimsgroup.com/?l=linux-kernel&m=111182797913419&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=111184280803027&w=2

-- 
Jean Delvare
