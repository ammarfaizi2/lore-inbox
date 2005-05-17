Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVEQPDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVEQPDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVEQPDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:03:05 -0400
Received: from 4.34.76.83.cust.bluewin.ch ([83.76.34.4]:54346 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261559AbVEQPC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:02:59 -0400
Date: Tue, 17 May 2005 16:59:31 +0200
From: Karel Kulhavy <clock@twibright.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA make menuconfig Help description missing
Message-ID: <20050517145931.GA11564@kestrel>
References: <20050517123549.GA2378@kestrel> <s5hfywmotdd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hfywmotdd.wl@alsa2.suse.de>
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 03:49:02PM +0200, Takashi Iwai wrote:
> At Tue, 17 May 2005 14:35:49 +0200,
> Karel Kulhavy wrote:
> > 
> > Hello
> > 
> > v2.6.11 make menuconfig -> Device Drivers -> Sound -> Advanced Linux
> > Sound Architecture and
> > 
> > v2.6.11 make menuconfig -> Device Drivers -> Sound -> Advanced Linux
> > Sound Architecture -> Advanced Linux Sound Architecture
> > 
> > are missing their help descriptions:
> > 
> > "There is no help available for this kernel option."
> > 
> > Therefore the user is unable to determine how to use this subsystem
> > at all.
> 
> Something like below fixes the problem?

Yes, tried, fixes ;-)

However I suggest that a pointer to user documentation for ALSA be added
to the Help.

For example I have a problem when I run XMMS, Skype says something like
"can't open /dev/dsp" and don't know where to start.  The only thing I
know is that 1) I have ALSA turned on and 2) I want to know how to make
it accept more data streams from the programs and mix them together.

CL<
> 
> 
> Takashi
> 
> 
> --- linux/sound/Kconfig	22 Mar 2005 10:44:59 -0000	1.9
> +++ linux/sound/Kconfig	17 May 2005 13:47:08 -0000
> @@ -42,6 +42,8 @@
>  config SND
>  	tristate "Advanced Linux Sound Architecture"
>  	depends on SOUND
> +	help
> +	  Say 'Y' or 'M' to enable ALSA (Advanced Linux Sound Architecture)
>  
>  source "sound/core/Kconfig"
>  
