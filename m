Return-Path: <linux-kernel-owner+w=401wt.eu-S1752812AbWLOQRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbWLOQRH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbWLOQRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:17:06 -0500
Received: from gateway-1237.mvista.com ([63.81.120.155]:33482 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752812AbWLOQRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:17:05 -0500
Message-ID: <4582CAD6.9040404@ru.mvista.com>
Date: Fri, 15 Dec 2006 19:18:30 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v2.6.19-rt6, yum/rpm
References: <20061205171114.GA25926@elte.hu>
In-Reply-To: <20061205171114.GA25926@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

Ingo Molnar wrote:

> i have released the 2.6.19-rt6 tree, which can be downloaded from the 
> usual place:

>     http://redhat.com/~mingo/realtime-preempt/

[...]

> as usual, bugreports, fixes and suggestions are welcome,

    Be aware that even with the newest -rt patch, the PowerPC TOD vsyscalls 
are still broken, i.e. glibc may return imprecise/incorrect results for the 
related calls -- despite arch/powerpc/kernel/time.c has been at last fixed to 
at least compile, the PowerPC clocksource patch removed the important part of 
TOD vsyscall support, and this hasn't been dealt with.  I've sent to Thomas 
Gleixner a patch removing the affected vsyscalls altogether for the time being 
in the early November (unfortunately, I came to know of the breakage too late, 
and hadn't time to deal with it propery due to othr woes), however, I'm not 
seeing any of my patches (I've also done PowerPC clockevents support) merged 
to -rt (or otherwise published). Most of the patches can be found in the 
linuxppc-dev list archives, for the interested...

> 	Ingo

WBR, Sergei
