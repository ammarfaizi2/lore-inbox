Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRDPKHN>; Mon, 16 Apr 2001 06:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRDPKHD>; Mon, 16 Apr 2001 06:07:03 -0400
Received: from colorfullife.com ([216.156.138.34]:54279 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129242AbRDPKGs>;
	Mon, 16 Apr 2001 06:06:48 -0400
Message-ID: <3ADAC46B.7105E631@colorfullife.com>
Date: Mon, 16 Apr 2001 12:07:39 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linas@backlot.linas.org, linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first 2 problems aren't real problems (modify /etc/fstab, perhaps a
special ioctl could be added to raid and fsck stops the reconstruction)
- at most anoying, but clearly no bugs.

But the third one could be a bug:
> 
> Third problem: 
> 
> I just tried boot 2.4.3 today. (after an unclean shutdown) fsck runs 
> at a crawl on my RAID-1 volume. It would take all day (!! literally) 
> to fsck. The disk-drive activity light flashes about once a second, 
> maybe once every two seconds. (with a corresponding click from the 
> drive). 

Can you boot without the raid-1 volume?
Run top/vmstat during the fsck+reconstruction - I assume the system runs
out of memory and bdflush/kswapd are looping.

--	
	Manfred
