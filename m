Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTG1LoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTG1LoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:44:13 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:59914 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261180AbTG1LoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:44:10 -0400
Date: Mon, 28 Jul 2003 13:59:24 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 problem
Message-ID: <20030728115924.GB1706@win.tue.nl>
References: <20030726093619.GA973@win.tue.nl> <20030726212513.A0BD.CHRIS@heathens.co.nz> <20030727020621.A11637@devserv.devel.redhat.com> <20030727104726.GA1313@win.tue.nl> <20030727215545.A21295@devserv.devel.redhat.com> <1059391505.15440.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059391505.15440.12.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 12:25:05PM +0100, Alan Cox wrote:
> On Llu, 2003-07-28 at 02:55, Pete Zaitcev wrote:
> > > Date: Sun, 27 Jul 2003 12:47:26 +0200
> > > From: Andries Brouwer <aebr@win.tue.nl>
> > 
> > > So the culprit is the failing of atkbd_probe().
> > > It does a ATKBD_CMD_GETID, but gets no answer, then a
> > > ATKBD_CMD_SETLEDS, and that command fails.
> > 
> > I see the light now. Somehow I imagined that atkbd code does not call
> > the ->open for the port. Now it all falls into place. Everything works
> > with a bigger timeout.
> 
> Unfortunately with this change several people still report failures

Ach. One bug fixed and the Linux kernel is still not perfect?
What a pity.

[But yes, as I also said to someone else: on i386 one has a working
keyboard after bootup. No initialization and no probing required.
The new keyboard code uses a lot of knowledge about common keyboards
and keyboard controllers. It works in most cases. But already the
linux-kernel readers see a long stream of problems. I am afraid of
the effect on a million Linux users.]

[[On the other hand, as I wrote somewhere else, this is a great way
to learn a lot about very obscure keyboards.]]

