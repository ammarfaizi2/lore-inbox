Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264994AbUF1PJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbUF1PJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUF1PIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:08:02 -0400
Received: from styx.suse.cz ([82.119.242.94]:32641 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265008AbUF1PGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:06:04 -0400
Date: Mon, 28 Jun 2004 17:07:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/19] New set of input patches
Message-ID: <20040628150736.GA1059@ucw.cz>
References: <20040628145454.9403.qmail@web81305.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628145454.9403.qmail@web81305.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 07:54:53AM -0700, Dmitry Torokhov wrote:
 
> But the flag will not give you atomicity of resetting other fields, like
> pktcount. I guess we can ensure it by carefully rearranging the states
> and what is reset at what point but it is too fragile.
> 
> Would you accept a pair serio_rx_suspend/serio_rx_resume that would still
> take the lock internally but not expose this fact to the driver?

Yes, but don't call them suspend/resume. That sounds too much like
powermanagement, which it isn't. Network uses start/stop. Block layer
uses plug/unplug - in the sense that you have a pipe, and if you don't
want any more data, you plug it.

> > > > > (*) These patches have also been sent to Greg KH.
> > > >
> > > > Did he accept them already?
> > >
> > > No, not yet. He promised to take a look at
> > platoform_device_register_simple by
> > > the end of the week but I guess kernel.bkbits.net troubles might
> > intervene...
> > > And other 2 I just send out today.
> > 
> > Ok. I'll wait then.
> 
> Sysfs changes should be useable even without platform device changes
> and I would like start syncing with you. Would you take patches 2 
> through 10 (I will drop the legacy_position stuff)?
 
Yes.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
