Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUBKG7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUBKG7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:59:42 -0500
Received: from dictum-ext.geekmail.cc ([204.239.179.245]:32430 "EHLO
	mailer01.geekmail.cc") by vger.kernel.org with ESMTP
	id S263803AbUBKG7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:59:40 -0500
Message-ID: <4029D2D5.7070504@swapped.cc>
Date: Tue, 10 Feb 2004 22:59:33 -0800
From: Alex Pankratov <ap@swapped.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.6] [2/2] hlist: remove IFs from hlist functions
References: <4029CB7E.4030003@swapped.cc> <4029CF24.1070307@osdl.org>
In-Reply-To: <4029CF24.1070307@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Hemminger wrote:
>  +++ linux-2.6.2.hlist/lib/list.c    2004-02-10 13:03:08.000000000 -0800
> 
>> @@ -0,0 +1,10 @@
>> +#include <linux/module.h>
>> +#include <linux/list.h>
>> +
>> +/*
>> + *    shared tail sentinel for hlists
>> + */
>> +struct hlist_node hlist_null;
> 
> Could this be const?

No, because its 'pprev' field *is* getting modified.
