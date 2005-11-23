Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVKWPbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVKWPbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVKWPbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:31:17 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:27495 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751021AbVKWPbQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:31:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oHJ0eCqtd8pijx/whBPnLnm51VJZEZMlV7Ju55QJsZZOFzELtOOj1D9Vo7X0emrrYJHkFvW/tupuP+l2BWNz4Ag+d+tNLjHPM3Qg0YkOnUvGIcI/QV5vANe8GnsghqPCNNwhUOQP88qVXdDY+HSPAcYJcT7DktizmUk5F/BGeVg=
Message-ID: <9e4733910511230731p12d7c712pe20e89886832c95f@mail.gmail.com>
Date: Wed, 23 Nov 2005 10:31:15 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: Christmas list for the kernel
In-Reply-To: <20051123152558.GB15449@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
	 <9e4733910511230719h67fa96bdxdeb654aa12f18e67@mail.gmail.com>
	 <20051123152558.GB15449@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > This is confusing...
> >
> > Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> > serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> > serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> > serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Could this be the source of the four port versus the two port
confusion in the higher layers? It says 4 ports and list four ports,
but two are duplicates.

>
> Yes it is, but it's down to the way folk want things to operate.  The
> first two come from the legacy table in include/asm-*/serial.h.  The
> second two come from something-that-I-have-no-clue-about but is probably
> ACPI related.  Dunno.  We're back to the far-too-many-complex-ways-to-
> initialise-serial problem again that I've given up really caring how
> many lines of serial printk junk folk end up with.  I can't fight it
> all.


--
Jon Smirl
jonsmirl@gmail.com
