Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVHTI3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVHTI3F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 04:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVHTI3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 04:29:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48874 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750748AbVHTI3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 04:29:03 -0400
Date: Sat, 20 Aug 2005 10:28:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] simplify SOFTWARE_SUSPEND dependencies
Message-ID: <20050820082855.GA1829@elf.ucw.cz>
References: <20050820040723.GN3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820040723.GN3615@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch expresses the same dependencies in a more simple way.

I have this currently in my tree:

        depends on PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))

(I really want to remove experimental), but it is not urgent enough to
push heavily.
								Pavel

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.13-rc6-mm1-full/kernel/power/Kconfig.old	2005-08-20 06:02:49.000000000 +0200
> +++ linux-2.6.13-rc6-mm1-full/kernel/power/Kconfig	2005-08-20 06:03:13.000000000 +0200
> @@ -28,7 +28,7 @@
>  
>  config SOFTWARE_SUSPEND
>  	bool "Software Suspend"
> -	depends on EXPERIMENTAL && PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
> +	depends on EXPERIMENTAL && PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))
>  	---help---
>  	  Enable the possibility of suspending the machine.
>  	  It doesn't need APM.
> 

-- 
if you have sharp zaurus hardware you don't need... you know my address
