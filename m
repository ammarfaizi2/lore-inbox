Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314126AbSDLRpC>; Fri, 12 Apr 2002 13:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314128AbSDLRpB>; Fri, 12 Apr 2002 13:45:01 -0400
Received: from firewall.oeone.com ([216.191.248.101]:37391 "HELO
	mail.oeone.com") by vger.kernel.org with SMTP id <S314126AbSDLRpA>;
	Fri, 12 Apr 2002 13:45:00 -0400
Message-ID: <3CB71D21.9080005@oeone.com>
Date: Fri, 12 Apr 2002 13:45:05 -0400
From: Masoud Sharbiani <masouds@oeone.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vahid Fereydunkolahi <fereydunk@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel threads.
In-Reply-To: <20020412170709.98207.qmail@web10002.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Context switch happens when one of your running processes (or kernel 
threads) is running and then makes a request (like reading from a device 
and it has to wait for result). therefore scheduler selects another 
runnable process/kthread to run.
If you think you have a lot of context switches, you might want to 
redesign your thread so it blocks less (for example, make several 
requests for reading several blocks, all at the same time, and wait for 
first to complete where there is higher probability for the rest of 
blocks to be ready when you check for their readiness).
regards,
Masoud
Vahid Fereydunkolahi wrote:

>Folks,
> I have a problem using kernel_thread. The problem is
> when I use kernel threads I see a lot of context 
>switch. 
> I monitor the system activity using vmstat.
>
>Regards,
>--vahid
>
>
>__________________________________________________
>Do You Yahoo!?
>Yahoo! Tax Center - online filing with TurboTax
>http://taxes.yahoo.com/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



