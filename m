Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbUJ0E4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbUJ0E4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUJ0E4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:56:37 -0400
Received: from mproxy.gmail.com ([216.239.56.244]:24459 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261636AbUJ0Ezn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:55:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IR/RM7QQVi99doJ3yZ9GWHDkHVkCzQsEprxcefB57oiDiyT6p8G2B+djDlwLS9HvH+TbN/B51xCLi6ea8l/v3JzK6eDEbXzNbJs3jUJgbSVvL4WwDrTua6bR5NvsmtWeUF6Y3ZS/C2RVR5wUfr+l6YfgZqR7GAFcA5y4gt5+gw4=
Message-ID: <21d7e99704102621553310abe8@mail.gmail.com>
Date: Wed, 27 Oct 2004 14:55:42 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Dave Airlie <airlied@gmail.com>,
       "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: timestamps in kernel was Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image updates [u]
In-Reply-To: <20041027062148.GA12123@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410200849.i9K8n5921516@mail.osdl.org>
	 <1098533188.668.9.camel@nosferatu.lan>
	 <20041026221216.GA30918@mars.ravnborg.org>
	 <1098824849.12420.60.camel@nosferatu.lan>
	 <20041026231514.GA3285@mars.ravnborg.org>
	 <21d7e997041026210935b2954a@mail.gmail.com>
	 <20041027062148.GA12123@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Could you try to list the places - maybe they do not all make sense.

Here is my current list in things that directly affect me:
sound/core/info.c contains __DATE__ to tell what date it was compiled
on, I'm not sure this is really needed.
usr/gen_init_cpio.c uses time(NULL) to set mtimes,
scripts/Makefile.lib uses gzip with no -n flag

I can supply patches to get rid of these if people think they are a
good/bad idea...

I also hack scripts/mkcompile_h so it never changes for me (this one
is acceptable as it is very obvious that you have to do it...)

Dave.
