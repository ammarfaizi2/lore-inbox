Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSE1Rb2>; Tue, 28 May 2002 13:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSE1Rb1>; Tue, 28 May 2002 13:31:27 -0400
Received: from www.transvirtual.com ([206.14.214.140]:25618 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316851AbSE1Rb1>; Tue, 28 May 2002 13:31:27 -0400
Date: Tue, 28 May 2002 10:31:04 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: A Guy Called Tyketto <tyketto@wizard.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.18-dj1
In-Reply-To: <20020526090046.A32058@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10205281030250.16297-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- orig/drivers/video/fbcmap.c	Fri May  3 11:12:44 2002
> +++ linux/drivers/video/fbcmap.c	Fri May 10 19:39:38 2002
> @@ -150,9 +150,9 @@
>      else
>  	tooff = from->start-to->start;
>      size = to->len-tooff;
> -    if (size > from->len-fromoff)
> +    if (size > (int)(from->len-fromoff))
>  	size = from->len-fromoff;
> -    if (size < 0)
> +    if (size <= 0)
>  	return;
>      size *= sizeof(u16);

I going to push the fix very soon to linus. I have a bunch of new updates. 


