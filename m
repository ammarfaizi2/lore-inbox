Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314372AbSDRPHn>; Thu, 18 Apr 2002 11:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314373AbSDRPHm>; Thu, 18 Apr 2002 11:07:42 -0400
Received: from relay02.esat.net ([192.111.39.21]:46601 "EHLO relay02.esat.net")
	by vger.kernel.org with ESMTP id <S314372AbSDRPHl>;
	Thu, 18 Apr 2002 11:07:41 -0400
Message-ID: <3CBEE0AA.7060309@palamon.ie>
Date: Thu, 18 Apr 2002 16:05:14 +0100
From: Tony Clarke <sam@palamon.ie>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: VM Related question
In-Reply-To: <3CBE8FBB.8080108@palamon.ie> <3CBEC025.141CAA76@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>I have noticed with my current kernel that after the system is idle for
>>a while, say 10 hours or
>>so, that everything seems to be swapped out to disk. So when I come in
>>the next morning
>>it starts swapping everything like crazy in from disk. Is this a known
>>characteristic of the
>>VM. I seem to remember this with all 2.4 kernels tried to date.
>>
>>Whats the point of swapping out to disk in circumstances like this?
>>
>>Currently I am using 2.4.18-rc2-ac2, with apps like mozilla, dozen
>>xterms, xemacs, staroffice etc.
>>
>
>The kernel makes no decision to swap just because you left the
>machine.  But your distro probably runs "updatedb" at night.
>Updatedb reads all the directories in all your filesystems, so
>it tends to use a lot of cache.  This activity pushes
>lots of other stuff into swap.
>
Yep. That makes sense. /proc/slabinfo looks like

inode_cache        60311  60312    512 8616 8616    1
dentry_cache       60301  63930    128 2131 2131    1
buffer_head        35115  40620    128 1348 1354    1

this is on a 256mb machine.

Would I be right in saying that the only way that memory gets reclaimed 
, is by some process requesting memory
or by some process waking up and having a load of page faults?

Cheers,
Tony.


