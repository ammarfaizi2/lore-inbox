Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWBOKct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWBOKct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBOKct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:32:49 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:15378 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751070AbWBOKcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:32:48 -0500
Message-ID: <43F30346.1070802@argo.co.il>
Date: Wed, 15 Feb 2006 12:32:38 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
References: <20060215085456.GA2481@localhost.localdomain> <20060215010559.55b55414.akpm@osdl.org> <20060215093136.GA2600@localhost.localdomain>
In-Reply-To: <20060215093136.GA2600@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 10:32:45.0186 (UTC) FILETIME=[2883A620:01C6321B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

>On Wed, Feb 15, 2006 at 01:05:59AM -0800, Andrew Morton wrote:
>  
>
>>Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
>>    
>>
>>>I see system admins often confused when they sysctl vm.overcommit_memory.
>>>This patch makes overcommit_memory enumeration sensible.
>>>
>>>0 - no overcommit
>>>1 - always overcommit
>>>2 - heuristic overcommit (default)
>>>
>>>I don't feel this would break any userspace scripts.
>>>      
>>>
>>eh?   If any such scripts exist, they'll break.
>>
>>Confused.
>>    
>>
>
>That's a corner case. Let'em break and fix.  Otherwise, users will
>be confused. Even they get it right, after some weeks they'll have
>to re-read the doc. A logical user interface is important to human.
>  
>

If I have

  vm.overcommit_memory = 2

in my /etc/sysctl.conf, its meaning silently changes. I'll know about it 
during the next oomkiller pass.

-- 
error compiling committee.c: too many arguments to function

