Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTESIcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTESIcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:32:23 -0400
Received: from gate.perex.cz ([194.212.165.105]:16116 "EHLO pnote.perex-int.cz")
	by vger.kernel.org with ESMTP id S261305AbTESIcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:32:21 -0400
Date: Mon, 19 May 2003 10:44:46 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 2.2 compat cruft from sound/
In-Reply-To: <20030518181551.A28588@lst.de>
Message-ID: <Pine.LNX.4.44.0305191041540.21997-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Christoph Hellwig wrote:

> Not that it actually is compilable due to random changes..
> 
> 
> --- 1.20/sound/core/control.c	Thu Apr 10 12:28:10 2003
> +++ edited/sound/core/control.c	Sat May 17 19:41:59 2003
> @@ -931,9 +931,7 @@
>  
>  static struct file_operations snd_ctl_f_ops =
>  {
> -#ifndef LINUX_2_2
>  	.owner =	THIS_MODULE,
> -#endif
>  	.read =		snd_ctl_read,
>  	.open =		snd_ctl_open,
>  	.release =	snd_ctl_release,

We still support the 2.2 kernel. We are trying to separate this 
"compatibility" code to another location, but in some cases, it is 
difficult. Please, make changes only for /sound/oss tree. Thank you.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

