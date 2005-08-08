Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVHHVJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVHHVJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVHHVJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:09:23 -0400
Received: from web30311.mail.mud.yahoo.com ([68.142.201.229]:55721 "HELO
	web30311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932233AbVHHVJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:09:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QIwYesOj9XEXoE76MywzmzUsfVFaLvSZqi1//rNWw8Zp5tvZsJBq/KqmE5l3z5wrW6SJtRG8pMEV9f7Uew/seb7+d0if9CcTn3Pz6/WH55nWqWR16jTKJlMBGaMnT/0at8+0wboi+xECpoQprruZcAqc5r1iTqq59aD/90kQoRg=  ;
Message-ID: <20050808210908.1672.qmail@web30311.mail.mud.yahoo.com>
Date: Mon, 8 Aug 2005 22:09:08 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: Where is place of arch independed companion chips?
To: Richard Purdie <rpurdie@rpsys.net>, Greg KH <gregkh@suse.de>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Andrey Volkov <avolkov@varma-el.com>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <1123019379.7782.86.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Richard Purdie <rpurdie@rpsys.net> wrote:

> On Mon, 2005-08-01 at 11:13 -0700, Greg KH wrote:
> > > Good question.  I was about to submit a patch
> that created 
> > > drivers/platform because the toplevel driver for
> MQ11xx is a 
> > > platform_device driver.  Any thoughts on this?
> > 
> > drivers/platform sounds good to me.
> 
> In another thread (about the ucb1x00) we came up
> with the idea of
> drivers/mfd (mfd = multi function devices).
> 
> The core and platform specific parts would live here
> with suitable clear
> naming and the subsection specific parts that were
> separable would live
> in the appropriate place within the kernel.
> 
> Just another idea to add to the mix and removes the
> dilemma of a
> multifunction device with isn't platform based...

This is where my sugguestion on the ucb1x00 comess in
(although it seems to have ot lost as I have had no
reply :-( ). To repeat myself:

I was thinking of something like driver/bus into which
we might also be able to put the I2C and LL3 buses.
The only problem is that this might leave some parts
of the multi function chip homeless (if they can't
find a home in other subsystems).

I need to do more homework ;-), but
I think we need a bus driver (I need to see what the
bus subsystem offers) (IP block specific,
platform and arch independent), a core driver to
register busses and clients, and client drivers.

Mark


> 
> Richard
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
