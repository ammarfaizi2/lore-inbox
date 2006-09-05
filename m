Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWIEQEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWIEQEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWIEQEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:04:38 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.8]:54279 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S965150AbWIEQEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:04:37 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.18-rc6
Date: Tue, 5 Sep 2006 17:04:41 +0100
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Jeremy Roberson <jroberson@gtcocalcomp.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <20060904223153.GK13238@bayes.mathematik.tu-chemnitz.de> <200609042017.03515.gene.heskett@verizon.net>
In-Reply-To: <200609042017.03515.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609051704.41576.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 September 2006 01:17, Gene Heskett wrote:
> On Monday 04 September 2006 18:31, Steffen Klassert wrote:
> >On Mon, Sep 04, 2006 at 07:05:53AM -0400, Gene Heskett wrote:
> >> On Sunday 03 September 2006 22:42, Linus Torvalds wrote:
> >> >Things are definitely calming down, and while I'm not ready to call it
> >> > a final 2.6.18 yet, this migt be the last -rc.
> >>
> >> It has one new build warning, no idea if show stopper or not:
> >> ----------
> >> drivers/usb/input/hid-core.c:1447:1: warning: "USB_DEVICE_ID_GTCO_404"
> >> redefined
> >> drivers/usb/input/hid-core.c:1446:1: warning: this is the location of
> >> the previous definition
> >> ----------
> >> until after I boot to it...
> >>
> >> And that didn't seem to effect the mouse.  Other usb stuff has not been
> >> exersized yet.
> >
> >The offending patch is
> >hid-core.c: Adds all GTCO CalComp Digitizers and InterWrite School
> > Products to blacklist
[snip]
> Sep  3 19:27:17 coyote kernel: usb 3-2.1: reset low speed USB device using
> ohci_hcd and address 3
> Sep  3 19:35:45 coyote kernel: usb 3-2.1: reset low speed USB device using
> ohci_hcd and address 3

Might not be a kernel problem, userspace might be using libusb and calling 
usb_reset() on the device. Try dropping out of X11 and see if it still 
happens.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
