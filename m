Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVAXRzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVAXRzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVAXRyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:54:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24747 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261559AbVAXRyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:54:01 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Patch to control VGA bus routing and active VGA device.
Date: Mon, 24 Jan 2005 09:53:57 -0800
User-Agent: KMail/1.7.1
Cc: "H.Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <9e47339105011719436a9e5038@mail.gmail.com> <9e473391050122110463d62b5d@mail.gmail.com> <200501240925.51988.jbarnes@engr.sgi.com>
In-Reply-To: <200501240925.51988.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501240953.57943.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 24, 2005 9:25 am, Jesse Barnes wrote:
> On Saturday, January 22, 2005 11:04 am, Jon Smirl wrote:
> > > Well, not all of them, which is why I asked.  Though obviously this
> > > patch will need some very platform specific bits at any rate.
> >
> > What is a case of where the VGA forwarding bit isn't in the bridge
> > control? It's part of the PCI spec to have it.
>
> Hmm... lemme check my specs.  It doesn't look like we support that aspect
> of the PCI spec in our bridges.

Btw, I don't think this is the only chipset that doesn't support the VGA 
routing bit, so new code shouldn't assume that it's ok to access VGA ports 
w/o an offset based on the PCI bus the device is on.

Jesse
