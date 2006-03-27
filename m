Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWC0WfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWC0WfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWC0WfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:35:11 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:25374 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751174AbWC0WfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:35:10 -0500
Date: Mon, 27 Mar 2006 15:35:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-mm1 2/3] rtc: m41t00 driver cleanup
Message-ID: <20060327223552.GB21077@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz> <zt2d4LqL.1141645514.2993990.khali@localhost> <20060307170107.GA5250@mag.az.mvista.com> <20060318001254.GA14079@mag.az.mvista.com> <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com> <20060324012137.GD9560@mag.az.mvista.com> <20060327191111.f7b057cb.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327191111.f7b057cb.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 07:11:11PM +0200, Jean Delvare wrote:
> Hi Mark,
> 
> > This patch does some cleanup to the m41t00 i2c/rtc driver including:
> > - use BCD2BIN/BIN2BCD instead of BCD_TO_BIN/BIN_TO_BCD
> > - use strlcpy instead of strncpy
> > - some whitespace cleanup
> 
> Looks overall good, except:
> 
> > @@ -214,6 +208,7 @@ m41t00_detach(struct i2c_client *client)
> >  
> >  static struct i2c_driver m41t00_driver = {
> >  	.driver = {
> > +		.owner	= THIS_MODULE,
> >  		.name	= M41T00_DRV_NAME,
> >  	},
> >  	.id		= I2C_DRIVERID_STM41T00,
> 
> i2c_add_driver sets the owner for you, so it was omitted here on
> purpose.
> 
> I'll drop that change before pushing the patch to Greg, no need to
> resend.

Hang on for a bit, Jean.  I'm making a new set of patches with yours and
Andrew's comments addressed.  Will be out shortly.

Mark
