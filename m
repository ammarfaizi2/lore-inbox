Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282229AbRKWUhX>; Fri, 23 Nov 2001 15:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282235AbRKWUhP>; Fri, 23 Nov 2001 15:37:15 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:3013 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S282229AbRKWUhB>; Fri, 23 Nov 2001 15:37:01 -0500
Message-ID: <3BFEB2DC.6040208@antefacto.com>
Date: Fri, 23 Nov 2001 20:34:36 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] remove trailing whitespace
In-Reply-To: <Pine.LNX.4.10.10111231440260.1920-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used sed, but yes the following does
the same as downloading and applying the patch:
find linux -type f | xargs perl -wi -pe 's/[<space><tab>]+$//'
(obviously replace <space> & <tab> with the appropriate chars).

Note also that after (bz2) compression the space saving drops
from 224,654 to 139,669 bytes, which is still good.

Padraig.

Mark Hahn wrote:

> 	find linux -type f | xargs perl -pe 's/\s+$/\n/'
> wouldn't something like this work?  seems generally easier,
> more compact, and probably more Linus-appetizing...
> 
> 
>>This (23MB! (5Mb compressed)) patch removes trailing whitespace from
>>all files in the kernel, thereby reducing size from 121,865,495 to
>>121,640,841. I.E. reducing size by 224,654 bytes. I don't know if it's
>>of any use, but it should be applied now if it is going to be done
>>at all.
>>
>>http://www.iol.ie/~padraiga/linux-2.5.0-strip-ws.diff.gz
>>
>>cheers,
>>Padraig.



