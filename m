Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWJJIKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWJJIKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWJJIKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:10:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:10411 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965073AbWJJIKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:10:52 -0400
Date: Tue, 10 Oct 2006 01:01:10 -0700
From: Greg KH <greg@kroah.com>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: Amit Choudhary <amit2030@gmail.com>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: [stable] [PATCH 2.6.19-rc1] drivers/media/dvb/bt8xx/dvb-bt8xx.c: check kmalloc() return value.
Message-ID: <20061010080110.GA20169@kroah.com>
References: <20061008231034.e50118df.amit2030@gmail.com> <452A09A1.8040808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452A09A1.8040808@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 12:34:41PM +0400, Manu Abraham wrote:
> Amit Choudhary wrote:
> > Description: Check the return value of kmalloc() in function frontend_init(), in file drivers/media/dvb/bt8xx/dvb-bt8xx.c.
> > 
> > Signed-off-by: Amit Choudhary <amit2030@gmail.com>
> > 
> > diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> > index fb6c4cc..14e69a7 100644
> > --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> > +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> > @@ -665,6 +665,10 @@ static void frontend_init(struct dvb_bt8
> >  	case BTTV_BOARD_TWINHAN_DST:
> >  		/*	DST is not a frontend driver !!!		*/
> >  		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
> > +		if (!state) {
> > +			printk("dvb_bt8xx: No memory\n");
> > +			break;
> > +		}
> >  		/*	Setup the Card					*/
> >  		state->config = &dst_config;
> >  		state->i2c = card->i2c_adapter;
> > -
> 
> 
> Signed-off-by: Manu Abraham <manu@linuxtv.org>

Care to send the full patch in a format that we can apply it to the
-stable tree?

thanks,

greg k-h
