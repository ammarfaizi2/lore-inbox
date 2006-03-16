Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752447AbWCPRpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbWCPRpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbWCPRpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:45:16 -0500
Received: from [84.204.75.166] ([84.204.75.166]:33240 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1752447AbWCPRpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:45:15 -0500
Message-ID: <4419A426.9080908@yandex.ru>
Date: Thu, 16 Mar 2006 20:45:10 +0300
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com>
In-Reply-To: <20060316165323.GA10197@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> Don't statically create kobjects, it's not nice.  But the real problem
> is below...

Well, that was just an example...

But in real life I do use a static kobject in one case, so I'm very 
interested what should I do instead. I have a subsystem, and I want it 
to put all its stuff in a /sys/A directory. So I just define a static 
kobject for A and assign a dummy release function to it. Why is this bad?

And what should I do instead? kmalloc(sizeof(struct kobject), 
GFP_KERNEL) ? I do not have a dynamic structure corresponding to my 
module. I have many data structures corresponding to entities my object 
handles and I have one static array which refers them. All is simple. I 
do not want to introduce a dynamic data structure corresponding to the 
subsystem as a whole just in order to not use static kobjects.

Comments?

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
