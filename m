Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273294AbRIUK4T>; Fri, 21 Sep 2001 06:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRIUKz7>; Fri, 21 Sep 2001 06:55:59 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:31365 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S272966AbRIUKzv>; Fri, 21 Sep 2001 06:55:51 -0400
Message-ID: <3BAB1BB5.6030800@antefacto.com>
Date: Fri, 21 Sep 2001 11:51:33 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: noexec-flag does not work in Linux 2.4.10-pre10
In-Reply-To: <Pine.GSO.4.21.0109201932220.5631-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>
>On Fri, 21 Sep 2001, Peter Bornemann wrote:
>
>>This is no problem for me but an inconvenience. If You see all
>>the x-flags You believe in the executability (is that right?), moreover,
>>as on my system executables are displayed in red colour, I feel my eyes
>>are deceived to some extent.
>>
>
>Then you've never used noexec on normal filesystems (after all, _that_
>is the intended use - prohibit execution of binaries from potentially
>unsafe place, and in that case you are interested in all mode bits, so
>you want them to be reported).
>

I wondered what you gain by noexec actually as there is always a way to
execute code you can read. For e.g. if you want to execute a binary from
/mnt/unsafe you can do (RH7.1):  /lib/ld-linux.so.2 /mnt/unsafe/hack.bin ?

>  Try to remount some normal fs noexec
>(_not_ one that contains mount(8), or you'll have really big trouble
>on hands).  Then look at it - exec bits are still there and they
>are still reported.
>
>>But, as umask=111 works, I will switch to that.
>>
>>Thanks a lot!
>>
>>Peter B
>>



