Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSE2Vx1>; Wed, 29 May 2002 17:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315547AbSE2Vx0>; Wed, 29 May 2002 17:53:26 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:63369 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315540AbSE2VxZ>; Wed, 29 May 2002 17:53:25 -0400
Date: Wed, 29 May 2002 16:53:24 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Arnaud Launay <asl@launay.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 : 'make dep' error
In-Reply-To: <20020529212225.GA10412@launay.org>
Message-ID: <Pine.LNX.4.44.0205291650180.9971-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Arnaud Launay wrote:

> Or use the following:
> 
> --- linux-2.5.19-old/scripts/Makefile	Wed May 29 20:42:56 2002
> +++ linux/scripts/Makefile	Wed May 29 21:46:58 2002
> @@ -8,7 +8,7 @@
>  	$(HOSTCC) $(HOSTCFLAGS) -o $@ $<
>  
>  split-include: split-include.c
> -	$(HOSTCC) $(HOSTCFLAGS) -o $@ $<
> +	$(HOSTCC) $(HOSTCFLAGS) -I $(HPATH) -o $@ $<
>  
>  # xconfig
>  # ---------------------------------------------------------------------------
> 
> I find it perfectly idiotic to tell people to use older kernel
> include. Better to tell them to use stable versions if they do
> not know what they do.

Well, are you sure you know what you're doing? This may get you through
the kernel build (though I suspect you have to do the same for mkdep), but
basically not a single user space application will compile on your
bleeding edge box from now on...

--Kai

