Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273470AbRIQEzG>; Mon, 17 Sep 2001 00:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273471AbRIQEyq>; Mon, 17 Sep 2001 00:54:46 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:3085 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273470AbRIQEyo>; Mon, 17 Sep 2001 00:54:44 -0400
Message-ID: <3BA5822E.72376A1E@zip.com.au>
Date: Sun, 16 Sep 2001 21:55:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Schroeder <mdhs@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in console driver?
In-Reply-To: <20010916.13320600@sirius.imsch.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Schroeder wrote:
> 
> Hi!
> 
> I suppose there is a bug in the 2.4-kernel console driver
> (../drivers/char/console.c).
> 
> It seems that (if there is a slow video device) this driver disables the
> handling of interrupts while writing or switching the consoles.
> 

Yup.  This was fixed in -ac kernels a few months ago.  We're working
on a merge into Linus' kernels at present - it's still a fairly large
patch though.

The latest diff (against 2.4.10-pre10) is at
http://www.uow.edu.au/~andrewm/linux/2.4.10-pre10-no-console-lock-2.patch

Could you please test it?

-
