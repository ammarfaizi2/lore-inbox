Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030594AbWHIJFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030594AbWHIJFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWHIJFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:05:53 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:37302 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030593AbWHIJFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:05:52 -0400
Message-ID: <44D9A5D0.5020406@sw.ru>
Date: Wed, 09 Aug 2006 13:07:28 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, viro@zeniv.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mishin Dmitry <dim@openvz.org>
Subject: Re: [PATCH] move IMMUTABLE|APPEND checks to notify_change()
References: <44D87907.6090706@sw.ru> <20060808203814.GO29920@ftp.linux.org.uk>
In-Reply-To: <20060808203814.GO29920@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>[PATCH] move IMMUTABLE|APPEND checks to notify_change()
>>
>>This patch moves lots of IMMUTABLE and APPEND flag checks
>>scattered all around to more logical place in notify_change().
> 
>  
> NAK.  For example, you are allowed to do unames(file, NULL) on
> any file you own or can write to, whether it's append-only or
> not.  With your change that gets -EPERM.

Al, will you ACK the patch allowing to set current times in notify_change() for
APPEND files?

However, I'd like to see an explanation on dim@'s question why semantics
are different and current time is allowed to be set, while arbitrary time is not.

Kirill

