Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWJaMFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWJaMFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 07:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161643AbWJaMFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 07:05:50 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:31914 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161642AbWJaMFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 07:05:49 -0500
Message-ID: <45473F04.30909@in.ibm.com>
Date: Tue, 31 Oct 2006 17:48:12 +0530
From: supriya kannery <supriyak@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Incorrect order of last two arguments of ptrace for requests
 PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
References: <453F421A.6070507@in.ibm.com>	<20061025.134354.92582918.davem@davemloft.net>	<4541B33D.6090704@in.ibm.com> <20061027.001037.74128782.davem@davemloft.net>
In-Reply-To: <20061027.001037.74128782.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:

>From: supriya kannery <supriyak@in.ibm.com>
>Date: Fri, 27 Oct 2006 12:50:29 +0530
>
>  
>
>>    I checked in gdb and ltrace code. None of them are using PPC_PTRACE* 
>>options to get register values.
>>Man page also doesn't mention these options. Once this is fixed, these 
>>options could be added to man page also.
>>
>>Irrespective of whether we fix this, documentation of these options in 
>>manpage will clarify its usage I guess.
>>    
>>
>
>Yep.  Are the no current users at all?  That's strange...
>  
>
David,
I guess the reasons for its less (or no) usage could be
1. These options are not documented in manpage
2. The usage is different from the general format of ptrace
3.  These are used for copying all the registers. Most applications will 
require data from a single addr/register at a time and can get this data 
from a specific register/address using PEEKTEXT or POKETEXT.

We could align these options with the general format of ptrace and then 
document in manpage mentioning the relevant kernel version

(like what we have for PTRACE_O_TRACESYSGOOD in which kernel version is 
mentioned)
PTRACE_O_TRACESYSGOOD (since Linux 2.4.6)

Thanks, Supriya



