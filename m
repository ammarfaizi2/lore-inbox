Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWHGQIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWHGQIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWHGQIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:08:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:15204 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932179AbWHGQIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:08:54 -0400
Message-ID: <44D765E3.9040206@sw.ru>
Date: Mon, 07 Aug 2006 20:10:11 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: nagar@watson.ibm.com, akpm@osdl.org, vatsa@in.ibm.com, mingo@elte.hu,
       nickpiggin@yahoo.com.au, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       haveblue@us.ibm.com
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with Resource
 Management - A cpu  controller
References: <20060804050753.GD27194@in.ibm.com>	<20060803223650.423f2e6a.akpm@osdl.org>	<44D35794.2040003@sw.ru>	<44D367F3.8060108@watson.ibm.com>	<44D6EBEF.9010804@sw.ru> <20060807023025.2c44f3d1.pj@sgi.com>
In-Reply-To: <20060807023025.2c44f3d1.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>A filesystem based interface is useful when you have hierarchies (as resource
>>>groups and cpusets do) since it naturally defines a convenient to use
>>>hierarchical namespace.
>>
>>but it is not much convinient for applications then.
> 
> 
> Is this simply a language issue?  File systems hierarchies
> are more easily manipulated with shell utilities (ls, cat,
> find, grep, ...) and system call API's are easier to access
> from C?
> 
> If so, then perhaps all that's lacking for convenient C access
> to a filesystem based interface is a good library, that presents
> an API convenient for use from C code, but underneath makes the
> necessary file system calls (open, read, diropen, stat, ...).

IMHO:
file system APIs are not good for accessing attributed data.
e.g. we have a /proc which is very convenient for use from shell etc. but
is not good for applications, not fast enough etc.
moreover, /proc had always problems with locking, races and people tend to
feel like they can change text presention of data, while applications parsing
it tend to break.

Kirill
