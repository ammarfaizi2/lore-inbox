Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWG1DPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWG1DPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWG1DPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:15:12 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:37565 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751328AbWG1DPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:15:11 -0400
Date: Thu, 27 Jul 2006 23:14:55 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Some const for linux/time.h
Message-ID: <20060728031455.GG24452@filer.fsl.cs.sunysb.edu>
References: <Pine.LNX.4.61.0607272239001.14351@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0607272239001.14351@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 10:40:47PM +0200, Jan Engelhardt wrote:
> Hello,
> 
> 
> time compare functions do not modify their arguments, so they can 
> be marked as const (like some of the functions in time.h are already).
> 
> Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
> 
> diff --fast -Ndpru linux-2.6.17.7~/include/linux/time.h linux-2.6.17.7+/include/linux/time.h
> --- linux-2.6.17.7~/include/linux/time.h	2006-06-06 02:57:02.000000000 +0200
> +++ linux-2.6.17.7+/include/linux/time.h	2006-07-27 22:35:53.308571000 +0200
> @@ -33,7 +33,8 @@ struct timezone {
>  #define NSEC_PER_SEC		1000000000L
>  #define NSEC_PER_USEC		1000L
>  
> -static inline int timespec_equal(struct timespec *a, struct timespec *b)
> +static inline int timespec_equal(const struct timespec *a,
> + const struct timespec *b)

As per CodingStyle, the second line should be "placed substantially to the
right."

Josef Sipek.

-- 
Humans were created by water to transport it upward.
