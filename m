Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135981AbRD0GGi>; Fri, 27 Apr 2001 02:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135982AbRD0GG3>; Fri, 27 Apr 2001 02:06:29 -0400
Received: from mozart.stat.wisc.edu ([128.105.5.24]:18439 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S135981AbRD0GGU>; Fri, 27 Apr 2001 02:06:20 -0400
To: Yiping Chen <YipingChen@via.com.tw>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: About rebuild 2.4.x kernel to support SMP.
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D56B@EXCHANGE2>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Yiping Chen's message of "Thu, 26 Apr 2001 23:36:23 +0800"
Date: 27 Apr 2001 01:02:27 -0500
Message-ID: <vbar8yeyj64.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yiping Chen <YipingChen@via.com.tw> writes:
> 
> So, I have two question now, 
> 1. how to determine whether your kernel support SMP?

Type "uname -a", as you did before:

>      Linux lab5-1 2.4.2-2 #1 SMP Wed Apr 25 18:56:05 CST 2001 i686 unknown
                               ^^^
SMP appears here if and only if your kernel was compiled as an SMP
kernel (i.e., with CONFIG_SMP set).  Programmatically, you can get
this same information from the "uname" system call.  The "version"
member for the "utsname" structure will be the complete string:

        #1 SMP Wed Apr 25 18:56:05 CST 2001

That is, you should be able to reliably determine whether or not the
kernel is SMP by simply "strstr"ing for " SMP " in the version string.

> 2. I remember in 2.2.x, when I rebuild the kernel which support SMP, the
> compile
>     argument will include -D__SMP__ , but this time, when I rebuild kernel
> 2.4.2-2 , it didn't  appear.
>     Why? 

The "__SMP__" preprocessor define has been replaced by the
"CONFIG_SMP" configuration file variable.

Kevin <buhr@stat.wisc.edu>
