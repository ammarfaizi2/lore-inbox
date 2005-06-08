Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFHMek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFHMek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFHMek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:34:40 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:7871 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261151AbVFHMeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:34:37 -0400
Message-ID: <42A6E851.2010504@ru.mvista.com>
Date: Wed, 08 Jun 2005 16:45:05 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, David Brownell <david-b@pacbell.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: race in usbnet.c in full RT
References: <42A6C6B3.2000303@ru.mvista.com>	 <20050608103440.GA18380@elte.hu> <1118231726.8255.7.camel@localhost.localdomain>
In-Reply-To: <1118231726.8255.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 2005-06-08 at 12:34 +0200, Ingo Molnar wrote:
> 
>>* Eugeny S. Mints <emints@ru.mvista.com> wrote:
>>
>>
>>>seems there is a race in drivers/net/usbnet.c in full RT mode. To be 
>>>honest I haven't hardly checked this on the latest kernel and latest 
>>>RT patch but just took a look at usbnet.c and latest RT patch and 
>>>haven't observed any related changes.
>>
>>thanks, i've applied your patch to my tree. Note that your patch is 
>>specific to the -RT kernel (both in terms of semantics and in term of 
>>API dependence), so it does not make any sense to apply it upstream.  
>>David, please ignore it.
>>
> 
> 
> Is this action only take place on the same CPU, or is this also an SMP
> problem?  I would think if this is a race with full RT, that this may
> also be a race with SMP, unless the race is guaranteed to always happen
> on the same CPU. Then this is only a RT problem.
thanks, good point. looks like it could be SMP problem but probably 
David is able to say it for sure as usb host code expert.
David?
	Eugeny
> 
> -- Steve
> 
> 
> 
> 


