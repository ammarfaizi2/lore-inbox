Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265402AbVBEHvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265402AbVBEHvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 02:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbVBEHvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 02:51:52 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:9114 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265402AbVBEHvn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 02:51:43 -0500
Date: Sat, 5 Feb 2005 08:52:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Frank at BerliOS <mhf@hornet.berlios.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11-rc3 fix compile failure in arch/i386/kernel/i387.c
Message-ID: <20050205075236.GA15715@mars.ravnborg.org>
Mail-Followup-To: Michael Frank at BerliOS <mhf@hornet.berlios.de>,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <4204785E.nailLAW1YU0SF@hornet.berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4204785E.nailLAW1YU0SF@hornet.berlios.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 08:40:14AM +0100, Michael Frank at BerliOS wrote:
> 
> My local tree which was built incrementally since 2.6.8 or so has an extra function:
> 
> $ mdiff -kd xx linux-2.6.10-Vanilla linux-2.6.10-Today
> diff -uN -r -X /etc/sys/dont/kexdiff linux-2.6.10-Vanilla/Makefile linux-2.6.10-Today/Makefile
> --- linux-2.6.10-Vanilla/Makefile       2005-01-04 5:54:17.000000000 +0100
> +++ linux-2.6.10-Today/Makefile 2005-02-05 08:02:11.000000000 +0100
> @@ -336,7 +336,7 @@
>  CFLAGS_MODULE   = $(MODFLAGS)
>  AFLAGS_MODULE   = $(MODFLAGS)
>  LDFLAGS_MODULE  = -r
> -CFLAGS_KERNEL  =-g
> +CFLAGS_KERNEL  =

Just a hint.
Use CONFIG_DEBUG_INFO - then you do not have to edit the Makefile.

	Sam
