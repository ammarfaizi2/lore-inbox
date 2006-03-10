Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWCJKPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWCJKPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 05:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWCJKPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 05:15:08 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:35340 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751973AbWCJKPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 05:15:07 -0500
Message-ID: <441152C0.2030501@sw.ru>
Date: Fri, 10 Mar 2006 13:19:44 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com
Subject: Re: sysctls inside containers
References: <43F9E411.1060305@sw.ru>	 <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>	 <1141062132.8697.161.camel@localhost.localdomain>	 <m1ek1owllf.fsf@ebiederm.dsl.xmission.com> <1141442246.9274.14.camel@localhost.localdomain>
In-Reply-To: <1141442246.9274.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On another note, after messing with putting data in the init_task for
> these things, I'm a little more convinced that we aren't going to want
> to clutter up the task_struct with all kinds of containerized resources,
> _plus_ make all of the interfaces to share or unshare each of those.
> That global 'struct container' is looking a bit more attractive.
BTW, Dave,

have you noticed that ipc/mqueue.c uses netlink to send messages?
This essentially means that they are tied as well...

Thanks,
Kirill

