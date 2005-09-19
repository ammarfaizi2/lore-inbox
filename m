Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVISAbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVISAbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 20:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVISAbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 20:31:45 -0400
Received: from main.gmane.org ([80.91.229.2]:23481 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932281AbVISAbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 20:31:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: sean <seandarcy2@gmail.com>
Subject: Re: git3 build dies at net/built-in.o: undefined __nfa_fill
Date: Sun, 18 Sep 2005 20:29:30 -0400
Message-ID: <dgl0pa$75d$1@sea.gmane.org>
References: <dgfp9f$7i8$1@sea.gmane.org> <432C132A.8020301@gmail.com> <dgkqhs$qt0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-4577675c.dyn.optonline.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050914 Fedora/1.7.11-5
X-Accept-Language: en-us, en
In-Reply-To: <dgkqhs$qt0$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sean wrote:
> Jiri Slaby wrote:
> 
>> sean napsal(a):
>>
>>> On amd64, gcc-4.0.1:
>>>
>>> .....
>>>   GEN     .version
>>>   CHK     include/linux/compile.h
>>>   UPD     include/linux/compile.h
>>>   CC      init/version.o
>>>   LD      init/built-in.o
>>>   LD      .tmp_vmlinux1
>>> net/built-in.o: In function `ip_ct_port_tuple_to_nfattr':
>>> : undefined reference to `__nfa_fill'
> 
> .............
> 
>>
>> .config needed
>> NETFILTER_NETLINK is not selected, maybe.
>>
> 
> Nope.
> 
>  grep NETFILTER .config
> CONFIG_NETFILTER=y
> # CONFIG_NETFILTER_DEBUG is not set
> CONFIG_NETFILTER_NETLINK=m
> CONFIG_NETFILTER_NETLINK_QUEUE=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> 
> sean
> 
  But this built -n rc1-git4:

grep NETLINK .config
# CONFIG_IP_NF_CONNTRACK_NETLINK is not set
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
# CONFIG_NETFILTER_NETLINK_LOG is not set

???

ean

