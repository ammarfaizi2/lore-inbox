Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVGHSGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVGHSGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 14:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVGHSGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 14:06:10 -0400
Received: from smtp-1.llnl.gov ([128.115.250.81]:12181 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S261483AbVGHSGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 14:06:07 -0400
Date: Fri, 08 Jul 2005 11:06:01 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-12
In-reply-to: <20050708080056.GA31381@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Jaroslav Kysela <perex@suse.cz>
Message-id: <Pine.LNX.4.63.0507081104520.9620@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <20050703181229.GA32741@elte.hu>
 <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
 <20050706100451.GA7336@elte.hu>
 <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain>
 <20050707153103.GA22782@elte.hu>
 <Pine.LNX.4.58.0507071139220.12711@localhost.localdomain>
 <Pine.LNX.4.58.0507071205080.12711@localhost.localdomain>
 <20050707175115.GA28772@elte.hu>
 <Pine.LNX.4.63.0507071402410.6952@ghostwheel.llnl.gov>
 <20050708054129.GA26208@elte.hu> <20050708080056.GA31381@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Ingo Molnar wrote:

>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> tried it and cannot reproduce it, so i'll need the full backtrace of
>> all tasks in your system, whenever sox gets stuck, via:
>
> managed to reproduce it via your script - and with RT_DEADLOCK_DETECT
> turned on the circular deadlock was immediately detected (see the trace
> below). It turns out this is an upstream locking bug in the sound
> subsystem, which has been fixed already - i've merged the upstream fix
> to -51-14. Could you check whether sox works for you now?
>
> 	Ingo
>

That did it. I can now hammer the sound system and sox won't hang anymore.
Thanks!!

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- You've certainly got smooth skin - between the wrinkles, that is. --
