Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSLALVP>; Sun, 1 Dec 2002 06:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbSLALVP>; Sun, 1 Dec 2002 06:21:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9741 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261642AbSLALVO>; Sun, 1 Dec 2002 06:21:14 -0500
Date: Sun, 1 Dec 2002 11:28:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues, 2.5.50
Message-ID: <20021201112833.F24114@flint.arm.linux.org.uk>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
	linux-kernel@vger.kernel.org
References: <3DE9E567.4030103@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DE9E567.4030103@colorfullife.com>; from manfred@colorfullife.com on Sun, Dec 01, 2002 at 11:33:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2002 at 11:33:11AM +0100, Manfred Spraul wrote:
> - why do you use __add_wait_queue in wq_sleep_on()? It seems you have 
> copied that code from kernel/sched.c - it's not needed. It was needed for
> 
>     cli()
>     if(condition_var==0)
>         sleep_on(&my_queue);

Do we have to encourage this abonimation?  We do have wait_event().

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

