Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUGOVqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUGOVqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266378AbUGOVqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:46:55 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:45787 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266376AbUGOVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:46:50 -0400
Date: Thu, 15 Jul 2004 23:46:47 +0200
From: David Weinehall <tao@debian.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040715214646.GK22472@khan.acc.umu.se>
Mail-Followup-To: Florian Weimer <fw@deneb.enyo.de>,
	linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <87oemhot7l.fsf@deneb.enyo.de> <20040715213711.GJ22472@khan.acc.umu.se> <87acy1osk1.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acy1osk1.fsf@deneb.enyo.de>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 11:43:10PM +0200, Florian Weimer wrote:
> * David Weinehall:
> 
> >> Oh.  My expriences, starting with 2.6.7 with ACPI, are as following:
> >> 
> >>   - Suspend to RAM is triggered, for example by closing the lid.
> >> 
> >>   - If it's under X11, the system does not come back.  Display powers
> >>     up, but it remains black.  There is some HDD activity, so it's
> >>     probably still running.  Next time I should check if the IP stack
> >>     is still running.
> >> 
> >>   - After terminating the X11 server, other devices on the sharded IRQ
> >>     11 are dead (most prominently, e1000 and USB).
> >> 
> >> This is a T40p.  Behavior with 2.6.8-rc1 is apparently the same.
> >> 
> >> Any ideas what to try next?
> >
> > Try unloading ehci_hcd before suspend.
> 
> It's not loaded anyway, for some reason (the external USB mouse is
> working nevertheless).

Yeah, it's using uhci_hcd instead...

Strange.  suspend works for me (T40 though, not T40p), latest
BIOS-version, ACPI enabled, APM disabled.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
