Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbUKDTdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUKDTdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbUKDTdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:33:15 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21636 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262650AbUKDT37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:29:59 -0500
Message-ID: <418A83EA.9090106@tmr.com>
Date: Thu, 04 Nov 2004 14:32:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
CC: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
References: <418962B0.3080806@tmr.com><418962B0.3080806@tmr.com> <20041104102345.GA23673@DervishD>
In-Reply-To: <20041104102345.GA23673@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Bill :)
> 
>  * Bill Davidsen <davidsen@tmr.com> dixit:
> 
>>>   Or write a little program that just 'wait()'s for the specified
>>>PID's. That is perfectly portable IMHO. But I must admit that the
>>>preferred way should be killing the parent. 'init' will reap the
>>>children after that.
>>
>>You can't wait() for the process, you have to use waitfor(), and the 
>>last time I tried that it didn't work, although I don't remember the 
>>symptom beyond that.
> 
> 
>     You can't wait for other's children. OTOH, if we talk about your
> children, you can do wait() or waitpid() (I assume that you referred
> to waitpid(), since there isn't waitfor() AFAIK). The only difference
> is that wait suspends the process until information from a child is
> available.

Yes, thank you, I was thinking "wait for the PID" and typed that.
> 
>     If you are talking about others' children, then your call to
> waitpid() (or wait()) failed with ECHILD: not your child.

That's what happened when I tried it a few months ago. I suppose one 
could try sending a SIGCHLD to the parent and see if it does something 
helpful.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
