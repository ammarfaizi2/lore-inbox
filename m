Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTEaXYW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTEaXYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 19:24:22 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:58553 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S264496AbTEaXYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 19:24:21 -0400
Message-ID: <3ED93CC6.30200@cox.net>
Date: Sat, 31 May 2003 16:37:42 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "ismail (cartman) donmez" <kde@myrealbox.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
References: <3ED8D5E4.6030107@cox.net> <200305312358.03208.kde@myrealbox.com> <3ED919DC.6030202@cox.net> <200306010016.05548.kde@myrealbox.com>
In-Reply-To: <200306010016.05548.kde@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail (cartman) donmez wrote:
> On Sunday 01 June 2003 00:08, Kevin P. Fleming wrote:
> 
> 
>>Right. But until such time as that happens (even if started today that's
>>many months away), real world libraries need to be compiled to be used
>>against the new kernel.
>>
> 
> Yes I reported to binutils hackers that this change broke binutils ( + glibc ) 
> but kernel guys just say "do not include kernel headers in userspace" . 
> 

Oh, I saw that discussion. I fully agree. If I can help the process of 
creating a sanitized userspace set of kernel headers I'll be happy to.

In the meantime, a small change to a kernel header, that provides _zero_ 
functional difference to the kernel itself (it's only there for source 
code checkers, as best I can tell) shouldn't break existing userspace 
libraries.

If it's going to, then we should just go ahead and break everything and 
get it done right. It's late in the 2.6 game, but the first few steps on 
the path have already been taken.

