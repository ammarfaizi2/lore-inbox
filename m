Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268882AbTGJDe2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268875AbTGJDe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:34:28 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:3496 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S268882AbTGJDeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:34:04 -0400
Message-ID: <3F0CE21B.2050309@hawton.org>
Date: Wed, 09 Jul 2003 20:48:43 -0700
From: Daniel <daniel@hawton.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_generic_direct_write: bad flag check
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva> <20030709231348.GC18564@werewolf.able.es> <Pine.LNX.4.55L.0307100028320.6629@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0307100028320.6629@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti wrote:

> 
> On Thu, 10 Jul 2003, J.A. Magallon wrote:
> 
> 
>>On 07.10, Marcelo Tosatti wrote:
>>
>>>Hi,
>>>
>>>Here goes -pre4. It contains a lot of updates and fixes.
>>>
>>
>>--- linux-2.4.22-pre2-jam1/mm/filemap.c.orig	2003-06-28 01:55:36.000000000 +0200
>>+++ linux-2.4.22-pre2-jam1/mm/filemap.c	2003-06-28 01:55:45.000000000 +0200
>>@@ -3223,7 +3223,7 @@
>> 	if (err != 0 || count == 0)
>> 		goto out;
>>
>>-	if (!file->f_flags & O_DIRECT)
>>+	if (!(file->f_flags & O_DIRECT))
>> 		BUG();
>>
>> 	remove_suid(inode);
>>
>>...but sure the fix in -ac is better.
> 
> 
> What is the difference between the fix in -ac and yours?

There's a difference??  Looks the same to me.  Unless there is part of 
the patch we don't see.

