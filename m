Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263868AbUD0HEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUD0HEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 03:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbUD0HEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 03:04:13 -0400
Received: from [81.219.144.6] ([81.219.144.6]:18437 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263868AbUD0HEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 03:04:08 -0400
Message-ID: <408E05DD.2080705@pointblue.com.pl>
Date: Tue, 27 Apr 2004 08:03:57 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <408DC0E0.7090500@gmx.net> <20040427052655.GQ596@alpha.home.local>
In-Reply-To: <20040427052655.GQ596@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

>What would be smarter would be to try to understand why they do this. At
>the moment, it seems to me that their only problem is to taint the kernel.
>Why ? I don't this that any old modutils/module-utils found in any distros
>don't load properly such modules. So perhaps they only want not to taint
>the kernel because it appears dirty to their customers who will not receive
>any more support from LKML. So perhaps what we really need is to add a new
>MODULE_SUPPORT field stating where to get support from in case of bugs,
>oopses or panics on a tainted kernel. Thus, the module author would be able
>to insert something such as "support_XXX@author.com" which will be displayed
>on each oops/panic/etc... Even if this is a long list because the customer
>uses connexant, nvidia, checkpoint and I don't know what, at least he will
>get 3 email addresses for his support. And it might reassure these authors
>to know that the customer will ask them before asking us with our automatic
>replies "unload your binary modules...".
>
>Anyway it now seems like strings will have to be matched on their lenghts...
>  
>
And they will put linux-kernek@vger.kernel(.org) there :-)
You never know...

--
GJ

