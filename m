Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbVKGTtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbVKGTtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVKGTtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:49:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965190AbVKGTtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:49:19 -0500
Date: Mon, 7 Nov 2005 11:48:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: rlrevell@joe-job.com, mchehab@brturbo.com.br,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nshmyrev@yandex.ru, v4l@cerqueira.org
Subject: Re: [Alsa-devel] Re: +
 v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch added to -mm
 tree
Message-Id: <20051107114843.0a476d90.akpm@osdl.org>
In-Reply-To: <s5h4q6opi5t.wl%tiwai@suse.de>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
	<20051106001249.48d3ade0.akpm@osdl.org>
	<1131301995.13599.5.camel@mindpipe>
	<1131344803.10094.8.camel@localhost>
	<1131377615.8383.9.camel@mindpipe>
	<s5h4q6opi5t.wl%tiwai@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> > OK, a brief review:
>  > 
>  >  - Why couldn't you use ALSA's DMA API?
> 
>  This is OK, IMO.  Basically, it's up to the driver.
> 
> 
>  >  - The DMA must be stopped and started in the trigger callback, not the
>  > prepare callback.
>  > 
>  >  - If this device lacks a volume control alsa-lib can emulate it in
>  > software, just create a proper /usr/share/alsa/cards/your_card.conf
>  > file.
>  > 
>  >  - By ALSA convention the acceptable formats, sample rates, etc should
>  > be directly defined in the snd_pcm_hardware_t structure.
>  > 
>  >  - dev->oss needs to go.
> 
>  Agreed about the rest.

Thanks, guys.

Despite all that, I am inclined to merge this patch into 2.6.15.  Because
it's in the middle of a 192-patch series and we do need to get the v4l tree
synced up.

Mauro&co, if we do that, do you think the above points can be addressed
inside the next four weeks or so?

