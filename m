Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUHKUGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUHKUGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268209AbUHKUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:06:52 -0400
Received: from mail1.kontent.de ([81.88.34.36]:42209 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268206AbUHKUGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:06:49 -0400
Date: Wed, 11 Aug 2004 22:06:47 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, "David N. Welton" <davidw@eidetix.com>,
       James Lamanna <jamesl@appliedminds.com>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040811200647.GA864@kenny.sha-bang.local>
References: <4112A626.1000706@appliedminds.com> <41133FE1.2040906@eidetix.com> <20040808121837.GA912@kenny.sha-bang.local> <200408081005.14832.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408081005.14832.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 10:05:14AM -0500, Dmitry Torokhov wrote:
> On Sunday 08 August 2004 07:18 am, Sascha Wilde wrote:
> > 
> > I just did some further testing, the problem here is exactly the same
> > as Davids.  And thinking about the exact point of failure and that
> > Davids reboot problem is related to the keyboard being attached or not
> > I realized what causes the problems for me:
> > 
> > I have a keyboard attached to the PS/2 port, but my mouse is attached
> > to USB.  So I pluged in a PS/2 mouse, and guess what?  The box
> > rebooted!
> > 
> > Well, this is by no means a solution, but I think it's pretty clear
> > now, what exactly causes the trouble.  Now we have to find out, why
> > the i8042 code in 2.6.x breaks things on sertain hardware when there
> > are not devices present in all ports, while in 2.4.x everything went
> > well... 
> > 
> 
> You could also try out the following scenario: remove your USB mouse and
> _do not_ plug PS/2 one... What you might be seeing is another case of USB
> Legacy emulation thingy getting in your way.

Just tried it, but I can't see anything special -- keyboard works and
the box hangs on reboot, everything as usual...

cheers
sascha
-- 
Sascha Wilde
"Gimme about 10 seconds to think for a minute..."
