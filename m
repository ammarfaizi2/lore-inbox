Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbSKSTDz>; Tue, 19 Nov 2002 14:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbSKSTDy>; Tue, 19 Nov 2002 14:03:54 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:31484 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S267079AbSKSTDx>; Tue, 19 Nov 2002 14:03:53 -0500
Message-ID: <3DDA8C18.1000903@oracle.com>
Date: Tue, 19 Nov 2002 20:08:08 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Oracle 9.2 OOMs again at startup in 2.5.4[78]
References: <3DDA4921.30403@oracle.com> <3DDA88F9.41F41CB9@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Alessandro Suardi wrote:
> 
>>...just like it did a few kernels ago (the current->mm issue in 2.5.19
>>  that eventually got fixed in 2.5.30 or thereabouts, introduced for the
>>  bk-enabled by cset 1.373.221.1).
> 
> 
> According to the web interface, 1.373.221.1 is 
> 
> "This patch lets more devices hook up to USB 2.0 hubs, stuff
> like keyboards, mice, hubs that hasn't worked yet"
> 
> so, errr.

The web interface seems to be at fault (or is it your fingers ;)
  from my saved mail with Linus and yourself I have...

--------------------------------------------------------------------------
The patch you actually include seems to be a combination of

     ChangeSet 1.373.204.73 2002/05/28 22:01:57 torvalds@home.transmeta.com
       Remove re-use of "struct mm_struct" at execve() time.

       This will eventually allow us to copy argc/argv without
       any intermediate storage (removing current argument size
       limitations).

and

     ChangeSet 1.373.221.1 2002/05/28 22:55:46 torvalds@home.transmeta.com
       Allocate new mm_struct for execve() early, so that we have
       access to it by the time we start copying arguments.
-------------------------------------------------------------------------

> 
>>I'll go building a 2.5.44 kernel (think it's the only one I didn't have
>>  too much trouble building / booting in the 2.5.4x series before .47)
>>  and see whether it works or not.
> 
> 
> An `strace -f' of the startup process might reveal something.

will also try that - tomorrow, now time's over @ office :)


Thanks,

--alessandro

  "Seems that you can't get any more than half free"
        (Bruce Springsteen, "Straight Time")

