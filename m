Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSLQQYo>; Tue, 17 Dec 2002 11:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSLQQYo>; Tue, 17 Dec 2002 11:24:44 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:26765 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264733AbSLQQYn>;
	Tue, 17 Dec 2002 11:24:43 -0500
Message-ID: <3DFF51A3.5010201@colorfullife.com>
Date: Tue, 17 Dec 2002 17:32:35 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>   pushl %ebp
>   movl $0xfffff000, %ebp
>   call *%ebp
>   popl %ebp
>  
>

You could avoid clobbering a register with something like

pushl $0xfffff000
call *(%esp)
addl %esp,4

--
    Manfred

