Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752037AbWISEJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWISEJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 00:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWISEJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 00:09:53 -0400
Received: from tresys.irides.com ([216.250.243.126]:36117 "HELO
	exchange.columbia.tresys.com") by vger.kernel.org with SMTP
	id S1752033AbWISEJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 00:09:51 -0400
Message-ID: <450F6D87.7090604@gentoo.org>
Date: Tue, 19 Sep 2006 00:09:43 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
 3/4: introduce new capabilities
References: <20060919034601.97733.qmail@web36610.mail.mud.yahoo.com>
In-Reply-To: <20060919034601.97733.qmail@web36610.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0637-2, 09/15/2006), Outbound message
X-Antivirus-Status: Clean
X-OriginalArrivalTime: 19 Sep 2006 04:09:51.0065 (UTC) FILETIME=[7418FC90:01C6DBA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler wrote:
> --- Joshua Brindle <method@gentoo.org> wrote:
>   
>>> The first system I took through evaluation
>>> (that is, independent 3rd party analysis) stored
>>> security attributes in a file while the second
>>> and third systems attached the attributes
>>> directly (XFS). The 1st evaluation required
>>> 5 years, the 2nd 1 year. It is possible that
>>> I just got a lot smarter with age, but I
>>> ascribe a significant amount of the improvement
>>> to the direct association of the attributes
>>> to the file.
>>>       
>> Thats great but entirely irrelevant in this context.
>> The patch and caps 
>> in question are not attached to the file via some
>> externally observable 
>> property (eg., xattr) but instead are embedded in
>> the source code so 
>> that it can drop caps at certain points during the
>> execution or before 
>> executing another app, thus unanalyzable.
>>     
>
> Oh that. Sure, we used capability bracketing
> in the code, too. That makes it easy to
> determine when a capability is active. What,
> you don't think that it's possible to analyze
> source code? Of course it is. Refer to the
> evaluation reports if you don't believe me.
>
>   
When I see an analysis of every line of source code on an average Linux 
machine then I might believe you (if you'll grant that no software can 
ever be installed on it afterward without being analyzed) but until then 
I'll stick with a centralized policy. I doubt many others will be 
satisfied with that limitation.

Bracketing hardly makes it analyzable, how can you possibly know if the 
bracketing happened? You *believe* it will and therefore you say that 
the bracketed code is safe but in reality this is a discretionary 
mechanism and you have zero assurance that there is any security 
whatsoever, no thanks, I'll pass.
