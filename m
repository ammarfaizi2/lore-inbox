Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVCKH5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVCKH5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 02:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbVCKH5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 02:57:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:63974 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262592AbVCKH5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 02:57:53 -0500
Date: Thu, 10 Mar 2005 23:57:23 -0800
From: Greg KH <greg@kroah.com>
To: Josh Boyer <jdub@us.ibm.com>
Cc: khali@linux-fr.org, kraxel@bytesex.org, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [01/11] fix amd64 2.6.11 oops on modprobe (saa7110)
Message-ID: <20050311075723.GB29099@kroah.com>
References: <20050310230519.GA22112@kroah.com> <20050310230753.GB22112@kroah.com> <1110505061.8075.3.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110505061.8075.3.camel@windu.rchland.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 07:37:40PM -0600, Josh Boyer wrote:
> On Thu, 2005-03-10 at 15:07 -0800, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > 
> > This is a rewrite of the saa7110_write_block function, which was plain
> > broken in the case where the underlying adapter supports I2C_FUNC_I2C.
> > It also includes related fixes which ensure that different parts of the
> > driver agree on the number of registers the chip has.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Signed-off-by: Chris Wright <chrisw@osdl.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > --- linux-2.6.11-bk3/drivers/media/video/saa7110.c.orig	Tue Mar  8 10:27:15 2005
> > +++ linux-2.6.11-bk3/drivers/media/video/saa7110.c	Tue Mar  8 12:02:45 2005
> > @@ -58,10 +58,12 @@
> >  #define SAA7110_MAX_INPUT	9	/* 6 CVBS, 3 SVHS */
> >  #define SAA7110_MAX_OUTPUT	0	/* its a decoder only */
> >  
> > -#define	I2C_SAA7110		0x9C	/* or 0x9E */
> > +#define I2C_SAA7110		0x9C	/* or 0x9E */
> 
> Not that I really care, but isn't there a rule that a patch "... can not
> contain any "trivial" fixes in it (spelling changes, whitespace
> cleanups, etc.)"?

Good point.  Jean, care to respin the patch?

thanks,

greg k-h
