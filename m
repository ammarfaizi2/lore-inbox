Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbUKCXBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUKCXBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUKCW6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:58:42 -0500
Received: from mail.tmr.com ([216.238.38.203]:17415 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261954AbUKCWzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:55:54 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 03 Nov 2004 17:58:56 -0500
Organization: TMR Associates, Inc
Message-ID: <418962B0.3080806@tmr.com>
References: <yw1xis8nhtst.fsf@ford.inprovide.com><yw1xis8nhtst.fsf@ford.inprovide.com> <20041103152531.GA22610@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1099522050 5895 192.168.12.100 (3 Nov 2004 22:47:30 GMT)
X-Complaints-To: abuse@tmr.com
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
To: DervishD <lkml@dervishd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20041103152531.GA22610@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi all :)
> 
>  * Måns Rullgård <mru@inprovide.com> dixit:
> 
>>>>I'd tried to kill the zombie earlier but couldn't.
>>>>Isn't there some way to clean up a &^$#^#@)_ zombie?
>>>
>>>Kill the parent, is the only (portable) way.
>>
>>Perhaps not as portable, but another possible, though slightly
>>complicated, way is to ptrace the parent and force it to wait().
> 
> 
>     Or write a little program that just 'wait()'s for the specified
> PID's. That is perfectly portable IMHO. But I must admit that the
> preferred way should be killing the parent. 'init' will reap the
> children after that.

You can't wait() for the process, you have to use waitfor(), and the 
last time I tried that it didn't work, although I don't remember the 
symptom beyond that.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
