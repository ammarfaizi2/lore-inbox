Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSLQTpm>; Tue, 17 Dec 2002 14:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSLQTpm>; Tue, 17 Dec 2002 14:45:42 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:7605 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265477AbSLQTpl>; Tue, 17 Dec 2002 14:45:41 -0500
Message-ID: <3DFF80BC.2020709@redhat.com>
Date: Tue, 17 Dec 2002 11:53:32 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171115450.1095-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171115450.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 

> The only ones I found from a quick grep are
>  - sys_recvfrom
>  - sys_sendto
>  - sys_mmap2()
>  - sys_ipc()

All but mmap2 do not use 6 parameters.  They are implemented via the
sys_ipc multiplexer which takes the stack pointer as an argument which
then helps to locate the parameters.


-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

