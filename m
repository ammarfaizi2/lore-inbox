Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSFJSYn>; Mon, 10 Jun 2002 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSFJSYm>; Mon, 10 Jun 2002 14:24:42 -0400
Received: from doninha.ip.pt ([195.23.132.12]:60332 "HELO doninha.ip.pt")
	by vger.kernel.org with SMTP id <S315634AbSFJSYi>;
	Mon, 10 Jun 2002 14:24:38 -0400
Message-ID: <20020610182431.15750.qmail@webmail.clix.pt>
X-Originating-IP: [198.62.10.2]
X-Mailer: Clix Webmail 2.0
In-Reply-To: <auto-000027137622@mx12.cluster1.charter.net>
From: "Rui Sousa" <rui.p.m.sousa@clix.pt>
To: Cory Watson <gphat@cafes.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: emu10k1, 2.5.21
Date: Mon, 10 Jun 2002 18:24:31 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cory Watson writes:

This is for the ALSA emu10k1 driver, not the OSS.

Rui Sousa

> emu10k1 wouldn't compile for me, this patch fixes it via #including 
> linux/init.h.  Perhaps this is the wrong way, but it works for me.
> 
> Attached, and below:
> 
> iff -urN a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
> --- a/sound/pci/emu10k1/emufx.c	Sun May  5 22:37:52 2002
> +++ b/sound/pci/emu10k1/emufx.c	Sun Jun  9 15:04:01 2002
> @@ -29,6 +29,7 @@
>  #include <sound/driver.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/init.h>
>  #include <sound/core.h>
>  #include <sound/emu10k1.h>
>  
> diff -urN a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
> --- a/sound/pci/emu10k1/emumixer.c	Sun May  5 22:37:58 2002
> +++ b/sound/pci/emu10k1/emumixer.c	Sun Jun  9 15:03:36 2002
> @@ -29,6 +29,7 @@
>  #define __NO_VERSION__
>  #include <sound/driver.h>
>  #include <linux/time.h>
> +#include <linux/init.h>
>  #include <sound/core.h>
>  #include <sound/emu10k1.h>
>  
> diff -urN a/sound/pci/emu10k1/emumpu401.c b/sound/pci/emu10k1/emumpu401.c
> --- a/sound/pci/emu10k1/emumpu401.c	Sun May  5 22:37:55 2002
> +++ b/sound/pci/emu10k1/emumpu401.c	Sun Jun  9 15:01:36 2002
> @@ -22,6 +22,7 @@
>  #define __NO_VERSION__
>  #include <sound/driver.h>
>  #include <linux/time.h>
> +#include <linux/init.h>
>  #include <sound/core.h>
>  #include <sound/emu10k1.h>
>  
> diff -urN a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
> --- a/sound/pci/emu10k1/emupcm.c	Sun May  5 22:37:53 2002
> +++ b/sound/pci/emu10k1/emupcm.c	Sun Jun  9 15:02:52 2002
> @@ -29,6 +29,7 @@
>  #include <sound/driver.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> +#include <linux/init.h>
>  #include <sound/core.h>
>  #include <sound/emu10k1.h>
>  
> diff -urN -X dontdiff a/sound/pci/emu10k1/emuproc.c 
> b/sound/pci/emu10k1/emuproc.c
> --- a/sound/pci/emu10k1/emuproc.c	Sun May  5 22:37:59 2002
> +++ b/sound/pci/emu10k1/emuproc.c	Sun Jun  9 15:03:15 2002
> @@ -28,6 +28,7 @@
>  #define __NO_VERSION__
>  #include <sound/driver.h>
>  #include <linux/slab.h>
> +#include <linux/init.h>
>  #include <sound/core.h>
>  #include <sound/emu10k1.h>
>  
> -- 
> Cory 'G' Watson
> 
> "You know the old saying -- any technology sufficiently advanced is 
> indistinguishable from a Perl script."
>      - "Programming Perl", page 301





--
Crie o seu Email Grátis no Clix em
http://registo.clix.pt/
