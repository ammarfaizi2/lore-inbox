Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTDHIaa (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 04:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTDHIaa (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 04:30:30 -0400
Received: from smtp-out.bhp.t-online.de ([195.145.119.39]:22836 "EHLO
	smtp-out.bhp.t-online.de") by vger.kernel.org with ESMTP
	id S261392AbTDHIa3 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 04:30:29 -0400
Date: Tue, 08 Apr 2003 11:42:15 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
In-reply-to: <1049790892.18045.120.camel@passion.cambridge.redhat.com>
To: David Woodhouse <dwmw2@infradead.org>,
       =?utf-8?q?J=C3=B6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-mtd@lists.infradead.org, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Reply-to: tglx@linutronix.de
Message-id: <200304081142.15852.tglx@linutronix.de>
Organization: linutronix
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
User-Agent: KMail/1.4.1
References: <20030407171037.GB8178@wohnheim.fh-wedel.de.suse.lists.linux.kernel>
 <20030407194039.GF8178@wohnheim.fh-wedel.de>
 <1049790892.18045.120.camel@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 April 2003 10:34, David Woodhouse wrote:
> On Mon, 2003-04-07 at 20:40, Jörn Engel wrote:
> > Some more partitioning code that only applies to spinning discs of
> > some sort (ide, scsi) or code that emulates spinning discs is always
> > included. No config option.
>
> We definitely want CONFIG_BLK_DEV. CONFIG_SWAP is a good start.
>
> > Another one is serial.c. In an ltp test run, plus serial console, some
> > 90% were unused. And the code gave me some shivers. Volunteers?
>
> The new serial code is somewhat nicer. Still contains unconditional
> support for a lot of bizarre 8250 variations, but I don't think that's
> really taking up much space though.
This driver should really supersede the ugly drivers/char/serial.c. And its 
definitly usefull for all embedded systems, not only for x86 based stuff.

-- 
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

