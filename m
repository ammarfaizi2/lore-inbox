Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVDBRgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVDBRgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 12:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVDBRgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 12:36:42 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:64785 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261291AbVDBRgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 12:36:39 -0500
Message-ID: <424ED825.1030706@tuleriit.ee>
Date: Sat, 02 Apr 2005 20:36:37 +0300
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 1.0 (X11/20050215)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Diego Calleja <diegocg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: make OOM more "user friendly"
References: <20050402180545.29e10629.diegocg@gmail.com> <424ECF4D.6070800@tiscali.de>
In-Reply-To: <424ECF4D.6070800@tiscali.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott wrote:

> Diego Calleja schrieb:
>
>> When people gets OOM messages, many of them don't know what is 
>> happening or what
>> OOM means. This brief message explains it.
>>
>> --- stable/mm/oom_kill.c.orig    2005-04-02 17:44:14.000000000 +0200
>> +++ stable/mm/oom_kill.c    2005-04-02 18:01:02.000000000 +0200
>> @@ -189,7 +189,8 @@
>>         return;
>>     }
>>     task_unlock(p);
>> -    printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", 
>> p->pid, p->comm);
>> +    printk(KERN_ERR "The system has run Out Of Memory (RAM + swap), 
>> a process will be killed to free some memory\n");
>> +    printk(KERN_ERR "OOM: Killed process %d (%s).\n", p->pid, p->comm);
>>
>>     /*
>>      * We give our sacrificial lamb high priority and access to
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>  
>>
> I disagree this is _not_ usefull. If the user don't knows what OOM 
> means he can use google to get this information.


:)  Somewhat like "Use your mobile phone to call helpdesk if your mobile 
phone is broken". Maybe such messages should have some kind of link to 
information  in Documentation/  ?

regards,
Indrek


