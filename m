Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVA2U6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVA2U6n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVA2U6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:58:43 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:34121 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261562AbVA2U55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:57:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FMvrxfayqi8dvVrHHimTbfbWeKv8GweNrmCbXTxz3PNU9opvfyBKdNL69L8DZaeXbcQBUetsFxS3H+eQ0ZO+cmdDL/F3XME5CmsTlq+1U6ZgA/NK3e5UhkF1tylaGbrCCVoZ2UbPM8WPY5bMF+1zwAxYy61cklGscTJTIbHzEXo=
Message-ID: <1295c7b0050129125720854f18@mail.gmail.com>
Date: Sat, 29 Jan 2005 12:57:56 -0800
From: Mike Cumings <mcumings@gmail.com>
Reply-To: Mike Cumings <mcumings@gmail.com>
To: Mike Cumings <mcumings@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Yenta CardBus IRQ storm disabling interrupt
In-Reply-To: <20050129205345.A14428@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1295c7b005012912423352cd9d@mail.gmail.com>
	 <20050129205345.A14428@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

This is a different card (NetGear WG511U) than the USB card that
was discussed in the previous thread.  I haven't tried a 2.4.x kernel
yet, but that was on my list of things to do. :)  Unfortunately, this is
the only machine I've got which has CardBus so I'd have a hard time
attempting to reproduce on another machine.

Mike


On Sat, 29 Jan 2005 20:53:45 +0000, Russell King
<rmk+lkml@arm.linux.org.uk> wrote:
> On Sat, Jan 29, 2005 at 12:42:17PM -0800, Mike Cumings wrote:
> > In my Googling, I encountered a thread on January 10th of this year entitled
> > "yenta_socket rapid fires interrupts" (between Dick Hollenbeck, Linus,
> > and others)
> 
> Out of interest, is it the same cardbus card you're inserting into
> the socket as the problem mentioned above?
> 
> I think what is suspected is that the Cardbus card is holding its
> interrupt output active.  This normally shares the same interrupt
> as the yenta socket status change interrupt, and, since we're
> listening for interrupts from the card, it causes this problem.
> 
> A thought: can you reproduce this problem with 2.4?  Has this cardbus
> card been used with other Linux kernels?  On other machines?
> 
> I suspect what you'll find is that any Linux kernel on any machine
> with this card will exhibit this problem - which would prove my
> theory.
> 
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core
> 


-- 
Mike Cumings
