Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757795AbWKYPfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795AbWKYPfc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 10:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757893AbWKYPfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 10:35:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:27573 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1757795AbWKYPfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 10:35:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UpqIR7MxBSlvupillgNzS1X1rKvbhyM08upsI7241QyPfTAaggzV2twsWhbuUY0M414feKaQRuxOoZFmCozQYx1cVvGnsMlMo3zAS0JoiuwSDb5sXL+Treh1YInzXxg80VDYRNTob/K+Wp+e0b4AbeR1EkwTARIjFdmJBMCVwSk=
Message-ID: <5b5833aa0611250735h5bda01b5lc3ae8e2199f51215@mail.gmail.com>
Date: Sat, 25 Nov 2006 11:35:29 -0400
From: "Anderson Lizardo" <anderson.lizardo@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch 0/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Cc: "Pierre Ossman" <drzeus-list@drzeus.cx>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org,
       "Anderson Briglia" <anderson.briglia@indt.org.br>
In-Reply-To: <200611181418.10675.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <455DB1FB.1060403@indt.org.br>
	 <200611181117.54242.david-b@pacbell.net> <455F7E2A.60009@drzeus.cx>
	 <200611181418.10675.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 11/18/06, David Brownell <david-b@pacbell.net> wrote:
> On Saturday 18 November 2006 1:42 pm, Pierre Ossman wrote:
> > David Brownell wrote:
> > > I thought the MMC vendors expected to see the actual user-typed
> > > password get SHA1-hashed into a value which would take up the whole
> > > buffer?  In general that's a good idea, since it promotes use of
> > > longer passphrases (more information) over short ones (easy2crack).
> > >
> >
> > This sounds like policy though, so it is something user space should
> > concern itself with. We should just provide the infrastructure.
>
> The kernel shouldn't hash, right.  But the userspace toos
> probably should be doing that ... they're the other part of
> the infrastructure. :)

Interesting idea, indeed. We'll implement this in our reference UI
(which currently is just a bunch of shell scripts) so we can test the
feasibility of this approach. Additionally, I think it's a good idea
to investigate how other vendors currently support password protection
on their products (for now I've just seen Nokia cellphones with such
support, maybe PDAs or other mobile devices support this?), so we can
have compatible policies, allowing to lock/unlock cards across
devices.

Anyway, I also agree this is out of scope of the kernel support, but
still it's very important for a complete support.

Regards,
-- 
Anderson Lizardo
Open Source Mobile Research Center - OSMRC
Nokia Institute of Technology - INdT
Manaus - Brazil
