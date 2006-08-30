Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWH3Pfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWH3Pfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWH3Pfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:35:37 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:43598 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750798AbWH3Pfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:35:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=rxZCFk52bIbzgcb/RQu7RMNMBQWZkmVPxE+xOaKD9lSQW00Kka4ARIY+eT0/Jc4xBUrksdMdyeghqyEkK+TRIQnL/7jwuSyHYhv9XDgaOqNn4rGT5AwxgzCeUs8BrkN+BB1O8Hmww2apXZxKcVgJyMdu6Iu4fsFZJ2oNw7pRhAs=  ;
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [Patch] Add spi full duplex mode transfer support
Date: Wed, 30 Aug 2006 08:35:31 -0700
User-Agent: KMail/1.7.1
Cc: "Manish Jaggi" <manish.jaggi@gmail.com>, Luke Yang <luke.adi@gmail.com>,
       linux-kernel@vger.kernel.org
References: <489ecd0c0608292140m483bba2fqa300b55c5f4acf26@mail.gmail.com> <200608292152.58616.david-b@pacbell.net> <2e2add590608300337h3e7e806bs69b63b24d73a104c@mail.gmail.com>
In-Reply-To: <2e2add590608300337h3e7e806bs69b63b24d73a104c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608300835.32535.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 3:37 am, Manish Jaggi wrote:
> 
> On the same lines can we have a member in spi_transfer structure
> like bUseDMA.

LinuxStronglyAvoidsMixedCaseSymbols, see Documentation/CodingStyle.


> In spi PIO mode for short writes of 2 to 8 words is better.
> And we use DMA for larger writes/reads
> 
> What do u think?

I think that such tradeoffs are best hidden from the upper layer
(protocol) drivers, since they're specific to the hardware and
to how the driver is implemented.  So the lower level (controller)
driver should make such tradeoffs.

It's also a change of $SUBJECT but that's a different issue.  :)

- Dave


