Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSFDQlw>; Tue, 4 Jun 2002 12:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSFDQlv>; Tue, 4 Jun 2002 12:41:51 -0400
Received: from www.transvirtual.com ([206.14.214.140]:6162 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315119AbSFDQlu>; Tue, 4 Jun 2002 12:41:50 -0400
Date: Tue, 4 Jun 2002 09:41:34 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: A Guy Called Tyketto <tyketto@wizard.com>
cc: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.20-dj1
In-Reply-To: <20020604070721.GA2946@wizard.com>
Message-ID: <Pine.LNX.4.44.0206040941060.29334-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>         -dj1 oopsed on me at bootup, when kicking in the framebuffer (ATI Rage
> 128/Radeon). The following patch fixed it for me. It's a variant of the patch
> sent in earlier for the same problem. -dj1 fixed pat of it, this should fix
> the rest.
>
> --- linux/drivers/video/fbcmap.c.bork	Mon Jun  3 19:08:43 2002
> +++ linux/drivers/video/fbcmap.c	Mon Jun  3 19:09:45 2002
> @@ -150,7 +150,7 @@
>      else
>  	tooff = from->start-to->start;
>      size = to->len-tooff;
> -    if (size > from->len-fromoff)
> +    if (size > (int)(from->len-fromoff))
>  	size = from->len-fromoff;
>      if (size <= 0)
>  	return;

Thank you. I just added to the fbdev BK repository.

