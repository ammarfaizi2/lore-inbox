Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWERXiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWERXiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWERXiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:38:46 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:26791 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751167AbWERXip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:38:45 -0400
Message-ID: <446D0573.4050204@myri.com>
Date: Fri, 19 May 2006 01:38:27 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
References: <20060517220218.GA13411@myri.com>	<20060517220608.GD13411@myri.com> <adairo446u3.fsf@cisco.com>
In-Reply-To: <adairo446u3.fsf@cisco.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Still some suspicious uses of volatile here.
>
> For example:
>
>   
>> +struct myri10ge_priv {
>>     
>  ...
>   
>> +	volatile u8 __iomem *sram;
>>     
>
> as far as I can see this is always used with proper __iomem accessors,
> often with casts to strip the volatile anyway.  So why is volatile needed?
>
> I would suggest an audit of all uses of volatile in the driver, since
> "volatile" in drivers really should be read "there's probably a bug
> here, and if not something very tricky is going on."  If there are any
> valid uses of volatile then a comment should explain why, so that
> future reviewers don't have to try and puzzle out which of the
> two possible translations of volatile is correct.
>   

You are right, we audited the code and it looks like we don't need any
volatile.

Thanks,
Brice

