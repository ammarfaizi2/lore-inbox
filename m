Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWJIGhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWJIGhr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 02:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWJIGhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 02:37:47 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:29610 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932260AbWJIGhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 02:37:46 -0400
Date: Mon, 9 Oct 2006 08:37:45 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       R.E.Wolff@BitWizard.nl
Subject: Re: drivers/char/specialix.c: broken baud conversion
Message-ID: <20061009063744.GB2877@bitwizard.nl>
References: <20061008221818.GL6755@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008221818.GL6755@stusta.de>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 12:18:19AM +0200, Adrian Bunk wrote:
> +       if (baud == 38400) {
>                 if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
>                         baud ++;
>                 if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
>                         baud += 2;
>         }
> 
> Increasing the index for baud_table[] by 1 or 2 is quite different from 
> increasing baud by 1 or 2.

In that range, 
	baud <<= 1; 
and
	baud <<= 2; 

should work. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
