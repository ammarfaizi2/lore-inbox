Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTLIWHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 17:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTLIWHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 17:07:09 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:56449
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S263088AbTLIWHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 17:07:06 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Tue, 9 Dec 2003 23:07:04 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <Pine.LNX.4.44L0.0312091638140.7053-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312091638140.7053-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092307.04924.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not at all clear how that could happen.  Those pointers are located
> in static data in the HCD modules.  It doesn't seem likely that the
> pointer was overwritten.  The only other possibility I can think of is
> that the module was already unloaded.  But that's not possible since you
> were holding a reference to a device on that bus.

It occurred on system shutdown - so I guess the module was unloaded.
Maybe the bus reference counting is borked.  I've sent Vince a patch that
should produce some more info.

> Maybe the answer is that hcd->driver is messed up but for some reason
> still points to actual data.  I can't imagine why that would happen
> either.

Me neither.

Duncan.
