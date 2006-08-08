Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWHHPFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWHHPFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWHHPFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:05:51 -0400
Received: from gimli.datakultur.com ([212.28.216.234]:50636 "EHLO
	gimli.datakultur.com") by vger.kernel.org with ESMTP
	id S964900AbWHHPFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:05:50 -0400
From: Hans Eklund <hans@rubico.se>
Reply-To: hans@rubico.se
Organization: Rubico AB
To: David Brownell <david-b@pacbell.net>
Subject: Re: Block request processing for MMC/SD over SPI bus
Date: Tue, 8 Aug 2006 17:07:25 +0200
User-Agent: KMail/1.9.1
References: <200608011037.27721.hans@rubico.se> <20060801084209.GB9556@flint.arm.linux.org.uk>
In-Reply-To: <20060801084209.GB9556@flint.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081707.26003.hans@rubico.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 10:42, Russell King wrote:
> On Tue, Aug 01, 2006 at 10:37:27AM +0200, Hans Eklund wrote:
> > The driver is also independent of any previous MMC related work at this
> > point since MMC over SPI mode differs somewhat from the MMC mode.
>
> You may be interested to know that David Brownell (I believe) has a
> driver which connects the SPI framework to the MMC subsystem, allowing
> the MMC subsystem to talk to cards in SPI mode.
>
> Maybe David can help, or point you in the direction of someone who
> can in the case that I'm misremembering.


Hi again Russel.

I have been talking to David Brownell and some other developers connected to 
ADI(Analgo devices) about the SPI to MMC subsystem driver. That idea will 
probably be implemented in a later phase. For now, i will complete my MMC/SD 
driver that connects to the common SPI framwork and will remain independent 
of the MMC subsystem so it can be used on uClinux platforms(ADI Blackfin 
based to a start) sooner.

For that reason am i talking to you. By a mere coincidence i saw that you are 
the author of /drivers/mmc/mmc_queue.c driver and hence i guess you have some 
knowledge regarding request processing that may be useful to the project.

I would say my driver need some attention to that particular part. And i would 
appreciate any help. As of now, it is a very naive way of walking the request 
queue(a la LDD handbook) and it need to support some basic error handling.

I have posted a copy of the make_request implementation here(~150 lines):

http://hasse.yohoo.nu/strat.txt

It is quite extesively commented, and some important questions at the end.
Hope you can have look at it and maybe give me a guideline.

If you dont have the time, i understand, maybe you know someone who has?

best regards

Hans Eklund,
Rubico AB, www.rubico.se
Sweden.

