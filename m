Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbTJAWV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJAWV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:21:28 -0400
Received: from unixbox.com ([154.6.115.65]:65298 "EHLO shell.unixbox.com")
	by vger.kernel.org with ESMTP id S262387AbTJAWV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:21:26 -0400
Date: Wed, 1 Oct 2003 15:20:30 -0700 (PDT)
From: Ani Joshi <ajoshi@unixbox.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Henrik Christian Grove <grove@sslug.dk>, linux-kernel@vger.kernel.org
Subject: Re: Radeon framebuffer problems i 2.6.0-test6
In-Reply-To: <16250.4701.976132.141380@wombat.chubb.wattle.id.au>
Message-ID: <20031001151529.D57653@shell.unixbox.com>
References: <7gisna11e1.fsf@serena.fsr.ku.dk> <16250.4701.976132.141380@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My recent experience in patch submission makes me believe that sending
patches to the kernel maintainers is like sending the patch into a vacuum.
I don't care to maintain any of the drivers with my name on them anymore
partly because of such problems.  I imagine if you keep posting the patch
to the list it will someday reach kernel.org, since apparently being the
author of a driver doesn't mean your patches will be applied nowdays.

good luck! :)

ani

On Wed, 1 Oct 2003, Peter Chubb wrote:

>
>
> Try this patch that's been floating around for a while.
>
> Ani, can you please push this patch to Linus?  It fixes the Radeon
> problems for a lot of people.
>
>
> ===== drivers/video/radeonfb.c 1.30 vs edited =====
> --- 1.30/drivers/video/radeonfb.c	Fri Aug  1 01:58:45 2003
> +++ edited/drivers/video/radeonfb.c	Tue Sep  9 13:18:36 2003
> @@ -2090,7 +2090,7 @@
>
>  	}
>  	/* Update fix */
> -        info->fix.line_length = rinfo->pitch*64;
> +        info->fix.line_length = mode->xres_virtual*(mode->bits_per_pixel/8);
>          info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
>
>  #ifdef CONFIG_BOOTX_TEXT
>
