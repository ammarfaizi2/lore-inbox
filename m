Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUJORXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUJORXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268232AbUJORXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:23:19 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:12968 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S268231AbUJORWT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:22:19 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2 : oops...]
Date: Fri, 15 Oct 2004 10:22:38 -0700
User-Agent: KMail/1.6.2
Cc: Paul Fulghum <paulkf@microgate.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.44L0.0410151215440.1052-100000@ida.rowland.org> <1097858939.2820.3.camel@deimos.microgate.com>
In-Reply-To: <1097858939.2820.3.camel@deimos.microgate.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410151022.38486.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 October 2004 9:48 am, Paul Fulghum wrote:
> On Fri, 2004-10-15 at 11:18, Alan Stern wrote:
> > Your explanation sounds entirely reasonable to me.  Can you pass it on to 
> > the people responsible for the generic-irq subsystem?
> 
> I CCd Ingo Molnar, who appears to be the originator
> of these patches.
> 
> There was a question in my mind about the hcd->description field.
> Should it be unique for each device instance instead
> of uniform for all device instances on a driver?

It describes the driver ... I think the problem would be that
the IRQ registration API seems to have changed requirements.

Those labels were never previously treated as anything other
than a way to make /proc/interrupts more meaningful.  The
only request_irq() parameter that "must be globally unique"
is the final "void *dev_id".

- Dave
