Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTJPKTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTJPKTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:19:47 -0400
Received: from bimba.bezeqint.net ([192.115.106.39]:26815 "EHLO
	bimba.bezeqint.net") by vger.kernel.org with ESMTP id S262796AbTJPKTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:19:44 -0400
Message-ID: <3F8E70E0.7070000@users.sf.net>
Date: Thu, 16 Oct 2003 12:20:16 +0200
From: Eli Billauer <eli_billauer@users.sf.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au>
In-Reply-To: <3F8E58A9.20005@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>> Frandom is the faster version of the well-known /dev/urandom random 
>> number generator. Not instead of, but rather as a supplement, when 
>> pseudorandom data is needed at high rate. Few tests so far show that 
>> frandom is 10-50 times faster than urandom.
>>
>
> Without looking at the code, why should this be done in the kernel?

I suppose you're asking why having a /dev/frandom device at all. Why not 
let everyone write their own little random generator (based upon 
well-known C functions) whenever random data is needed.

There are plenty of handy things in the kernel, that could be done in 
userspace. /dev/zero is my favourite example, but I'm sure there are 
other cases where things were put in the kernel simply because people 
found them handy. Which is a good reason, if you ask me.

Besides, it's quite easy to do something wrong with random numbers. By 
having a good source of random data, I suppose we can spare a lot of 
people the headache of getting their own user-space application right 
for the one-off thing they want to do.

But it's really a matter of taste. That's why I bring up the subject here.

   Eli






