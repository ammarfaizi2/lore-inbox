Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264555AbRFYORe>; Mon, 25 Jun 2001 10:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264563AbRFYORY>; Mon, 25 Jun 2001 10:17:24 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:32568
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S264555AbRFYORL>; Mon, 25 Jun 2001 10:17:11 -0400
Date: Mon, 25 Jun 2001 16:17:02 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: mhw@wittsend.com
Cc: linux-computone@lazuli.wittsend.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] catch potential null derefs in drivers/char/ip2main.c (245ac16)
Message-ID: <20010625161702.P7356@jaquet.dk>
In-Reply-To: <20010624230606.G847@jaquet.dk> <20010624191400.A17692@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010624191400.A17692@alcove.wittsend.com>; from mhw@wittsend.com on Sun, Jun 24, 2001 at 07:14:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 07:14:00PM -0400, Michael H. Warfield wrote:
[...] 
> 	I'm responsible for the kernel / driver integration end of it
> anyways.
> 
> 	I'll find out what's up with Doug, but this is my issue to deal
> with anyways.  And yes, I'm looking at it.  I've got a couple of other
> patches on the back burner that are overdue for integration.

The pB deref below kinda bothers me. It is last set way above as
part of looping through stuff comparing it to NULL. It seems
bogus to use is as below but I have no clue what should be used
instead.

[..]
> > -			for ( box = 0; box < ABS_MAX_BOXES; ++box )
> > -			{
> > -			    for ( j = 0; j < ABS_BIGGEST_BOX; ++j )
> > -			    {
> > -				if ( pB->i2eChannelMap[box] & (1 << j) )
> > +				for ( box = 0; box < ABS_MAX_BOXES; ++box )
> >  				{

Regards,
  Rasmus
