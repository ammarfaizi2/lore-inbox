Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272997AbTHKTmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274907AbTHKTkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:40:39 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:49808 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S274906AbTHKTkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:40:22 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Aug 2003 21:54:22 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       lirc-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811195422.GA25598@bytesex.org>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <20030811183132.GB17777@bytesex.org> <20030811185914.GK2627@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811185914.GK2627@elf.ucw.cz>
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:59:14PM +0200, Pavel Machek wrote:
> Hi!
> 
> Yes, that might be even better. I'd like to have ir drivers at one
> place, but if theres enough advantage the other way...

Yes, there is:  I can just put the IR info into the card database.
The poll thread can go away, instead I can hook gpio readouts into the
IRQ handler.  Probing is just one or two lines in bttv-cards.c, ...

I'll have a look at this tomorrow.

  Gerd

-- 
sigfault
