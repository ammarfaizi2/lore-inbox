Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbUJYP1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUJYP1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUJYPY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:24:28 -0400
Received: from web81303.mail.yahoo.com ([206.190.37.78]:11421 "HELO
	web81303.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261979AbUJYPUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:20:33 -0400
Message-ID: <20041025152029.4788.qmail@web81303.mail.yahoo.com>
Date: Mon, 25 Oct 2004 08:20:29 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
To: Stelian Pop <stelian@popies.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for breaking the threading...

Stelian Pop wrote:
> On Mon, Oct 25, 2004 at 03:57:43PM +0200, Vojtech Pavlik wrote:
> 
> > The number is 240 and it's the number of possible PS/2 scancode
> > combinations, and since at this time X can only understand the PS/2
> > protocol (and not native Linux events), this is the only way how to pass
> > keypresses to X.
> >
> > I believe that although this way may be easier, it leads to madness.
> 
> It is also impossible for me to go this way because there is no way
> to put 20+ events between 226 and 240...
> 

I'd say just allocate brand new events for all combinations and do not
worry that the default X keyboard drivers to not get them. There are
already patches in Gentoo adding both keyboard and mouse event support
to X [1] and it is only matter of time ofr other duistributions to pick
it up as well.

I think it is sensible for an supplemental driver (sonypi) to require
some additional support form userspace and not to force itself into
boundaries of a legacy protocol.

-- 
Dmitry

[1] 
http://csociety-ftp.ecn.purdue.edu/pub/gentoo/distfiles/xorg-x11-6.8.0-patches-0.2.5.tar.bz2
Extract patches 9000, 9001 and 9002. Btw, these are not mine - I have
Not even tries them myself but I have read several success stories.

