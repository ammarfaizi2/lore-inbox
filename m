Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbRDFV0Y>; Fri, 6 Apr 2001 17:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRDFV0O>; Fri, 6 Apr 2001 17:26:14 -0400
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:2043 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S132416AbRDFV0D>; Fri, 6 Apr 2001 17:26:03 -0400
Date: Fri, 6 Apr 2001 22:25:34 +0100 (BST)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: isaac albeniz <albeniz@earthlink.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: modutils / sound
In-Reply-To: <Pine.LNX.4.33.0104061340250.17608-100000@glass.pipe.org>
Message-ID: <Pine.LNX.4.21.0104062203400.32709-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sound modules don't autoload - when you start what? I noticed a strange
thing too - when I start a light window-manager, like lfwm or fvwm2 and
THEN start, say, kmix - modules do get loaded, however, if I try starting
kde with sounds configured when the modules are NOT loaded, it complains
'no sound device available', and the modules don't get loaded. However, if
I then start kmix or smth - modules do get loaded and sound is ok. Are you
observing smth similar? If your modules don't get autoloaded ever... Well,
did you check depmod -ea? What kernel version? Sorry, can't help more so
far... Looks like you are using OSS drivers. Did you ever try ALSA? I had
problems, when I tried ALSA after OSS and then switched back - are all
your /dev-ices with char-major 14 ok?

Also, I think, it happens that some modules just can't be forced to
autoload with some kernel versions...

Guennadi

On Fri, 6 Apr 2001, isaac albeniz wrote:

> 
> I just upgraded to modutils 2.4.5, and my sound modules wont autoload
> anymore. They work fine if i manually load them but that is an
> unacceptable solution.
> 
> alias char-major-14 sb
> options sb io=0x220 irq=5 dma=1 dma16=5 mpu_io=0x330
> options sound dmabuf=1
> 
> Those are the lines ive always used in modules.conf and have always worked
> till i upgraded.
> 
> Any suggestions? Please CC me im not on the list.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk


