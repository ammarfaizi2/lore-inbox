Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWGMKzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWGMKzw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWGMKzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:55:52 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:13168 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751469AbWGMKzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:55:51 -0400
Date: Thu, 13 Jul 2006 12:55:49 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: David Greaves <david@dgreaves.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <liml@rtr.ca>,
       Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.17.3 (What is the next step?)
Message-ID: <20060713105549.GE31644@harddisk-recovery.com>
References: <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan> <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan> <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan> <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan> <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan> <1152545639.27368.137.camel@localhost.localdomain> <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan> <Pine.LNX.4.64.0607110926150.858@p34.internal.lan> <1152634324.18028.21.camel@localhost.localdomain> <44B57373.2030907@dgreaves.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B57373.2030907@dgreaves.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 11:10:59PM +0100, David Greaves wrote:
> Alan Cox wrote:
> > Ar Maw, 2006-07-11 am 09:28 -0400, ysgrifennodd Justin Piszcz:
> >> Alan/Jeff/Mark,
> >>
> >> Is there anything else I can do to further troubleshoot this problem now 
> >> that we have the failed opcode(s)?  Again, there is never any corruption 
> >> on these drives, so it is more of an annoyance than anything else.
> > 
> > Nothing strikes me so far other than the data not making sense. Possibly
> > it will become clearer later if/when we see other examples.
> 
> For me it's SMART related.
> 
> smartctl -data -o on /dev/sda reliably gets a similar message.
> Justin - does this smartctl command trigger a message for you?

In that case SMART just isn't enabled. smartctl -d ata --smart=on
/dev/sda should make those messages go away.

Some BIOSes have a setting to enable/disable SMART, though the option
is usually badly documented (hey, what do you expect from BIOS
writers).


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
