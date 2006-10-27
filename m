Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946048AbWJ0HIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946048AbWJ0HIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 03:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946050AbWJ0HIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 03:08:46 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:65464 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1946048AbWJ0HIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 03:08:45 -0400
Message-ID: <4541B33D.6090704@in.ibm.com>
Date: Fri, 27 Oct 2006 12:50:29 +0530
From: supriya kannery <supriyak@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Incorrect order of last two arguments of ptrace for requests
 PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
References: <453F421A.6070507@in.ibm.com> <20061025.134354.92582918.davem@davemloft.net>
In-Reply-To: <20061025.134354.92582918.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:

>From: supriya kannery <supriyak@in.ibm.com>
>Date: Wed, 25 Oct 2006 16:23:14 +0530
>
>  
>
>>If we exchange the last two arguments like,
>>
>> ptrace (PPC_PTRACE_GETREGS, pid, &reg[0], 0);
>>
>>it works!
>>    
>>
>
>Please make sure that programs, such as gdb, aren't using the reversed
>argument order.  If they are, you cannot "fix" this as it will break
>all such applictions.
>  
>
David,
    I checked in gdb and ltrace code. None of them are using PPC_PTRACE* 
options to get register values.
Man page also doesn't mention these options. Once this is fixed, these 
options could be added to man page also.

Irrespective of whether we fix this, documentation of these options in 
manpage will clarify its usage I guess.
Thanks, Supriya
