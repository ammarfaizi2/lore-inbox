Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWHWSWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWHWSWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWHWSWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:22:31 -0400
Received: from alnrmhc12.comcast.net ([204.127.225.92]:34518 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965090AbWHWSWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:22:31 -0400
Message-ID: <44EC9CE7.3080406@namesys.com>
Date: Wed, 23 Aug 2006 11:22:31 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, Akinobu Mita <mita@miraclelinux.com>,
       linux-kernel@vger.kernel.org, okuji@enbug.org
Subject: Re: [patch 4/5] fail-injection capability for disk IO
References: <20060823113243.210352005@localhost.localdomain>	<20060823113317.722640313@localhost.localdomain>	<20060823120355.GD5893@suse.de> <20060823102741.b927e092.akpm@osdl.org>
In-Reply-To: <20060823102741.b927e092.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 23 Aug 2006 14:03:55 +0200
> Jens Axboe <axboe@suse.de> wrote:
>
>   
>> On Wed, Aug 23 2006, Akinobu Mita wrote:
>>     
>>> This patch provides fail-injection capability for disk IO.
>>>
>>> Boot option:
>>>
>>> 	fail_make_request=<probability>,<interval>,<times>,<space>
>>>
>>> 	<probability>
>>>
>>> 		specifies how often it should fail in percent.
>>>
>>> 	<interval>
>>>
>>> 		specifies the interval of failures.
>>>
>>> 	<times>
>>>
>>> 		specifies how many times failures may happen at most.
>>>
>>> 	<space>
>>>
>>> 		specifies the size of free space where disk IO can be issued
>>> 		safely in bytes.
>>>
>>> Example:
>>>
>>> 	fail_make_request=100,10,-1,0
>>>
>>> generic_make_request() fails once per 10 times.
>>>       
>> Hmm dunno, seems a pretty useless feature to me.
>>     
>
> We need it.  What is the FS/VFS/VM behaviour in the presence of IO
> errors?  Nobody knows, because we rarely test it.  Those few times where
> people _do_ test it (the hard way), bad things tend to happen.  reiserfs
> (for example) likes to go wobble, wobble, wobble, BUG.
>   
The iron folks tested it, and we did better than other FS's.  That said,
it seems like a valuable feature to me.
