Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbUKCXoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbUKCXoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUKCXQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:16:05 -0500
Received: from mail.tmr.com ([216.238.38.203]:21767 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261989AbUKCXJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:09:31 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 03 Nov 2004 18:12:32 -0500
Organization: TMR Associates, Inc
Message-ID: <418965E0.8070508@tmr.com>
References: <200411031426.23880.gheskett@wdtv.com><200411031426.23880.gheskett@wdtv.com> <20041103194226.GA23379@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1099522867 6038 192.168.12.100 (3 Nov 2004 23:01:07 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Gene Heskett <gheskett@wdtv.com>, linux-kernel@vger.kernel.org,
       Valdis.Kletnieks@vt.edu,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
To: DervishD <lkml@dervishd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20041103194226.GA23379@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Gene :)
> 
>  * Gene Heskett <gheskett@wdtv.com> dixit:
> 
>>>Traditionally, a common cause for such wedging was a lost/misplaced
>>>interrupt from an I/O operation, so a read()/write()/ioctl() call
>>>wouldn't return because the device hadn't reported it completed.
>>>(tape drives were notorious for this). Often, power-cycling the I/O
>>>device would cause an unsolicited interrupt to be generated, which
>>>would clear the "waiting for interrupt" issue and allow the process
>>>to return....
>>
>>Well, since the "device", a bt878 based Haupagge tv card is sitting in 
>>a pci socket, thats even more drastic than a reboot.
> 
> 
>     Do you mean your Hauppage got stuck in disk-sleep state? Wow,
> that's sound *weird*...
> 
>     I think that the parent (which is whatever process did the fork
> when you clicked your mouse) is still alive and forgetting to do the
> 'wait()' for its children.

It would be good to know what the PPID is, from ps or similar. Things 
from X are a pain, the parent is often something you don't want to kill. 
Sometimes you can reparent from command line, "bash -c foo&" or similar, 
so the parent can be killed without logging out.

I would swear that the parent *is* init in some cases, which is puzzling 
since they should be reaped.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
