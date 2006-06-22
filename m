Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWFVW0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWFVW0B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWFVW0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:26:01 -0400
Received: from web36915.mail.mud.yahoo.com ([209.191.85.83]:17300 "HELO
	web36915.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030427AbWFVW0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:26:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Kim7vcb7lP9X3h6TTnaymaX3OgqnfZltr28kXEOHgm/TSaZG8KtXa3Cj959Tu9hfUuryAubRHVssqYnaLFPi1qYZH8EIt6d/wV1PpIKMXt9oH6yW7JTkU7FJehCj4Mg6WmBVOdMM1JH2NaBXQk/P3BgKgd6dvicMw55uZqvHR2Q=  ;
Message-ID: <20060622222600.49601.qmail@web36915.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 23:26:00 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [i2c] [PATCH] I2C bus driver for Philips ARM boards
To: Greg KH <greg@kroah.com>, Vitaly Wool <vitalywool@gmail.com>
Cc: i2c@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060622203559.GA14445@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Greg KH <greg@kroah.com> wrote:

> On Fri, Jun 23, 2006 at 12:17:55AM +0400, Vitaly Wool wrote:
> > On 6/22/06, Greg KH <greg@kroah.com> wrote:
> > >
> > >> +static inline int i2c_pnx_bus_busy(volatile struct i2c_regs *master)
> > >> +{
> > >> +     long timeout;
> > >> +
> > >> +     timeout = TIMEOUT * 10000;
> > >> +     if (timeout > 0 && (master->sts & mstatus_active)) {
> > >
> > >A big hint about this, if you have volatile in your driver, it's
> > >wrong...
> > 
> > 
> > Well, I do remember flames on the subject... Still __raw_readl also uses
> > volatile.
> > Anyway, I can't disagree that ioreadX-based register access are better.
> > Greg, is there anything else I should take care of before re-sending the
> > patch, except for the things that you and Ben pointed out?
> 
> Not that I can think of, that would be a good starting point :)

Would it not make sense to call this driver ip3204 or ph_ip3204 or some such seeing as you
correctly point out that this is a common Philips IP block and is used in other, non pnx, chips?

I'm also not sure why the register map is in the arch-pnx4008 directory as this will require every
chip that has this IP block to have a copy of the file.

Mark

> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Win tickets to the 2006 FIFA World Cup Germany with Yahoo! Messenger. http://advision.webevents.yahoo.com/fifaworldcup_uk/
