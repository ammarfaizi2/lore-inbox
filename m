Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273082AbRIOVdV>; Sat, 15 Sep 2001 17:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273086AbRIOVdL>; Sat, 15 Sep 2001 17:33:11 -0400
Received: from [194.213.32.137] ([194.213.32.137]:44548 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273082AbRIOVdD>;
	Sat, 15 Sep 2001 17:33:03 -0400
Message-ID: <20010914230028.A228@bug.ucw.cz>
Date: Fri, 14 Sep 2001 23:00:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [x86-64 patch 11/11] WaveFront timing fix for x86-64
In-Reply-To: <20010913184541.A2651@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010913184541.A2651@suse.cz>; from Vojtech Pavlik on Thu, Sep 13, 2001 at 06:45:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds necessary timing support for x86-64 into the wavefront
> driver.
> 
> This is the last patch of the series.
> 
> Thanks for your attention.

Why not current_cpu_data.loops_per_jiffy?

								Pavel

> Vojtech
> 
> diff -urN linux-x86_64/drivers/sound/wavfront.c linux/drivers/sound/wavfront.c
> --- linux-x86_64/drivers/sound/wavfront.c	Thu Sep 13 15:17:33 2001
> +++ linux/drivers/sound/wavfront.c	Tue Sep 11 09:49:17 2001
> @@ -101,6 +101,10 @@
>  #if defined(__i386__)
>  #define LOOPS_PER_TICK current_cpu_data.loops_per_jiffy
>  #endif
> +
> +#if defined(__x86_64__)
> +#define LOOPS_PER_TICK	loops_per_jiffy
> +#endif
>   
>  #define _MIDI_SYNTH_C_
>  #define MIDI_SYNTH_NAME	"WaveFront MIDI"
> 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
