Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVKFF4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVKFF4P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 00:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVKFF4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 00:56:15 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:32013 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbVKFF4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 00:56:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=iWwHO0Dc2Y3FfpSTLnSIneJbBbcqOGh+pb70Nc+T+lHGT5szY7/jx2lRZt/yUyTMHX8ZH+3Tnfldp/2wO9wAta9qfVwCicWH/OVkAfQyRwrNXXzSYHvhJlMzCqSa0UsphIVg/5/S2YCbyiyiaRteXrmKYwYWKNYf/Z7+f1JnwT4=
Message-ID: <436D9AF3.8040008@pol.net>
Date: Sun, 06 Nov 2005 13:56:03 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/video/: possible cleanups
References: <20051106005026.GE3668@stusta.de>
In-Reply-To: <20051106005026.GE3668@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the possible cleanups including the following:
> - every file should #include the headers containing the prototypes for
>   it's global functions
> - make needlessly global functions static
> - kyro/STG4000Interface.h: #include video/kyro.h and linux/pci.h
>   instead of a manual "struct pci_dev"
> - i810_main.{c,h}: prototypes for static functions belong to the
>                    C file
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/video/arcfb.c                     |    8 +--
>  drivers/video/console/softcursor.c        |    2 
>  drivers/video/i810/i810-i2c.c             |    1 
>  drivers/video/i810/i810_accel.c           |    1 
>  drivers/video/i810/i810_gtf.c             |    1 
>  drivers/video/i810/i810_main.c            |   51 ++++++++++++++++++--
>  drivers/video/i810/i810_main.h            |   56 +---------------------
>  drivers/video/kyro/STG4000InitDevice.c    |    1 
>  drivers/video/kyro/STG4000Interface.h     |    3 -
>  drivers/video/kyro/STG4000OverlayDevice.c |    1 
>  drivers/video/matrox/matroxfb_g450.c      |    2 
>  drivers/video/nvidia/nv_hw.c              |    1 
>  drivers/video/tdfxfb.c                    |    2 
>  13 files changed, 68 insertions(+), 62 deletions(-)
> 
> --- linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c.old	2005-11-06 00:31:15.000000000 +0100
> +++ linux-2.6.14-rc5-mm1-full/drivers/video/console/softcursor.c	2005-11-06 00:31:30.000000000 +0100
> @@ -17,6 +17,8 @@
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
>  
> +#include "fbcon.h"

I don't think softcursor needs anything in fbcon.h. The rest looks okay.

Tony

