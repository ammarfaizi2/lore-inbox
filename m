Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263498AbTCNVBM>; Fri, 14 Mar 2003 16:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263500AbTCNVBM>; Fri, 14 Mar 2003 16:01:12 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:16103 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263498AbTCNVBL>;
	Fri, 14 Mar 2003 16:01:11 -0500
Message-ID: <3E724599.5050004@colorfullife.com>
Date: Fri, 14 Mar 2003 22:11:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lazy FPU handling in ptrace
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:

>(untested, but obviously correct ;-)
>-Andi 
>
Famous last words.
The patch is not needed: __switch_to unlazies the fpu state of the 
previous thread. ptrace PTRACE_SETFPREGS and PTRACE_SETFPXREGS only 
operate on stopped threads, thus it's guaranteed that the fpu state is 
stored in the task structure.

--
    Manfred

