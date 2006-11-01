Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946689AbWKAIFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946689AbWKAIFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946693AbWKAIFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:05:48 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:32955 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946689AbWKAIFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:05:47 -0500
Message-ID: <4548545B.4070701@openvz.org>
Date: Wed, 01 Nov 2006 11:01:31 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, sekharan@us.ibm.com,
       menage@google.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org> <20061031163418.GD9588@in.ibm.com>
In-Reply-To: <20061031163418.GD9588@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

>> 2. Having configfs as the only interface doesn't alow
>>    people having resource controll facility w/o configfs.
>>    Resource controller must not depend on any "feature".
> 
> One flexibility configfs (and any fs-based interface) offers is, as Matt
> had pointed out sometime back, the ability to delage management of a
> sub-tree to a particular user (without requiring root permission).
> 
> For ex:
> 
> 			/
> 			|
> 		 -----------------
> 		|		  |
> 	       vatsa (70%)	linux (20%)
> 		|
> 	 ----------------------------------
> 	|	         | 	          |
>       browser (10%)   compile (50%)    editor (10%)
> 
> In this, group 'vatsa' has been alloted 70% share of cpu. Also user
> 'vatsa' has been given permissions to manage this share as he wants. If
> the cpu controller supports hierarchy, user 'vatsa' can create further
> sub-groups (browser, compile ..etc) -without- requiring root access.

I can do the same using bcctl tool and sudo :)

> Also it is convenient to manipulate resource hierarchy/parameters thr a
> shell-script if it is fs-based.
> 
>> 3. Configfs may be easily implemented later as an additional
>>    interface. I propose the following solution:
> 
> Ideally we should have one interface - either syscall or configfs - and
> not both.

Agree.

> Assuming your requirement of auto-deleting objects in configfs can be
> met thr' something similar to cpuset's notify_on_release, what other
> killer problem do you think configfs will pose?
> 
> 
>>> 	- Should we have different groupings for different resources?
>> This breaks the idea of groups isolation.
> 
> Sorry dont get you here. Are you saying we should support different
> grouping for different controllers?

Not me, but other people in this thread.
