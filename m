Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130500AbQKJOr2>; Fri, 10 Nov 2000 09:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130999AbQKJOrS>; Fri, 10 Nov 2000 09:47:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31168 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130500AbQKJOq7>;
	Fri, 10 Nov 2000 09:46:59 -0500
Date: Fri, 10 Nov 2000 09:46:43 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Swiedler <chris.swiedler@sevista.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] oom_nice
In-Reply-To: <NDBBIAJKLMMHOGKNMGFNKEFLCPAA.chris.swiedler@sevista.com>
Message-ID: <Pine.GSO.4.21.0011100945370.12920-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Nov 2000, Chris Swiedler wrote:

> Here's an updated version of the "oom_nice" patch. It allows a sysadmin to
> set the "oom niceness" for processes, either by PID or by process name. The
> oom niceness value factors into the badness() function called by Rik's
> OOM killer. Negative values decrease the chance that the process will be
> killed, and positive values increase it.
> 
> The usage is:
> 
> echo [PID|process_name]=oom_niceness > /proc/sys/vm/oom_nice

Please, _not_ in /proc/sys. It's for sysctls and let's keep it that way.
BTW, what's wrong with /proc/<pid>/oom_nice?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
