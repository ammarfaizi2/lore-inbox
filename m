Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266167AbUFYOXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUFYOXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266745AbUFYOXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:23:50 -0400
Received: from mail.dynextechnologies.com ([65.120.73.98]:2559 "EHLO
	mail.dynextechnologies.com") by vger.kernel.org with ESMTP
	id S266275AbUFYOXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:23:41 -0400
Message-ID: <40DC3558.802@dynextechnologies.com>
Date: Fri, 25 Jun 2004 10:23:20 -0400
From: "Fao, Sean" <Sean.Fao@dynextechnologies.com>
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Amit Gud <gud@eth.net>
CC: Pavel Machek <pavel@ucw.cz>, alan <alan@clueserver.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <004e01c45abd$35f8c0b0$b18309ca@home>
In-Reply-To: <004e01c45abd$35f8c0b0$b18309ca@home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2004 14:23:40.0396 (UTC) FILETIME=[0302EAC0:01C45AC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Gud wrote:

>Hi all,
>
>  
>
>>>>On one school server, theres 10MB quota. (Okay, its admins are
>>>>BOFHs^H^H^H^H^HSISAL). Everyone tries to run mozilla there (because
>>>>its installed as default!), and immediately fills his/her quota with
>>>>cache files, leading to failed login next time (gnome just will not
>>>>start if it can't write to ~).
>>>>
>>>>Imagine mozilla automatically marking cache files "elastic".
>>>>
>>>>That would solve the problem -- mozilla caches would go away when disk
>>>>space was demanded, still mozilla's on-disk caching would be effective
>>>>when there is enough disk space.
>>>>        
>>>>
>
>Also this is applicable to mailboxes - automize the marking of old mails of
>the mailing list as elastic, whenever the threshold is reached, you might
>either want to put those mails as compressed archive or simply delete it.
>This has two advantages:
> - No email bounces for the reason of 'mailbox full' and
> - Optimized utlization of the mailbox
>
>Yes, this can be done using scripts too, but what if you are to use other
>users' space that they are not using? Of course script cannot do that! You
>need to have some FS support or a libquota hack.
>  
>
What you're suggesting is not something that could be controlled by the 
file system because there are far too many methods for storing email.  
Consider, for instance, if all email messages are stored in a single 
database file.  Unless you include parsing code for all email storage 
methods, there's no possible way for your design to work.  As you should 
be able to see, this "feature" should be implemented in the email server 
code; *not* the file system.

Personally, I would rather not use this feature, at all; but, I'm also 
entitled to leaving the elastic bit turned off on all my messages.

Sean
