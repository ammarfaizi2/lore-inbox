Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVDBQ7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVDBQ7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 11:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVDBQ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 11:59:10 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:64900 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261658AbVDBQ7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 11:59:06 -0500
Message-ID: <424ECF4D.6070800@tiscali.de>
Date: Sat, 02 Apr 2005 18:58:53 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: make OOM more "user friendly"
References: <20050402180545.29e10629.diegocg@gmail.com>
In-Reply-To: <20050402180545.29e10629.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja schrieb:

>When people gets OOM messages, many of them don't know what is happening or what
>OOM means. This brief message explains it.
>
>--- stable/mm/oom_kill.c.orig	2005-04-02 17:44:14.000000000 +0200
>+++ stable/mm/oom_kill.c	2005-04-02 18:01:02.000000000 +0200
>@@ -189,7 +189,8 @@
> 		return;
> 	}
> 	task_unlock(p);
>-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
>+	printk(KERN_ERR "The system has run Out Of Memory (RAM + swap), a process will be killed to free some memory\n");
>+	printk(KERN_ERR "OOM: Killed process %d (%s).\n", p->pid, p->comm);
> 
> 	/*
> 	 * We give our sacrificial lamb high priority and access to
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
I disagree this is _not_ usefull. If the user don't knows what OOM means 
he can use google to get this information.

Matthias-Christian Ott
