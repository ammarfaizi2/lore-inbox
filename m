Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423323AbWJaOXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423323AbWJaOXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423338AbWJaOXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:23:36 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:10604 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1423323AbWJaOXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:23:35 -0500
Message-ID: <45475B64.2090301@openvz.org>
Date: Tue, 31 Oct 2006 17:19:16 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com, menage@google.com
CC: Pavel Emelianov <xemul@openvz.org>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       linux-mm@kvack.org
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45470DF4.70405@openvz.org> <45472B68.1050506@in.ibm.com> <4547305A.9070903@openvz.org> <454743F2.6010305@in.ibm.com>
In-Reply-To: <454743F2.6010305@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> A quick code review showed that most of the accounting is the
> same.
> 
> I see that most of the mmap accounting code, it seems to do
> the equivalent of security_vm_enough_memory() when VM_ACCOUNT
> is set. May be we could merge the accounting code to handle
> even containers.
> 
> I looked at
> 
> do_mmap_pgoff
> acct_stack_growth
> __do_brk (
> do_mremap

I'm sure this is possible. I'll take this into account
in the next patch series. Thank you.

>> [snip]
>>
>>> Please see the patching of Rohit's memory controller for user
>>> level patching. It seems much simpler.
>> Could you send me an URL where to get the patch from, please.
>> Or the patch itself directly to me. Thank you.
> 
> Please see http://lkml.org/lkml/2006/9/19/283

Thanks. I'll review it in a couple of days and comment.

[snip]

> I think the interface should depend on the controllers and not
> the other way around. I fear that the infrastructure discussion might
> hold us back and no fruitful work will happen on the controllers.
> Once we add and agree on the controller, we can then look at the
> interface requirements (like persistence if kernel memory is being
> tracked, etc). What do you think?

I do agree with you. But we have to make an agreement with
Paul in this also...
