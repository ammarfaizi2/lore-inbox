Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbULUTYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbULUTYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULUTYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:24:18 -0500
Received: from [195.23.16.24] ([195.23.16.24]:64140 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261343AbULUTX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:23:59 -0500
Message-ID: <41C87825.8020901@grupopie.com>
Date: Tue, 21 Dec 2004 19:23:17 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesse <jessezx@yahoo.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: Gurus, a silly question for preemptive behavior
References: <20041221190339.24215.qmail@web52605.mail.yahoo.com>
In-Reply-To: <20041221190339.24215.qmail@web52605.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.25; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jesse wrote:
> Paulo:
>  
>    I already said in the messsage that my user space
> application has a low nice priority, i set it to 10.
> since my application has low priority compared to
> other user space applications, it is supposed to be
> interrupted. but it is not.

The confusion comes from "low nice priority". The lower the nice value 
the higher the priority.

Anyway, you still haven't give enough data to analyze. What does your 
application do? Is it I/O intensive? If it is, it could be that the 
kernel itself is hogging the CPU doing I/O on behalf of a low prio 
process (priority, specially in 2.4, only affects CPU distribution and 
not I/O). How do you know it's not being preempted? What is your 
.config? What patches do you have applied? And finally, why don't you 
upgrade to a 2.6 kernel :) ?

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

