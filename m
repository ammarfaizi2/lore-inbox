Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271486AbRIFRDG>; Thu, 6 Sep 2001 13:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271487AbRIFRC4>; Thu, 6 Sep 2001 13:02:56 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:62730 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S271486AbRIFRCo>;
	Thu, 6 Sep 2001 13:02:44 -0400
Date: Thu, 6 Sep 2001 11:03:02 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010906110302.B2323@qcc.sk.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010906203854.A23109@castle.nmd.msu.ru> <20010906164314.74F68BC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010906164314.74F68BC06C@spike.porcupine.org>; from wietse@porcupine.org on Thu, Sep 06, 2001 at 12:43:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wietse Venema <wietse@porcupine.org> wrote:
> 
> An SMTP MTA is required to correctly recognize user@[ip.address]
> as local.  That's the rules, like it or not. These address forms
> are actually being used, like it or not.

Yes.  MTAs have to work around this; qmail does a reasonable job.  Why
not look at how djb does this?  See ipme.c.
 
> It also is desirable for an MTA to treat clients on local subnets
> different than strangers that happen to be on the same class A,
> like it or not.  Failure to do so can make one end up on black
> lists, like it or not.

Having an MTA automatically treat clients on "local subnets" differently
than the rest of the 'net at large is definitely _not_ desirable.  The
administrator should have to explicitly configure the MTA to grant
additional access to every subnet he desires; anything else is begging
for trouble in the form of absued relaying privileges.
 
Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
