Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271110AbTHLUr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271112AbTHLUrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:47:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:46740 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S271110AbTHLUrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:47:20 -0400
Date: Tue, 12 Aug 2003 22:47:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 problem
Message-ID: <20030812204714.GC23011@ucw.cz>
References: <20030726093619.GA973@win.tue.nl> <20030726212513.A0BD.CHRIS@heathens.co.nz> <20030727020621.A11637@devserv.devel.redhat.com> <20030727104726.GA1313@win.tue.nl> <20030727215545.A21295@devserv.devel.redhat.com> <1059391505.15440.12.camel@dhcp22.swansea.linux.org.uk> <20030728120743.A15048@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728120743.A15048@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 12:07:43PM -0400, Pete Zaitcev wrote:
> > From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Date: 28 Jul 2003 12:25:05 +0100
> 
> > > > So the culprit is the failing of atkbd_probe().
> > > > It does a ATKBD_CMD_GETID, but gets no answer, then a
> > > > ATKBD_CMD_SETLEDS, and that command fails.
> > > 
> > > I see the light now. Somehow I imagined that atkbd code does not call
> > > the ->open for the port. Now it all falls into place. Everything works
> > > with a bigger timeout.
> > 
> > Unfortunately with this change several people still report failures
> 
> I'm afraid it is to be expected. They have to go through the
> motions of setting DEBUG. Unfortunately, it's not all that
> simple. Messages scroll up and since the keyboard is dead,
> they cannot be returned with Shift-PgUp. I used a serial console.
> I think it's more effort most people are prepared to spend.

An USB keyboard can be very helpful in that case. Or a remote login.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
