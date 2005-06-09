Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVFIMJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVFIMJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVFIMJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:09:48 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:2253 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S262363AbVFIMJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:09:33 -0400
Message-ID: <42A8316E.6000104@stud.feec.vutbr.cz>
Date: Thu, 09 Jun 2005 14:09:18 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42A73023.4040707@stud.feec.vutbr.cz> <20050609114510.GA10969@elte.hu>
In-Reply-To: <20050609114510.GA10969@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> thanks - i have added it to my tree and have uploaded the -48-03 release 
> with your patch included.

This hunk should not be in the patch:

@@ -190,8 +190,8 @@ SUBARCH := $(shell uname -m | sed -e s/i
  # Default value for CROSS_COMPILE is not to prefix executables
  # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile

-ARCH		?= $(SUBARCH)
-CROSS_COMPILE	?=
+ARCH = x86_64
+CROSS_COMPILE = x86_64-linux-

  # Architecture as present in compile.h
  UTS_MACHINE := $(ARCH)



Michal
