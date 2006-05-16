Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWEPQgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWEPQgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWEPQgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:36:05 -0400
Received: from waste.org ([64.81.244.121]:64904 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932113AbWEPQgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:36:04 -0400
Date: Tue, 16 May 2006 11:29:34 -0500
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, liux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make number of IDE interfaces configurable
Message-ID: <20060516162934.GR24227@waste.org>
References: <20060512222952.GQ6616@waste.org> <20060516160250.GE5677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516160250.GE5677@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 06:02:50PM +0200, Adrian Bunk wrote:
> On Fri, May 12, 2006 at 05:29:52PM -0500, Matt Mackall wrote:
> >...
> > --- 2.6.orig/include/linux/ide.h	2006-05-11 15:07:32.000000000 -0500
> > +++ 2.6/include/linux/ide.h	2006-05-12 14:01:53.000000000 -0500
> > @@ -252,7 +252,8 @@ static inline void ide_std_init_ports(hw
> >  
> >  #include <asm/ide.h>
> >  
> > -#ifndef MAX_HWIFS
> > +#if !defined(MAX_HWIFS) || defined(CONFIG_EMBEDDED)
> > +#undef MAX_HWIFS
> >  #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
> >  #endif
> 
> Why do you need this?

Doesn't work without it?

Most platforms define MAX_HWIFS.

-- 
Mathematics is the supreme nostalgia of our time.
