Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbTHKQiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272824AbTHKQg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:36:27 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:37347 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S272816AbTHKQfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:35:43 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Aug 2003 18:39:14 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: Pavel Machek <pavel@suse.cz>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811163913.GA16568@bytesex.org>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <1060607466.5035.8.camel@defiant.flameeyes> <20030811153821.GC2627@elf.ucw.cz> <1060616931.8472.22.camel@defiant.flameeyes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060616931.8472.22.camel@defiant.flameeyes>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gna, why the heck the lirc-list archive on sf.net is broken *right
now*?  Subscribed for now ...

> We can drop /dev/lirc*, and use input events with received codes, but I
> think that lircd is still needed to translate them into userland
> commands...

That translation isn't done by lircd, but by the lirc_client library.
This is no reason for keeping lircd as event dispatcher, the input layer
would do equally well (with liblirc_client picking up events from
/dev/input/event<x> instead of lircd).

  Gerd

-- 
sigfault
