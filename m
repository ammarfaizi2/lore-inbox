Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTLKJVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTLKJVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:21:09 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:46235
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S264829AbTLKJVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:21:07 -0500
From: Duncan Sands <baldrick@free.fr>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 10:21:05 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101854.44636.baldrick@free.fr> <3FD77766.4060305@pacbell.net>
In-Reply-To: <3FD77766.4060305@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312111021.05518.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 20:43, David Brownell wrote:
> Duncan Sands wrote:
> > On Wednesday 10 December 2003 18:34, David Brownell wrote:
> >>>Unfortunately, usb_physical_reset_device calls usb_set_configuration
> >>>which takes dev->serialize.
> >>
> >>Not since late August it doesn't ...
> >
> > In current 2.5 bitkeeper it does.
>
> usb_physical_reset_device() does not call usb_set_configuration()
> except in the known-broken (for other reasons too!) "firmware changed"
> path.  Known-broken, but not yet removed since nobody has reported
> running into that or the other deadlock; the real fix is force
> re-enumeration of the device.

Still, it could be changed into a call to usb_physical_set_configuration
while we're waiting for a real fix, right?

Ciao,

Duncan.
