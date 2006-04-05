Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWDEVvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWDEVvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWDEVvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:51:05 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:42630 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932081AbWDEVvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:51:04 -0400
Message-ID: <44343C25.2000306@plan99.net>
Date: Wed, 05 Apr 2006 22:52:37 +0100
From: Mike Hearn <mike@plan99.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <4431A93A.2010702@plan99.net> <m1fykr3ggb.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fykr3ggb.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think if we can fix namespaces you don't have to be root to use
> them that is a superioir approach, and will cover more cases.

That would be nice. I assumed they needed root for security reasons 
rather than architectural reasons.

> I have concerns about security policy ...

I'm not sure I understand. Only if you run that program, and if you 
don't have access to the intermediate directory, how do you run it?

> This means I can not run any of your relocatable executalbes in 
 > a chroot environment unless I mount proc.

Why is mounting proc a bad thing? I have never seen a Linux distro that 
does not provide proc and many desktop-level things depend on it.

> Given how long we have been without this I doubt many people actually
> care

You could argue the same for any new feature. Writing relocatable 
software on UNIX is absolutely standard, except it's done at source 
compile time not runtime. That fits with the traditional UNIX culture of 
compiling software to install it, but the times they are a changin :)

> I'm not certain the directory of an inode even makes sense, and
> that is what you are asking for us to export.

How so? The code does work, though I guess you could devise a scenario 
in which there is a running executable that is not attached to any 
directory.

thanks -mike
