Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTDNU6Z (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTDNU6Y (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:58:24 -0400
Received: from fmr03.intel.com ([143.183.121.5]:463 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S263806AbTDNU6V (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:58:21 -0400
Message-ID: <F760B14C9561B941B89469F59BA3A84725A262@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
Date: Mon, 14 Apr 2003 14:09:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> On Llu, 2003-04-14 at 20:07, Grover, Andrew wrote:
> > All I am saying is that on Windows, the driver gets no help 
> from the 
> > BIOS, APM, or ACPI, but yet it restores the video to full working 
> > condition. I understand that this sounds complicated, but 
> since there 
> > is an implementation that already does this then I think we have to 
> > assume it's possible. :) Perhaps we should start with 
> older, simpler 
> > gfx hw, or maybe POST the bios, but only as an interim 
> solution until 
> > gfx drivers get better in this area.
> 
> You might be suprised how much BIOS help they get. Im not at 
> liberty to discuss details but at least two vendors jump into 
> bios space in their ACPI recovery routines.

Which strikes me as kind of silly since guess who called the ACPI resume
vector - the BIOS, so why didn't it do whatever stuff then? :) Anyways
it's not really relevant. The BIOS will never know about add-in cards,
and my contention is that even these can be woken up properly w/o bios
repost (after surmounting technical and potential lack-of-documentation
hurdles, which is why I'd think we would start with an old, ubiquitous,
thouroughly documented video card as our first guinea pig. Matrox
Millennium 2, perhaps?)

I'm not at the point where I can devote time to this yet, so please take
all this with a grain of salt.

Regards -- Andy
