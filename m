Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752762AbWKBJNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbWKBJNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbWKBJNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:13:15 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:32871 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752762AbWKBJNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:13:14 -0500
Message-ID: <4549B5A3.2010908@openvz.org>
Date: Thu, 02 Nov 2006 12:08:51 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: Matt Helsley <matthltc@us.ibm.com>, vatsa@in.ibm.com,
       Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <45486925.4000201@openvz.org>	 <20061101181236.GC22976@in.ibm.com>	 <1162419565.12419.154.camel@localhost.localdomain> <6599ad830611011550m69876b1ase3579167903a7cd7@mail.gmail.com>
In-Reply-To: <6599ad830611011550m69876b1ase3579167903a7cd7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

> I think that having a "tasks" file and a "threads" file in each
> container directory would be a clean way to handle it:
> 
> "tasks" : read/write complete process members
> "threads" : read/write individual thread members

I've just thought of it.

Beancounter may have more than 409 tasks, while configfs
doesn't allow attributes to store more than PAGE_SIZE bytes
on read. So how would you fill so many tasks in one page?

I like the idea of writing pids/tids to these files, but
printing them back is not that easy.

> 
> Paul
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

