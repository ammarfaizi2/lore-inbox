Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWBGM0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWBGM0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWBGM0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:26:09 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:54362 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965058AbWBGM0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:26:07 -0500
Message-ID: <43E89254.4000104@sw.ru>
Date: Tue, 07 Feb 2006 15:28:04 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: Hubertus Franke <frankeh@watson.ibm.com>, Greg KH <greg@kroah.com>,
       Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <20060203201945.GA18224@kroah.com> <43E3BE66.6050200@watson.ibm.com> <43E615BA.1080402@sw.ru> <43E7CE55.80007@fr.ibm.com>
In-Reply-To: <43E7CE55.80007@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>How do we want to create the container?
>>>In our patch we did it through a /proc/container filesystem.
>>>Which created the container object and then on fork/exec switched over.
>>
>>this doesn't look good for a full virtualization solution, since proc
>>should be virtualized as well :)
> 
> 
> Well, /proc should be "virtualized" or "isolated", how do you expect a
> container to work correctly ? plenty of user space tools depend on it.
Sorry, not actually understand your question... :(
There is not much problems with virtualization of proc. It can be 
virtualized correctly, so that tools are still working. For example, in 
OpenVZ /proc has 2 trees - global and local.
global tree contains the entries which are visiable in all containers.
and local tree - only those which are visible to containers.
PIDs are shown also only those which present in container.

Kirill

