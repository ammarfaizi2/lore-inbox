Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270695AbTHJVFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTHJVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:05:39 -0400
Received: from miranda.zianet.com ([216.234.192.169]:30988 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S270695AbTHJVF3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:05:29 -0400
Message-ID: <3F36B341.7@zianet.com>
Date: Sun, 10 Aug 2003 15:04:01 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Dave Jones <davej@redhat.com>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org
Subject: Re: Machine check expection panic
References: <3F3182B5.3040301@zianet.com.suse.lists.linux.kernel> <20030807002722.GA3579@suse.de.suse.lists.linux.kernel> <p73ekzynuxt.fsf@oldwotan.suse.de> <3F35FE5B.7060003@zianet.com> <20030810130752.GB586@wotan.suse.de>
In-Reply-To: <20030810130752.GB586@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Out of curiosity I decided to try this on some other Athlon
systems I have.  I tried it on a dual Athlon MP 2400(2GHz)
system with a Tyan 2462 motherboard.  Also I tried it on a
single Athlon XP 1800 with a Asus A7V motherboard.  They
both booted fine with the 2.6.0-test2 kernel and the machine
exception code in it.  So I am thinking either it is something
with the older CPU's or the CPU is actually borked.  Like I said
though I have been using those 1.2GHz processors for a long time
with no problems.

Steve

Andi Kleen wrote:

>>The CPU's aren't overclocked and have worked fine for
>>me under much heavier loads than booting a kernel for
>>    
>>
>
>It could be corrected ECC errors in the cache. If that
>happens I would consider it a hardware problem
>
>(now hidden with the disabled bank).
>
>  
>
>>at least a year. Using the 2.4 kernel that is. Once
>>I remove the exception code from the kernel it boots
>>fine and runs fine under any load I put it under.
>>    
>>
>
>I maintain that such a magic hack needs at least a big fat comment.
>
>I still find the change very suspicious, there isn't any errata that 
>says that bank 0 is bad on Athlon.
>
>Also disabling a whole bank just for some buggy CPUs is quite a sledgehammer,
>it would be probably better to identify the bank 0 sub unit that causes it
>and only turn that off.
>
>-Andi
>
>
>
>  
>


