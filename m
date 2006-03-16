Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752439AbWCPRjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbWCPRjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbWCPRjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:39:52 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:10223 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752439AbWCPRjv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:39:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bZho11vf24QSMcPisGmRH59pZuZe+zbz60xBaN2ztHzRYDLvEPU6QXg8wquGFkzGfJJgKZjrJz5iw3SCjY5xkvM0XmdUYJ28xNF40uY0ARfNmkIA6uQrnOJQEIBB8L7NFxt12LJMrWzZHtc0HCdImXBv7VR1cQMh+XGlZcIVUr8=
Message-ID: <9c21eeae0603160939sa48bbe7i84698c8a2187ae4@mail.gmail.com>
Date: Thu, 16 Mar 2006 09:39:46 -0800
From: "David Brown" <dmlb2000@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rc6-rt7
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Lee Revell" <rlrevell@joe-job.com>
In-Reply-To: <20060316095607.GA28571@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060316095607.GA28571@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from
> the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> the main change in this release is the merge up to John Stultz's GTOD
> -B20 patchset, and Thomas Gleixner's latest -hrt (high resolution
> timers) queue. This, amongst many other fixes, resolves a system-time
> (and uptime) anomaly observable under high load.
>
> Changes since -rt4:
>
>  - merge to John Stultz's GTOD -B20 (Thomas Gleixner)
>
>  - merge to latest -hrt (Thomas Gleixner)
>
>  - zap_pte_range() latency breaker (Hugh Dickins)
>
>  - small latency tracer cleanups
>
> to build a 2.6.16-rc6-rt7 tree, the following patches should be applied:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.16-rc6.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rc6-rt7
>
>         Ingo
> -

I've been having issues with the realtime patch set and using scp
(specifically scp, wget, curl, git, cvs everything else works fine). I
was wondering what extra debugging features are helpful to have built
into the kernel that could help me nail down why this bug is
happening.

Specifically what's happening is scp is freezing my system, there
haven't been any kernel warnings or panics upon execution of scp, it
just freezes, every other application that uses network seems to work
just fine, so far it's just been scp.

- David Brown
