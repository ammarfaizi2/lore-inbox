Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbUDQUdK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 16:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUDQUdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 16:33:10 -0400
Received: from mail1.kontent.de ([81.88.34.36]:32651 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264043AbUDQUdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 16:33:07 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Sat, 17 Apr 2004 22:33:03 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141229.26677.baldrick@free.fr> <200404172217.10994.baldrick@free.fr>
In-Reply-To: <200404172217.10994.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404172233.03552.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> riddled with races of this kind.  The simplest solution is to
> systematically take ps->dev->serialize when entering the usbfs routines,
> which is what my patches do.  This should be regarded as a first step: it

What is the alternative?

> gives correctness, but at the cost of a probable performance hit.  In later
> steps we can (1) turn dev->serialize into a rwsem

Rwsems are _slower_ in the normal case of no contention.

> (2) push the acquisition of dev->serialize down to the lower levels as they
> are fixed up.

Why?

	Regards
		Oliver

