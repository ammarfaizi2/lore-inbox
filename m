Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318356AbSGYGfT>; Thu, 25 Jul 2002 02:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSGYGfT>; Thu, 25 Jul 2002 02:35:19 -0400
Received: from www.transvirtual.com ([206.14.214.140]:18950 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318356AbSGYGfS>; Thu, 25 Jul 2002 02:35:18 -0400
Date: Wed, 24 Jul 2002 23:38:16 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: A Guy Called Tyketto <tyketto@wizard.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.28: aty128fb.c:1752: incompatible type
In-Reply-To: <20020725055751.GA5875@wizard.com>
Message-ID: <Pine.LNX.4.44.0207242335540.29650-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -DKBUILD_BASENAME=aty128fb   -c -o aty128fb.o aty128fb.c
> aty128fb.c: In function `aty128fb_set_var':
> aty128fb.c:1406: warning: implicit declaration of function `do_install_cmap'
> aty128fb.c: In function `aty128_init':
> aty128fb.c:1752: incompatible type for argument 1 of `fb_alloc_cmap'
> make[2]: *** [aty128fb.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.25/drivers/video'
> make[1]: *** [video] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.25/drivers'
> make: *** [drivers] Error 2
>
>         I can live with 1406. it'll get cleaned up towards code freeze time.
> 1752 is:
>
> fb_alloc_cmap(info->fb_info.cmap, size, 0);

Fix. Missed that change when I back rolled some code changes.

P.S

   NOTE: The drivers using the old fbgen code are now broken. The next set
of fbdev changes will break most drivers. So if you see drivers broken it
is on purpose and please talk to the fbdev driver maintainer about
updating the driver.


