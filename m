Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVETSEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVETSEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVETSE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:04:27 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:50121 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261526AbVETSET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:04:19 -0400
Message-ID: <428E2669.7010507@ammasso.com>
Date: Fri, 20 May 2005 13:03:21 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild: specifying phony targets?
References: <428B4CF5.1070507@ammasso.com> <20050520053741.GB16699@mars.ravnborg.org>
In-Reply-To: <20050520053741.GB16699@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> A phony target is not possible.
> But use 'always' to tell kbuild what needs to be done.
> Se also kbuild documentation: Documentation/kbuild/makefile.txt

I added these lines to my makefile:

always := syscall

syscall:
         @echo ${SYSCALL_METHOD}

and I got this error:

make[3]: *** No rule to make target 
`/root/AMSO1100/software/host/linux/sys/devccil/syscall', needed by `__build'.  Stop.

I need to specify a target that is NOT a file.  How can I tell kbuild that my target isn't 
a file, but just a rule that needs to be run?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
