Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWBFUfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWBFUfJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWBFUfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:35:08 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:27656 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964785AbWBFUfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:35:06 -0500
Message-ID: <43E7B35C.7090201@sw.ru>
Date: Mon, 06 Feb 2006 23:36:44 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117155600.GF20632@sergelap.austin.ibm.com> <1137513818.14135.23.camel@localhost.localdomain> <1137518714.5526.8.camel@localhost.localdomain> <20060118045518.GB7292@kroah.com> <1137601395.7850.9.camel@localhost.localdomain> <m1fyniomw2.fsf@ebiederm.dsl.xmission.com> <43D14578.6060801@watson.ibm.com> <Pine.LNX.4.64.0601311248180.7301@g5.osdl.org> <43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com> <20060206201521.GA2470@ucw.cz>
In-Reply-To: <20060206201521.GA2470@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>There are two issues here.
>>1) Monitoring.  (ps, top etc)
>>2) Control (kill).
>>
>>For monitoring you might need to patch ps/top a little but it is doable without
>>2 pids.
>>
>>For kill it is extremely rude to kill processes inside of a nested pid space.
>>There are other solutions to the problem.

> Can you elaborate? If I have 10 containers with 1000 processes each,
> it would be nice to be able to run top then kill 40 top cpu hogs....
This is exactly the reason why we allow host system to see all the 
containers/VPSs/processes.

Otherwise monitoring tools should be fixed for it, which doesn't look 
good and top/ps/kill are not the only tools in the world.
Without such functionality you can't understand whether you machine is 
underloaded or overloaded.

Kirill

