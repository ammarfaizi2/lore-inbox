Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751959AbWJ3Omx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbWJ3Omx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWJ3Omx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:42:53 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:65415 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751959AbWJ3Omw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:42:52 -0500
Message-ID: <45460E69.7070505@openvz.org>
Date: Mon, 30 Oct 2006 17:38:33 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Pavel Emelianov <xemul@openvz.org>, vatsa@in.ibm.com, dev@openvz.org,
       sekharan@us.ibm.com, menage@google.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com, dipankar@in.ibm.com, rohitseth@google.com,
       devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com>	<45460743.8000501@openvz.org> <20061030062332.856dcc32.pj@sgi.com>
In-Reply-To: <20061030062332.856dcc32.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Pavel wrote:
>> 1. One of the major configfs ideas is that lifetime of
>>    the objects is completely driven by userspace.
>>    Resource controller shouldn't live as long as user
>>    want. It "may", but not "must"!
> 
> I had trouble understanding what you are saying here.
> 
> What does the phrase "live as long as user want" mean?

What if if user creates a controller (configfs directory)
and doesn't remove it at all. Should controller stay in memory
even if nobody uses it?

> 
> 
>> 2. Having configfs as the only interface doesn't alow
>>    people having resource controll facility w/o configfs.
>>    Resource controller must not depend on any "feature".
>>
>> 3. Configfs may be easily implemented later as an additional
>>    interface. I propose the following solution:
>>      - First we make an interface via any common kernel
>>        facility (syscall, ioctl, etc);
>>      - Later we may extend this with configfs. This will
>>        alow one to have configfs interface build as a module.
> 
> So you would add bloat to the kernel, with two interfaces
> to the same facility, because you don't want the resource
> controller to depend on configfs.
> 
> I am familiar with what is wrong with kernel bloat.
> 
> Can you explain to me what is wrong with having resource
> groups depend on configfs?  Is there something wrong with

Resource controller has nothing common with confgifs.
That's the same as if we make netfilter depend on procfs.

> configfs that would be a significant problem for some systems
> needing resource groups?

Why do we need to make some dependency if we can avoid it?

> It is better where possible, I would think, to reuse common
> infrastructure and minimize redundancy.  If there is something
> wrong with configfs that makes this a problem, perhaps we
> should fix that.

The same can be said about system calls interface, isn't it?
