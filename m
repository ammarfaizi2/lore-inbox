Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261912AbREPNGM>; Wed, 16 May 2001 09:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbREPNGC>; Wed, 16 May 2001 09:06:02 -0400
Received: from hermes.sistina.com ([208.210.145.141]:43526 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S261912AbREPNFv>;
	Wed, 16 May 2001 09:05:51 -0400
Date: Wed, 16 May 2001 15:03:12 +0000
From: "Heinz J. Mauelshagen" <Mauelshagen@sistina.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mauelshagen@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: LVM 1.0 release decision
Message-ID: <20010516150312.B13039@sistina.com>
Reply-To: Mauelshagen@sistina.com
In-Reply-To: <20010511162745.B18341@sistina.com> <E14yDyI-0000yE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14yDyI-0000yE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 03:32:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 03:32:46PM +0100, Alan Cox wrote:
> > This leads to the dilemma, that trying to avoid further differences between
> > our LVM releases and the stock kernel code would force us into postponing
> > the pending LVM 1.0 release accordingly which OTOH is incovenient for the LVM
> > user base.
> > 
> > In regard to this situation we'ld like to know about your oppinion on
> > the following request:
> > is it acceptable to release 1.0 soon *before* all patches to reach the 1.0 code
> 
> Please fix the binary incompatibility in the on disk format between the current
> code and your new release _before_ you do that.

?

The new code *can* automagically read and deal with 0.8 created VGDAs.
What are you refering too in detail here?


> The last patches I was sent
> would have screwed every 64bit LVM user.

Patrick is investigating here.

> 
> A new format is fine but import old ones properly. And if you do a new format
> stop using kdev_t on disk - it will change size soon

We don't need it any longer in the PV struct.

In the LV struct we can change it easily, because we just need the minor
number which will nicely fit into the 32 bit we have.

> 
> Alan

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
