Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284615AbRL0DEM>; Wed, 26 Dec 2001 22:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285634AbRL0DEC>; Wed, 26 Dec 2001 22:04:02 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:27662 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284615AbRL0DDw>;
	Wed, 26 Dec 2001 22:03:52 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: J Sloan <jjs@pobox.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre1 
In-Reply-To: Your message of "Wed, 26 Dec 2001 11:55:27 -0800."
             <3C2A2B2F.1030001@pobox.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Dec 2001 14:03:40 +1100
Message-ID: <11193.1009422220@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001 11:55:27 -0800, 
J Sloan <jjs@pobox.com> wrote:
>Just a reminder, sis woes persist -
>all else seems fine at this point.
>
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18pre1; fi
>depmod: *** Unresolved symbols in 
>/lib/modules/2.4.18pre1/kernel/drivers/char/drm/sis.o
>depmod:         sis_malloc_Ra3329ed5
>depmod:         sis_free_Rced25333

You have to select CONFIG_FB_SIS as well.  This is a deficency in CML1
that is difficult to fix, there are cross directory dependencies.

