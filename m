Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVATEsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVATEsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVATEsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:48:50 -0500
Received: from relay00.pair.com ([209.68.1.20]:24325 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262045AbVATEsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:48:47 -0500
X-pair-Authenticated: 66.134.112.218
Subject: Re: Linux 2.6.11-rc1
From: Daniel Gryniewicz <daniel@gryniewicz.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Peter Osterlund <petero2@telia.com>
In-Reply-To: <200501192316.04173.dtor_core@ameritech.net>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
	 <1106168848.22163.10.camel@athena.fprintf.net>
	 <200501192316.04173.dtor_core@ameritech.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jan 2005 23:49:13 -0500
Message-Id: <1106196553.11875.2.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.3.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 23:16 -0500, Dmitry Torokhov wrote:
> On Wednesday 19 January 2005 16:07, Daniel Gryniewicz wrote:
> > On Tue, 2005-01-11 at 21:09 -0800, Linus Torvalds wrote:
> > > Ok, the big merges after 2.6.10 are hopefully over, and 2.6.11-rc1 is out 
> > > there.
> > > 
> > <snip>
> > 
> > > Peter Osterlund:
> > >   o input: Add ALPS touchpad driver, driver by Neil Brown, Peter
> > >     Osterlund and Dmitry Torokhov, some fixes by Vojtech Pavlik.
> > 
> > 2.6.11-rc1 broke my ALPS touchpad.  I have a Dell Inspiron 8600, and
> > previously, I was patching my kernels with the patch from 
> > 
> > Message-Id: <200407110045.08208.dtor_core@ameritech.net>
> > Subject: [RFT/PATCH 2.6] ALPS touchpad driver
> > 
> > and this worked fine.  I had the scroll zones and tapping, and so on,
> > working fine, and dmesg included indications that the Alps was detected:
> > 
> > Jan 19 10:09:40 athena alps.c: E6 report: 00 00 64
> > Jan 19 10:09:40 athena alps.c: E7 report: 73 02 0a
> > Jan 19 10:09:40 athena alps.c: E6 report: 00 00 64
> > Jan 19 10:09:40 athena alps.c: E7 report: 73 02 0a
> > Jan 19 10:09:40 athena alps.c: Status: 15 01 0a
> > Jan 19 10:09:40 athena ALPS Touchpad (Glidepoint) detected
> > Jan 19 10:09:40 athena alps.c: Status: 15 01 0a
> > Jan 19 10:09:40 athena input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> > 
> > 
> 
> Hi,
> 
> Could you please try this patch by Peter Osterlund:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110513688110246&q=raw
> 
> It looks like Kensington and ALPS hate each other.
> 

That fixed it, thanks.  I hope this can make it in before 2.6.11 final,
but if it doesn't, I'll just patch it in.

Daniel
