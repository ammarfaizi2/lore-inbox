Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUDIUxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 16:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUDIUxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 16:53:33 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:3002 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261756AbUDIUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 16:53:30 -0400
Message-ID: <40770D49.7060809@myrealbox.com>
Date: Fri, 09 Apr 2004 13:53:29 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andy Lutomirski <luto@myrealbox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org, sds@epoch.ncsc.mil
Subject: Re: [PATCH, local root on 2.4, 2.6?] compute_creds race
References: <4076F02E.1000809@myrealbox.com> <20040409134323.L22989@build.pdx.osdl.net>
In-Reply-To: <20040409134323.L22989@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Wright wrote:
> * Andy Lutomirski (luto@myrealbox.com) wrote:
> 
>>The setuid program is now running with uid=euid=500 but full permitted 
>>capabilities.
> 
> 
> Yes, dropping and regaining the lock is asking for trouble.  Thank you for
> catching this.  I don't have an issue with changing the interface name.
> I guess the only question I have is if it's better to leave the setuid
> handling in the core, and move the newly named hook under the task_lock()?

I imagine some LSM might want to do something complex, and holding the 
task lock might become a problem.  Also, an LSM might want to change the 
setuid handling, and this makes it easier.

--Andy

> 
> thanks,
> -chris
