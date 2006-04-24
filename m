Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWDXVl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWDXVl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWDXVl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:41:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751306AbWDXVl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:41:58 -0400
Date: Mon, 24 Apr 2006 14:41:55 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] irq: record edge-level setting
Message-ID: <20060424144155.7561fe8e@localhost.localdomain>
In-Reply-To: <1145915394.1635.57.camel@localhost.localdomain>
References: <20060424114105.113eecac@localhost.localdomain>
	<Pine.LNX.4.64.0604241156340.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
	<1145908402.3116.63.camel@laptopd505.fenrus.org>
	<20060424201646.GA23517@devserv.devel.redhat.com>
	<1145911417.3116.69.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
	<20060424142243.519d61f1@localhost.localdomain>
	<1145915394.1635.57.camel@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006 22:49:54 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2006-04-24 at 14:22 -0700, Stephen Hemminger wrote:
> > Record the level vs edge-triggered status of IRQ to allow for error checks later.
> > 
> > Note: this is only done fir i386/x86_64.
> 
> This doesn't work for IRQ's routed via the EISA IRQ routing or for MCA
> that I can see. It also seems to assume the chip state at boot is right.
> For EISA you need to real the EISA irq register to see what is level and
> what is edge (and work out what is EISA), for MCA it is board dependant.

Maybe that's why it never was done in the past, too much work and historical
baggage.
