Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUHZMJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUHZMJC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUHZMD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:03:58 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:55209
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266460AbUHZL5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:57:43 -0400
Message-ID: <412DD033.6000903@bio.ifi.lmu.de>
Date: Thu, 26 Aug 2004 13:57:39 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Diego Calleja <diegocg@teleline.es>, John McGowan <jmcgowan@inch.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8.1: memory leak? cdrecord problem?
References: <20040821172646.GA8781@localhost.localdomain> <20040821194457.38920e99.diegocg@teleline.es> <41281496.8080800@kolivas.org>
In-Reply-To: <41281496.8080800@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Con Kolivas wrote:

>> Yes, there's a memory leak, you can try 2.6.8.1-mm3
>> or apply the fix yourself (I think it's this one:
>> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/broken-out/bio_uncopy_user-mem-leak.patch 
>> )
> 
> 
> That wont do by itself. It only fixes the memory leak. You _also_ need 
> this patch for audio cds to not be stuffed:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/broken-out/bio_uncopy_user-mem-leak-fix.patch 

it doesn't work, even with these two patches applied. I tried to burn
a DVD image (3.5GB) with kernel 2.6.8.1 including those patches and
again the memory run full until the kernel started killing processes.
Unfortunately the host always crashes before it writes the messages
to the log files, but I saw some messages about "cpu0..." and DMA.


I was running "cdrecord -sao dev=ATAPI:/dev/cdrecorder -v 2.4.img"
on a NEC ND1300A.

Can I debug/provide more info?

BTW, the bio.c from 2.6.9rc1 and 2.6.8.1 don't differ, so I assume it's
still unfixed in 2.6.9-rc1, too...?

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

