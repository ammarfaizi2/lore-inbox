Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbWGNCcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWGNCcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161197AbWGNCcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:32:05 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:9289 "EHLO
	asav10.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1161181AbWGNCcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:32:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KADmdtkSBTw
From: Dmitry Torokhov <dtor@insightbb.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Fwd: Using select in boolean dependents of a tristate symbol
Date: Thu, 13 Jul 2006 22:31:46 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com> <d120d5000607131235r5cc9b558xfd04a1f3118d8124@mail.gmail.com> <Pine.LNX.4.64.0607140033030.12900@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0607140033030.12900@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607132231.46776.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 July 2006 18:58, Roman Zippel wrote:
> Hi,
> 
> On Thu, 13 Jul 2006, Dmitry Torokhov wrote:
> 
> > config THRUSTMASTER_FF
> >       bool "ThrustMaster FireStorm Dual Power 2 support (EXPERIMENTAL)"
> >       depends on HID_FF && EXPERIMENTAL
> > +       select INPUT_FF_MEMLESS
> >       help
> >         Say Y here if you have a THRUSTMASTER FireStore Dual Power 2,
> >         and want to enable force feedback support for it.
> > 
> > Unfortunately this forces INPUT_FF_MEMLESS to always be built-in,
> > although if HID is a module it could be a module as well. Do you have
> > any suggestions as to how allow INPUT_FF_MEMLESS to be compiled as a
> > module?
> 
> You need to directly include HID into the dependencies, only the direct 
> dependencies for config entry are used for the select.
>

Oh, this indeed works, thanks a lot! And I was thinking I would need to
implement something like "select <expr> as <expr>" in kconfig ;)  

-- 
Dmitry
