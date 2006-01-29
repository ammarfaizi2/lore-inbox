Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWA2IrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWA2IrD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 03:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWA2IrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 03:47:03 -0500
Received: from elvis.mu.org ([192.203.228.196]:5629 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S1750749AbWA2IrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 03:47:02 -0500
Message-ID: <43DC80FF.1050604@FreeBSD.org>
Date: Sun, 29 Jan 2006 00:46:55 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkwza479.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

Just a few typos in comments.

> @@ -17,6 +17,8 @@ struct pid
>  	struct hlist_node pid_chain;
>  	/* list of pids with the same nr, only one of them is in the hash */
>  	struct list_head pid_list;
> +	/* Does a weak references of this type exsit to the task struct? */
> +	struct task_ref *ref;

exsit -> exist

> +/* Note to read a usable value task value from struct task_ref
> + * the tasklist_lock must be held.  The atomic property of single
> + * word reads will keep any vaule you read consistent but it doesn't

vaule -> value

> + * protect you from the race of the task exiting on another cpu and
> + * having it's task_struct freed or reused.  Holding the tasklist_lock
> + * prevents the task from going away as you derference the task pointer.

derference -> dereference

-- Suleiman
