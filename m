Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbTHUNxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTHUNuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:50:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:60290 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262727AbTHUNtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 09:49:01 -0400
Date: Thu, 21 Aug 2003 14:48:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821134854.GA28593@mail.jlokier.co.uk>
References: <20030819194814.A2179@pclin040.win.tue.nl> <Pine.GSO.3.96.1030821125736.2489B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030821125736.2489B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> > My laptop has function buttons that bring me to a setup menu where
> > I can set various timeouts related to power saving. These built-in
> > menus react to translated scancode Set 2 only. There is no way to get
> > out if one first chooses Set 3.

Perhaps the BIOS is listening for translated set 2 scancodes.  Maybe some
different keys would have the power saving functions in other modes?

>  Actually the spec is a standard and standard hardware performs as
> expected (e.g. hardware released by IBM).  The rest is non-standard and if
> a manufacturer claims PS/2-compliance for any of these items, then he
> lies. 

The user doesn't care if it's PS/2 compliant or not.  It must work,
that is the only important thing.  Even more so, given it is flawless

>  Note the translation is done outside the keyboard -- the onboard 8042
> controller is responsible for it.  And it's an obstacle for normal
> operation, most notably you cannot handle hot-plug events as they are
> undistinguishable from a <Shift> release. 

Perhaps you can detect a keyboard being unplugged by periodically
sending it Echo commands (EE), or any other command to which it responds.

-- Jamie
