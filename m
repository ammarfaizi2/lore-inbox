Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTJPM0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTJPM0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 08:26:49 -0400
Received: from bimba.bezeqint.net ([192.115.106.39]:61365 "EHLO
	bimba.bezeqint.net") by vger.kernel.org with ESMTP id S262878AbTJPM0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 08:26:48 -0400
Message-ID: <3F8E8EA8.8030707@users.sf.net>
Date: Thu, 16 Oct 2003 14:27:20 +0200
From: Eli Billauer <eli_billauer@users.sf.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com>
In-Reply-To: <3F8E8101.70009@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>> Besides, it's quite easy to do something wrong with random numbers. 
>> By having a good source of random data, I suppose we can spare a lot 
>> of people the headache of getting their own user-space application 
>> right for the one-off thing they want to do.
>
>
> This is completely bogus logic.  I can use this (incorrect) argument 
> to similar push for applications doing bsearch(3) or qsort(3) via a 
> system call.
>
My argument, possibly better formulated, asks the following questions:

(1) How much good will the existence of an standard /dev/frandom device 
do? Is it going to be used?
(2) How much space will it take up in the kernel tarball?
(3) How much disk space will it take after compilation?
(4) How much compilation time will it take up?
(5) How much effort is it going to be to maintain it?

(If we use it as a kernel module, we don't even have to consider the 
little kernel memory it takes up)

If I've missed some other pragmatic consideration, by all means tell me.

Now, I think that (1) wins (2)-(5). I can comment on maintaining the 
module after making it compatible with 2.2 and 2.6: It's a simple 
character device, with the most basic adaptions to it.

I actually agree that the kernel isn't "the right place" for a random 
generator. I simply think that having it there is useful, with a very 
low cost.

   Eli


