Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSFKHla>; Tue, 11 Jun 2002 03:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSFKHl2>; Tue, 11 Jun 2002 03:41:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41230 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316889AbSFKHj4>; Tue, 11 Jun 2002 03:39:56 -0400
Date: Tue, 11 Jun 2002 08:39:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Message-ID: <20020611083947.A1346@flint.arm.linux.org.uk>
In-Reply-To: <20020609175804.B8761@flint.arm.linux.org.uk> <5896.1023750165@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 09:02:45AM +1000, Keith Owens wrote:
> >linux/drivers/block/smart1,2.h
> >linux/drivers/scsi/53c7,8xx.c
> >linux/drivers/scsi/53c7,8xx.h
> >linux/drivers/scsi/53c7,8xx.scr
> >linux/arch/arm/mm/proc-arm6,7.S
> >linux/arch/arm/mm/proc-arm2,3.S
> 
> kbuild 2.5 can handle filenames with ',' in the name.  I do not believe
> in restricting what users can do unless there is absolutely no
> alternative.  In this case a smarter build system can handle special
> filenames.

I've already fixed up the two ARM ones.  That leaves one problematic
file - 53c7,8xx.c.

Is it really worth adding complexity to a build system to work around
what is really a GCC bug for just one file?  I don't think so.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

