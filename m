Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVCKBjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVCKBjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 20:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVCKBjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 20:39:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64998 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263109AbVCKBh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 20:37:58 -0500
Subject: Re: [01/11] fix amd64 2.6.11 oops on modprobe (saa7110)
From: Josh Boyer <jdub@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: khali@linux-fr.org, kraxel@bytesex.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
In-Reply-To: <20050310230753.GB22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
	 <20050310230753.GB22112@kroah.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 19:37:40 -0600
Message-Id: <1110505061.8075.3.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 15:07 -0800, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> 
> This is a rewrite of the saa7110_write_block function, which was plain
> broken in the case where the underlying adapter supports I2C_FUNC_I2C.
> It also includes related fixes which ensure that different parts of the
> driver agree on the number of registers the chip has.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> --- linux-2.6.11-bk3/drivers/media/video/saa7110.c.orig	Tue Mar  8 10:27:15 2005
> +++ linux-2.6.11-bk3/drivers/media/video/saa7110.c	Tue Mar  8 12:02:45 2005
> @@ -58,10 +58,12 @@
>  #define SAA7110_MAX_INPUT	9	/* 6 CVBS, 3 SVHS */
>  #define SAA7110_MAX_OUTPUT	0	/* its a decoder only */
>  
> -#define	I2C_SAA7110		0x9C	/* or 0x9E */
> +#define I2C_SAA7110		0x9C	/* or 0x9E */

Not that I really care, but isn't there a rule that a patch "... can not
contain any "trivial" fixes in it (spelling changes, whitespace
cleanups, etc.)"?

josh


