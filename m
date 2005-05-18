Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVEROTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVEROTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVEROLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:11:14 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:3200 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262197AbVEROIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:08:41 -0400
Message-ID: <428B4C67.5090307@ammasso.com>
Date: Wed, 18 May 2005 09:08:39 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Christopher Li <lkml@chrisli.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
References: <428A661C.1030100@ammasso.com> <20050517201148.GA12997@64m.dyndns.org>
In-Reply-To: <20050517201148.GA12997@64m.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Li wrote:
> It is missing the gcc default include path.
> 
> Check your pre-processor.h in sparse to see that match your gcc
> include path or not.
> 
> If not, remove pre-processor.h and recompile sparse should solve
> the problem.

Nope, that didn't fix it.  I deleted pre-process.h and re-ran "make", and it created a new 
one:

#define GCC_INTERNAL_INCLUDE "/usr/lib/gcc-lib/i586-suse-linux/3.3.4/include"

vic1:~/sparse-bk # ll /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include/stdarg.h
-rw-r--r--  1 root root 4325 Oct  1  2004 
/usr/lib/gcc-lib/i586-suse-linux/3.3.4/include/stdarg.h

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
