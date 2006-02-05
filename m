Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWBEPNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWBEPNe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWBEPNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:13:34 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:58876 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1750901AbWBEPN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:13:28 -0500
Message-ID: <43E615BA.1080402@sw.ru>
Date: Sun, 05 Feb 2006 18:11:54 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clg@fr.ibm.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <20060203201945.GA18224@kroah.com> <43E3BE66.6050200@watson.ibm.com>
In-Reply-To: <43E3BE66.6050200@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How do we want to create the container?
> In our patch we did it through a /proc/container filesystem.
> Which created the container object and then on fork/exec switched over.
this doesn't look good for a full virtualization solution, since proc 
should be virtualized as well :)

> How about an additional sys_exec_container( exec_args + "container_name").
> This does all the work like exec, but creates new container
> with name "..." and attaches task to new container.
> If name exists, an error -EEXIST will be raised !
Why do you need exec?

Kirill

