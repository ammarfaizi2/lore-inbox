Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264646AbUFLFek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbUFLFek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 01:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUFLFek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 01:34:40 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:55235 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264646AbUFLFei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 01:34:38 -0400
Message-ID: <40CA95ED.8060902@myrealbox.com>
Date: Fri, 11 Jun 2004 22:34:37 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel Authentication Tokens (PAGs)
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <40CA74D0.5070207@myrealbox.com> <FA11463F-BC2C-11D8-888F-000393ACC76E@mac.com>
In-Reply-To: <FA11463F-BC2C-11D8-888F-000393ACC76E@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> On Jun 11, 2004, at 23:13, Andy Lutomirski wrote:
> 
>> I like the idea of having some kernel support for tokens.
>>
>> But why PAGs?  I imagine tokens as being independent objects without
>> any hierarchy.  A token group is a set of tokens.  The operations on 
>> tokens
>> are:
>>
>> [...snip...]
>>
>> If you really need a hierarchy, then you could allow token groups to 
>> contain
>> other token groups, with the rule that the whole thing must be acyclic.
> 
> 
> I think my vocabulary here is confusing, what you refer to as a token 
> group, I refer to as a PAG.  The idea for the hierarchy is that it is 
> frequently desirable to start a sub-shell with a temporarily different 
> set of tokens, or to mask out only a certain token without modifying the 
> rest.

Right.  But I think it would be desirable to do other things -- for 
example, a program might want to forward one token over to a daemon to do 
some work.  It doesn't make much sense here to have a hierarchial structure.

BTW, does AFS even have this hierarchy, or does pagsh just create a copy? 
I can't find any manpage for it...


--Andy
