Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292033AbSBAVBZ>; Fri, 1 Feb 2002 16:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292026AbSBAU70>; Fri, 1 Feb 2002 15:59:26 -0500
Received: from zeke.inet.com ([199.171.211.198]:55009 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S292031AbSBAU7H>;
	Fri, 1 Feb 2002 15:59:07 -0500
Message-ID: <3C5B018E.AE30C544@inet.com>
Date: Fri, 01 Feb 2002 14:58:54 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-10enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim <jimd@starshine.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Jiffies from userspace
In-Reply-To: <20020201123321.A799@mars.starshine.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim wrote:
> 
>  Sorry if this question seems stupid, but would this be a
>  reasonable way to get an estimate of the "current" value of the
>  kernel's jiffies:
> 
>         set -- `cat /proc/self/stat`; echo ${22}
> 
>  ... my reasoning:
> 
>  The cat will start a new process, field 22? of its "stat" node
>  under proc should have the jiffies value at the time the process
>  was started; so the echo command execute "shortly" thereafter.
> 
>  But am I right about the struct of stat:  Is that really in ${22}?
> 
>  (I'm not actually planning on using this technique, it's just a
>   curiosity.  The only practical use I can see for it might be for
>   doing a sanity check on gettime; checking this for an increasing
>   value has a hedge against settime discontinuities).

'cat /proc/uptime' might be more what you want...

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
