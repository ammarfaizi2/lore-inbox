Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316365AbSEOKQN>; Wed, 15 May 2002 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316366AbSEOKQM>; Wed, 15 May 2002 06:16:12 -0400
Received: from [195.39.17.254] ([195.39.17.254]:21143 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316365AbSEOKQM>;
	Wed, 15 May 2002 06:16:12 -0400
Date: Wed, 15 May 2002 12:13:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug CPU prep V: x86 non-linear CPU numbers
Message-ID: <20020515101314.GA1152@elf.ucw.cz>
In-Reply-To: <E175jlA-0003X3-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> @@ -1585,7 +1581,7 @@
>  
>  	p = buf;
>  
> -	if ((smp_num_cpus == 1) &&
> +	if ((num_online_cpus() == 1) &&
>  	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
>  		ac_line_status = (bx >> 8) & 0xff;
>  		battery_status = bx & 0xff;

Are you sure? What if you add another CPU just after the test?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
