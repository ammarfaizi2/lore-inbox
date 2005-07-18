Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVGRLmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVGRLmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVGRLmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:42:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54236 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261655AbVGRLl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:41:56 -0400
Date: Mon, 18 Jul 2005 13:41:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Preserve hibenate-system-image on startup
Message-ID: <20050718114158.GB1869@elf.ucw.cz>
References: <42D9FA0C.3060609@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D9FA0C.3060609@sm.sony.co.jp>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We are now investigating fast startup/shutdown using
> 2.6 kernel PM functions.
> 
> An attached patch enables kernel to preserve system image
> on startup, to implement "Snapshot boot".Majordomo@vger.kernel.org wrote:
> Conventionally system image will be broken after startup.
> 
> Snapshot boot uses un-hibernate from a permanent system image for
> startup. During shutdown, does a conventional shutdown without
> saving a system image.
> 
> We'll explain concept and initial work at OLS. So if you have
> interest, we can talk with you at Ottawa.

Interesting....

> +config PRESERVE_SWSUSP_IMAGE
> +	bool "Preserve swsuspend image"
> +	depends on SOFTWARE_SUSPEND
> +	default n
> +	---help---
> +	  Useally boot with swsup destories the swsusp image.
> +	  This function enables to preserve swsup image over boot cycle. 
> +	  Default behavior is not chaged even this configuration turned on.
> +
> +	  To preseve swsusp image, specify following option to command line;
> +
> +		prsv-img

You are missing "eeeae" here.

> +}
> +
> +/**
> + * swsusp_swpoff -  Turn off swap and set signature for swsusp image
             ~~~~~~
		missing "a".

In general, the patch looks a bit too long, given it only needs to
comment out one write...
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
