Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWBBQDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWBBQDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWBBQDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:03:53 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:10937 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932092AbWBBQDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:03:53 -0500
Message-ID: <43E22DCA.3070004@sw.ru>
Date: Thu, 02 Feb 2006 19:05:30 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>	<43E2249D.8060608@sw.ru> <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There areas.
> 1) Checkpointing.
> 2) Isolation for security purposes.
>    There may be secrets that the sysadmin should not have access to.
I hope you understand, that such things do not make anything secure. 
Administrator of the node will always have access to /proc/kcore, 
devices, KERNEL CODE(!) etc. No security from this point of view.

> 3) Nesting of containers, (so they are general purpose and not special hacks).
Why are you interested in nesting? Any applications for this?
Until everything is virtualized in nesting way (including TCP/IP stack, 
routing etc.) I see no much use of it.

> The vserver way of solving some of these problems is to provide a way
> to enter the guest.  I would rather have some explicit operation that puts
> you into the guest context so there is a single point where we can tackle
> the nested security issues, than to have hundreds of places we have to
> look at individually.
Huh, it sounds too easy. Just imagine that VPS owner has deleted ps, 
top, kill, bash and other tools. You won't be able to enter. Another 
example when VPS owner is near its resource limits - you won't be able 
to do anything after VPS entering.
Do you need other examples?

Kirill

