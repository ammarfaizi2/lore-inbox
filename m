Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVATEQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVATEQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVATEQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:16:18 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:3492 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262040AbVATEQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:16:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Daniel Gryniewicz <daniel@gryniewicz.com>
Subject: Re: Linux 2.6.11-rc1
Date: Wed, 19 Jan 2005 23:16:03 -0500
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Peter Osterlund <petero2@telia.com>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <1106168848.22163.10.camel@athena.fprintf.net>
In-Reply-To: <1106168848.22163.10.camel@athena.fprintf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501192316.04173.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 January 2005 16:07, Daniel Gryniewicz wrote:
> On Tue, 2005-01-11 at 21:09 -0800, Linus Torvalds wrote:
> > Ok, the big merges after 2.6.10 are hopefully over, and 2.6.11-rc1 is out 
> > there.
> > 
> <snip>
> 
> > Peter Osterlund:
> >   o input: Add ALPS touchpad driver, driver by Neil Brown, Peter
> >     Osterlund and Dmitry Torokhov, some fixes by Vojtech Pavlik.
> 
> 2.6.11-rc1 broke my ALPS touchpad.  I have a Dell Inspiron 8600, and
> previously, I was patching my kernels with the patch from 
> 
> Message-Id: <200407110045.08208.dtor_core@ameritech.net>
> Subject: [RFT/PATCH 2.6] ALPS touchpad driver
> 
> and this worked fine.  I had the scroll zones and tapping, and so on,
> working fine, and dmesg included indications that the Alps was detected:
> 
> Jan 19 10:09:40 athena alps.c: E6 report: 00 00 64
> Jan 19 10:09:40 athena alps.c: E7 report: 73 02 0a
> Jan 19 10:09:40 athena alps.c: E6 report: 00 00 64
> Jan 19 10:09:40 athena alps.c: E7 report: 73 02 0a
> Jan 19 10:09:40 athena alps.c: Status: 15 01 0a
> Jan 19 10:09:40 athena ALPS Touchpad (Glidepoint) detected
> Jan 19 10:09:40 athena alps.c: Status: 15 01 0a
> Jan 19 10:09:40 athena input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> 
> 

Hi,

Could you please try this patch by Peter Osterlund:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110513688110246&q=raw

It looks like Kensington and ALPS hate each other.

-- 
Dmitry
