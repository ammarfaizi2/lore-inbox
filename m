Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUDCPlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 10:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUDCPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 10:41:52 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:8880 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261802AbUDCPlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 10:41:50 -0500
Message-ID: <406EDB43.6030401@stanford.edu>
Date: Sat, 03 Apr 2004 17:41:55 +0200
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
CC: Chris Wright <chrisw@osdl.org>, luto@myrealbox.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: capabilitiescompute_cred
References: <20040402033231.05c0c337.akpm@osdl.org>	 <1080912069.27706.42.camel@moss-spartans.epoch.ncsc.mil>	 <20040402111554.E21045@build.pdx.osdl.net>  <406DCB32.8070403@stanford.edu> <1080942432.28777.109.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1080942432.28777.109.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:

> On Fri, 2004-04-02 at 15:21, Andy Lutomirski wrote:
> 
>>I agree in principle, but it would still be nice to have a simple way to 
>>have useful capabilities without setting up a MAC system.  I don't see a 
>>capabilities fix adding any significant amount of code; it just takes 
>>some effort to get it right.
> 
> 
> I'm not opposed to making the existing capability logic more useable; I
> just think that capabilities will ultimately be superseded by TE.
>  
> 
>>You can find my attempts to get it right in the 
>>linux-kernel archives, and I'll probably try to get something into 2.7 
>>when it forks.  With or without MAC, having a functioning capability 
>>system wouldn't hurt security.
> 
> 
> Does revising the capability logic need to wait on 2.7?  Have you
> changed the logic significantly since the last patch you posted to lkml?
> 

I don't _think_ it's changed, but I'll double-check that in a few days 
(I'm out of town).  I'll also rediff my patch.  Should it be a config 
option?

Anyway, I have no strong objection to seeing a change in 2.6 -- there's 
just some risk that it could break something that depends on the current 
(broken, undocumented) behavior.

Andrew:  would you be willing to put a capabilities fix into -mm?

--Andy
