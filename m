Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSFKQKf>; Tue, 11 Jun 2002 12:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSFKQKe>; Tue, 11 Jun 2002 12:10:34 -0400
Received: from dsl-213-023-038-217.arcor-ip.net ([213.23.38.217]:39041 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317148AbSFKQKd>;
	Tue, 11 Jun 2002 12:10:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Russell King <rmk@arm.linux.org.uk>, Keith Owens <kaos@ocs.com.au>
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Date: Tue, 11 Jun 2002 18:08:22 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020609175804.B8761@flint.arm.linux.org.uk> <5896.1023750165@ocs3.intra.ocs.com.au> <20020611083947.A1346@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17HoBz-0000A0-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 June 2002 09:39, Russell King wrote:
> On Tue, Jun 11, 2002 at 09:02:45AM +1000, Keith Owens wrote:
> > >linux/drivers/block/smart1,2.h
> > >linux/drivers/scsi/53c7,8xx.c
> > >linux/drivers/scsi/53c7,8xx.h
> > >linux/drivers/scsi/53c7,8xx.scr
> > >linux/arch/arm/mm/proc-arm6,7.S
> > >linux/arch/arm/mm/proc-arm2,3.S
> > 
> > kbuild 2.5 can handle filenames with ',' in the name.  I do not believe
> > in restricting what users can do unless there is absolutely no
> > alternative.  In this case a smarter build system can handle special
> > filenames.
> 
> I've already fixed up the two ARM ones.  That leaves one problematic
> file - 53c7,8xx.c.
> 
> Is it really worth adding complexity to a build system to work around
> what is really a GCC bug for just one file?  I don't think so.

Are you sure that complexity was added just to handle commas in names?
Or is it really an example of how good design never gave this bug a
chance to exist in the first palce.

I *really* don't like the idea of papering over such bugs by curing the
symptoms, as you seem to be advocating.

-- 
Daniel
